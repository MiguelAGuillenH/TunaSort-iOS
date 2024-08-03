//
//  LoginViewController.swift
//  TunaSort iOS
//
//  Created by MAGH on 19/06/24.
//

import UIKit

var spotifyToken: String?
var spotifyUserId: String?

class LoginViewController: UIViewController, SPTSessionManagerDelegate, SPTAppRemoteDelegate {
    
    //MARK: - UI Variables

    @IBOutlet weak var playmentIcon: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Spotify variables
    
    lazy var configuration = SPTConfiguration(
        clientID: Constants.SPOTIFY_CLIENT_ID,
        redirectURL: Constants.SPOTIFY_REDIRECT_URL
    )
    
    lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
    }()
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    
    //MARK: - Other variables
    
    var loginManager = LoginManager()

    //MARK: - UI Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up animation
        playmentIcon.animationImages = Constants.ANIM_PLAYMENT
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loginButton.setTitle("Signing in...", for: .disabled)
        loginButton.isEnabled = false
        
        let spotifyCheckUrl = URL(string: "spotify://")!
        
        if UIApplication.shared.canOpenURL(spotifyCheckUrl) {
            sessionManager.initiateSession(with: Constants.SCOPES, options: .clientOnly, campaign: nil)
        } else {
            self.presentAlertController(title: "Alerta de inicio de sesión", message: "Debido a que no tienes instalada la aplicación de Spotify, no te será posible utilizar TunaSort a su máxima capacidad. Puedes explorar la aplicación, pero te recomendamos instalar Spotify e iniciar sesión.", buttonTitle: "Entendido") { _ in
                self.playmentIcon.startAnimating()
                self.loginManager.alternateLogin() { error in
                    //DispatchQueue.main.async {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.playmentIcon.stopAnimating()
                        self.loginButton.isEnabled = true
                        
                        if error != nil {
                            self.presentAlertController(title: "Error al iniciar sesión", message: error!, buttonTitle: "Continuar")
                        } else if spotifyToken == nil {
                            self.presentAlertController(title: "Error al iniciar sesión", message: "No se logró obtener el token de acceso.", buttonTitle: "Continuar")
                        } else {
                            print ("TOKEN = \(spotifyToken ?? "NULL")")
                            self.loginManager.getUserId() { error in
                                DispatchQueue.main.async {
                                    if error != nil {
                                        self.presentAlertController(title: "Error al obtener usuario", message: error!, buttonTitle: "Continuar") { _ in
                                            DispatchQueue.main.async {
                                                self.performSegue(withIdentifier: "loginToModeSelectionSegue", sender: self)
                                            }
                                        }
                                    } else if spotifyUserId == nil {
                                        self.presentAlertController(title: "Error al obtener usuario", message: "No se logró obtener el id de usuario.", buttonTitle: "Continuar") { _ in
                                            DispatchQueue.main.async {
                                                self.performSegue(withIdentifier: "loginToModeSelectionSegue", sender: self)
                                            }
                                        }
                                    } else {
                                        self.performSegue(withIdentifier: "loginToModeSelectionSegue", sender: self)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - SPTSessionManagerDelegate
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        appRemote.connectionParameters.accessToken = session.accessToken
        appRemote.connect()
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        presentAlertController(title: "Authorization Failed", message: error.localizedDescription, buttonTitle: "Bummer")
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        presentAlertController(title: "Session Renewed", message: session.description, buttonTitle: "Sweet")
    }
    
    // MARK: - SPTAppRemoteDelegate
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        loginButton.isEnabled = true
        spotifyToken = appRemote.connectionParameters.accessToken
        self.loginManager.getUserId() { error in
            DispatchQueue.main.async {
                if error != nil {
                    self.presentAlertController(title: "Error al obtener usuario", message: error!, buttonTitle: "Continuar")
                } else if spotifyUserId == nil {
                    self.presentAlertController(title: "Error al obtener usuario", message: "No se logró obtener el id de usuario.", buttonTitle: "Continuar")
                } else {
                    self.performSegue(withIdentifier: "loginToModeSelectionSegue", sender: self)
                }
            }
        }
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        loginButton.isEnabled = true
        self.presentAlertController(title: "Error al iniciar sesión", message: error?.localizedDescription ?? "Unknown connection error", buttonTitle: "Ok")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        //loginButton.isEnabled = true
        //self.presentAlertController(title: "Error al iniciar sesión", message: error?.localizedDescription ?? "Unknown disconnect error", buttonTitle: "Ok")
    }

}

