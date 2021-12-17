<h2 align="center">CovPass / CovPass Check</h2>

<br />

<p align="center">
  <a href="#">
    <img src="Resources/CovPass.png" alt="CovPass Icon" width="80" height="80">
  </a>
  <p align="center">
    <b>Einfach. Sicher. Papierlos.</b><br>
    Mit der CovPass-App können Bürgerinnen und Bürger ihre Corona-Impfungen direkt auf das Smartphone laden und mit dem QR-Code belegen
  </p>
</p>

> :warning: Dies ist eine Version, welche die Pässe modifiziert darstellt. Der Fehler kann neben genauem Vergleichen mit den Details der Pässe nur durch Scannen des QR-Codes festgestellt werden.
> 
> **Wann werden Betriebe endlich dazu verpflichtet, bei digitalen Impfpässen, diese auch zu überprüfen - also richtig zu überprüfen?!**
> 
> Ein *"ist ja die CovPass-App und da steht alles ist gut"* reicht nicht aus! Alles um den QR-Code herum ist kein tatsächlicher Nachweis der der Impfung, sondern nur eine Darstellung der im QR-Code befindlichen Daten! Nur der QR-Code ist der tatsächliche Nachweis!


## Requirements

- iOS 12.0 or later
- Xcode 12 or later

## Installation

### Configuration

Before you build the project, you need to copy the configuration files with `./Scripts/copy-config-files.sh` and the parameter `debug`, or `release`. The configuration files contain public key, TLS certificate, and the initial DSC file.

## Application

### CovPass

CovPass contains the app project for the CovPass app.

### CovPassCheck

CovPassCheck contains the app project for the CovPassCheck app.

### CovPassUI

CovPassUI is the UI package for both apps and contains common UI components and flows, like the onboarding screens.

### CovPassCommon

CovPassCommon contains the business logic for both apps, like QR code parsing, signature validation, and persistence.

API documentation TBD
