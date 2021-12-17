//
//  CertificateCardViewModel.swift
//
//
//  © Copyright IBM Deutschland GmbH 2021
//  SPDX-License-Identifier: Apache-2.0
//

import CovPassCommon
import CovPassUI
import UIKit

class CertificateCardViewModel: CertificateCardViewModelProtocol {
    // MARK: - Private Properties

    private var token: ExtendedCBORWebToken
    private var certificateIsFavorite: Bool
    private var onAction: (ExtendedCBORWebToken) -> Void
    private var onFavorite: (String) -> Void
    private var repository: VaccinationRepositoryProtocol
    private var boosterLogic: BoosterLogic
    private var certificate: DigitalGreenCertificate {
        token.vaccinationCertificate.hcert.dgc
    }

    // Show notification to the user if he is qualified for a booster vaccination
    private var showNotification: Bool {
        guard let boosterCandidate = boosterLogic.checkCertificates([token]) else { return false }
        return boosterCandidate.state == .new
    }

    // MARK: - Lifecycle

    init(
        token: ExtendedCBORWebToken,
        isFavorite: Bool,
        showFavorite: Bool,
        onAction: @escaping (ExtendedCBORWebToken) -> Void,
        onFavorite: @escaping (String) -> Void,
        repository: VaccinationRepositoryProtocol,
        boosterLogic: BoosterLogic
    ) {
        self.token = token
        certificateIsFavorite = isFavorite
        self.showFavorite = showFavorite
        self.onAction = onAction
        self.onFavorite = onFavorite
        self.repository = repository
        self.boosterLogic = boosterLogic
    }

    // MARK: - Internal Properties

    var delegate: ViewModelDelegate?

    var reuseIdentifier: String {
        "\(CertificateCollectionViewCell.self)"
    }

    var backgroundColor: UIColor {
        if token.vaccinationCertificate.isExpired || token.vaccinationCertificate.isInvalid {
            return .onBackground40
        }
        if certificate.r != nil {
            return .brandAccentBlue
        }
        if certificate.t != nil {
            return .brandAccentPurple
        }
        return vaccinationCertificateIsValidNow ? .onBrandAccent70 : .onBackground50
    }

    private var vaccinationCertificateIsValidNow: Bool {
        certificate.v?.first?.fullImmunizationValid ?? false
    }

    var iconTintColor: UIColor {
        return backgroundColor == UIColor.onBackground50 ? .neutralBlack : .neutralWhite
    }

    var textColor: UIColor {
        return backgroundColor == UIColor.onBackground50 ? .neutralBlack : .neutralWhite
    }

    var title: String {
        if certificate.r != nil {
            return "certificates_overview_recovery_certificate_title".localized
        }
        if let t = certificate.t?.first {
            return t.isPCR ? "certificates_overview_pcr_test_certificate_message".localized : "certificates_overview_test_certificate_message".localized
        }
        return "certificates_overview_vaccination_certificate_title".localized
    }

    var subtitle: String {
        let date = Calendar.current.date(byAdding: .month, value: -2, to: Date()) ?? Date()
        return String(format: "vaccination_start_screen_qrcode_complete_protection_subtitle".localized, DateUtils.displayDateFormatter.string(from: date))
    }

    var titleIcon: UIImage {
        return UIImage.startStatusFullWhite
        //return UIImage.startStatusFullBlue
    }

    var isFavorite: Bool {
        certificateIsFavorite
    }

    var isExpired: Bool {
        return false
    }

    var isBoosted: Bool {
        return true
    }

    // Hide favorite button if this certificate is the only card that is shown
    var showFavorite: Bool = true

    var qrCode: UIImage? {
        //return "fake_certificate_qr_code_content".localized.generateQRCode()
        return "fake_certificate_qr_code_content_long".localized.generateQRCode()
        //return token.vaccinationQRCodeData.generateQRCode()
    }

    var name: String {
        certificate.nam.fullName
    }

    var actionTitle: String {
        "vaccination_full_immunization_action_button".localized
    }

    var tintColor: UIColor {
        return textColor
    }

    var isFullImmunization: Bool {
        return true
    }

    var vaccinationDate: Date? {
        certificate.v?.first?.dt
    }

    // MARK: - Actions

    func onClickAction() {
        onAction(token)
    }

    func onClickFavorite() {
        onFavorite(certificate.uvci)
    }
}
