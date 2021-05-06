//
//  OnboardingPageViewModel.swift
//
//
//  Copyright © 2021 IBM. All rights reserved.
//

import UIKit
import VaccinationUI

class ValidationOnboardingPageViewModel: OnboardingPageViewModel {
    weak var delegate: ViewModelDelegate?
    var type: OnboardingPageViewModelType

    init(type: OnboardingPageViewModelType) {
        self.type = type
    }

    var image: UIImage? {
        switch self.type {
        case .page1:
            return .illustration2
        case .page2:
            return .illustration3
        default:
            return nil
        }
    }

    var title: String {
        switch self.type {
        case .page1:
            return "validation_first_onboarding_page_title".localized
        case .page2:
            return "validation_second_onboarding_page_title".localized
        default:
            return ""
        }
    }

    var info: String {
        switch self.type {
        case .page1:
            return "validation_first_onboarding_page_message".localized
        case .page2:
            return "validation_second_onboarding_page_message".localized
        default:
            return ""
        }
    }
}

