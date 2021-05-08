//
//  CertificateRouter.swift
//
//
//  Copyright © 2021 IBM. All rights reserved.
//

import PromiseKit
import UIKit
import VaccinationUI

class VaccinationDetailRouter: VaccinationDetailRouterProtocol, DialogRouterProtocol {
    // MARK: - Properties

    let sceneCoordinator: SceneCoordinator

    // MARK: - Lifecycle

    init(sceneCoordinator: SceneCoordinator) {
        self.sceneCoordinator = sceneCoordinator
    }

    // MARK: - Methods

    func showScanner() -> Promise<ScanResult> {
        sceneCoordinator.present(
            ScanSceneFactory()
        )
    }

    func showCertificateOverview() {
        sceneCoordinator.pop()
    }

    func showErrorDialog() {
        showDialog(
            title: "error_standard_unexpected_title".localized,
            message: "error_standard_unexpected_message".localized,
            actions: [DialogAction(title: "error_connect_to_internet_Button_ok".localized)],
            style: .alert
        )
    }
}
