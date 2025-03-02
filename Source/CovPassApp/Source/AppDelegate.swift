//
//  AppDelegate.swift
//
//  © Copyright IBM Deutschland GmbH 2021
//  SPDX-License-Identifier: Apache-2.0
//

import CovPassCommon
import CovPassUI
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var sceneCoordinator: DefaultSceneCoordinator?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        try? setupKeychain()
        try? UIFont.loadCustomFonts()

        guard NSClassFromString("XCTest") == nil else { return true }

        let window = UIWindow(frame: UIScreen.main.bounds)
        let sceneCoordinator = DefaultSceneCoordinator(window: window)
        let mainScene = MainSceneFactory(sceneCoordinator: sceneCoordinator)
        sceneCoordinator.asRoot(mainScene)
        window.rootViewController = sceneCoordinator.rootViewController
        window.makeKeyAndVisible()
        self.window = window
        self.sceneCoordinator = sceneCoordinator

        #if targetEnvironment(simulator)
            FileManager.default.printFileLocations()
        #endif
        return true
    }

    private func setupKeychain() throws {
        if !UserDefaults.StartupInfo.bool(.appInstalled) {
            // clearKeychainOnFreshInstall
            UserDefaults.StartupInfo.set(true, forKey: .appInstalled)
            try KeychainPersistence().deleteAll()
        } else {
            try KeychainPersistence.migrateKeyAttributes()
        }
    }

    func applicationWillResignActive(_: UIApplication) {
        BackgroundUtils.addHideView(to: window, image: UIImage(named: "CovPass"))
    }

    func applicationDidBecomeActive(_: UIApplication) {
        BackgroundUtils.removeHideView(from: window)
    }
}
