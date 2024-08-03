//
//  LoginManager.swift
//  TunaSort iOS
//
//  Created by MAGH on 29/07/24.
//

import Foundation

class LoginManager {
    
    func alternateLogin(completion: @escaping (String?) -> Void) {
        SpotifyRepository.shared.alternateLogin() { data, response, error in
            
            //Check error
            if error != nil {
                completion(error!.localizedDescription)
                return
            }
            
            // Check response
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode != 200 {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponseDTO.self, from: data!)
                    var errorString: String?
                    if errorResponse.error?.status != nil {
                        errorString = "Status \(errorResponse.error!.status!). "
                    }
                    if errorResponse.error?.message != nil && !(errorResponse.error!.message!.isEmpty) {
                        errorString = "\(errorString ?? "")\(errorResponse.error!.message!)"
                    } else {
                        errorString = "\(errorString ?? "")Unknown API error."
                    }
                    completion(errorString)
                    return
                } catch {
                    completion(error.localizedDescription)
                    return
                }
            }
            
            // Check  data
            if data == nil {
                completion("No data received")
                return
            }
            
            //Parse data
            do {
                let loginResponse = try JSONDecoder().decode(AlternateLoginResponseDTO.self, from: data!)
                spotifyToken = loginResponse.accessToken
            } catch {
                completion(error.localizedDescription)
                return
            }
            
            completion(nil)
            return
            
        }
    }

    func getUserId(completion: @escaping (String?) -> Void) {
        SpotifyRepository.shared.getCurrentUserProfile() { data, response, error in
            
            //Check error
            if error != nil {
                completion(error!.localizedDescription)
                return
            }
            
            // Check response
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode != 200 {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponseDTO.self, from: data!)
                    var errorString: String?
                    if errorResponse.error?.status != nil {
                        errorString = "Status \(errorResponse.error!.status!). "
                    }
                    if errorResponse.error?.message != nil && !(errorResponse.error!.message!.isEmpty) {
                        errorString = "\(errorString ?? "")\(errorResponse.error!.message!)"
                    } else {
                        errorString = "\(errorString ?? "")Unknown API error."
                    }
                    completion(errorString)
                    return
                } catch {
                    completion(error.localizedDescription)
                    return
                }
            }
            
            // Check  data
            if data == nil {
                completion("No data received")
                return
            }
            
            //Parse data
            do {
                let user = try JSONDecoder().decode(UserDTO.self, from: data!)
                spotifyUserId = user.id
            } catch {
                completion(error.localizedDescription)
                return
            }
            
            completion(nil)
            return
            
        }
    }
    
}


