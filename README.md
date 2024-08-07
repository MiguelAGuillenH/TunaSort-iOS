# TunaSort for iOS

## Objetivo del app

TunaSort es un proyecto para generación de playlist personalizadas en Spotify, permitiendo al usuario interactuar con la API de Spotify a través de una interfaz simple. 

## Descripción del logo y lo que representa

![Image](https://snipboard.io/B8S2tQ.jpg)

El ícono es una onda de sonido estilizada, que representa la música a organizar a través de la aplicación.

## Justificación de la elección del tipo de dispositivo, versión del sistema operativo y las orientaciones soportadas.

Se decidió soportar iPlhones a partir de la versión de iOS 16.2, que nos permite abarcar más del 90% de los dispositivos en el público. Respecto a las orientaciones soportadas, se seleccionó soportar solamente la orientación vertical, ya que permite una visualización de los elementos de las playlist de una forma que una orientación horizontal no lo permite.

## Credenciales para poder acceder al app

Para acceder a la app, se requiere tener instalada la aplicación de Spotify y haber ingresado en ella con una cuenta. En caso de no tener Spotify, la aplicación lo notificará y permitirá el acceso, pero no se podrán realizar acciones como generar playlist de lo más escuchado, o guardar playlists.

En caso de ejecutar la app en el simulador de xCode, se puede acceder a toda la aplicación asignando un token válido (como el generado en la aplicación de Android) a la variable `spotifyToken`.

### Proceso de asignación de token de Android en iOS
  
Una vez que se haya ejecutado la app en Android Studio y se haya ingresado a la misma con una cuenta de Spotify, se imprime en el Logcat el token de acceso obtenido.

![Image](https://snipboard.io/n98y5C.jpg)

En xCode, tras ejecutar la aplicación y solicitar el acceso, el código se detendrá en la linea 73 del archivo LoginViewController.swift.

![Image](https://snipboard.io/AZ38Ek.jpg)

En consola, escribir el siguiente código: `e spotifyToken="ACCESS_TOKEN"`, reemplazando `ACCESS_TOKEN` por el token obtenido en Android Studio, y presionar Enter. Si se deja correr el código, se muestra en consola el valor de la varaible `spotifyToken`. Si se realizó correctamente el proceso, mostrará el token que acabamos de asignar.

![Image](https://snipboard.io/q9RAhe.jpg)

## Dependencias del proyecto

  * SpotifyiOS
  * SDWebFormat
  * AVFoundation
