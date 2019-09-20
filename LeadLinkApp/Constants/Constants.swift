//
//  Constants.swift
//  LeadLinkApp
//
//  Created by Marko Dimitrijevic on 14/03/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct Constants {
    struct BtnTitles {
        static let logIn = NSLocalizedString("Strings.Login.btn", comment: "")
        static let logOut = NSLocalizedString("Strings.Logout.btn", comment: "")
        static let stats = NSLocalizedString("Strings.Stats.btn", comment: "")
    }
    struct TimeInterval {
        static let reportUnsyncBarcodesEvery = 60.0 * 5 // 5 min
    }
}

extension Constants {
    struct AlertInfo {
        static let ok = NSLocalizedString("AlertInfo.ok", comment: "")
        static let cancel = NSLocalizedString("AlertInfo.cancel", comment: "")
        struct ScanningNotSupported {
            static let title = NSLocalizedString("AlertInfo.Scan.ScanningNotSupported.title", comment: "")
            static let msg = NSLocalizedString("AlertInfo.Scan.ScanningNotSupported.msg", comment: "")
        }
        struct NoSettings {
            static let title = NSLocalizedString("AlertInfo.Scan.NoSettings.title", comment: "")
            static let msg = NSLocalizedString("AlertInfo.Scan.NoSettings.msg", comment: "")
        }
        struct Permission {
            static let title = NSLocalizedString("AlertInfo.Permission.title", comment: "")
            static let subtitle = NSLocalizedString("AlertInfo.Permission.subtitle", comment: "")
            static let cancel = NSLocalizedString("AlertInfo.Option.cancel", comment: "")
            static let agree = NSLocalizedString("AlertInfo.Option.agree", comment: "")
        }
        struct NoCodeDetected {
            static let title = NSLocalizedString("AlertInfo.Scan.NoCodeDetected.title", comment: "")
            static let msg = NSLocalizedString("AlertInfo.Scan.NoCodeDetected.msg", comment: "")
        }
        struct logout {
            //AlertInfo.Logout.title, AlertInfo.Logout.btnTitle.logout, AlertInfo.Logout.btnTitle.cancel
            static let title = NSLocalizedString("AlertInfo.Logout.title", comment: "")
            static let logoutBtnTitle = NSLocalizedString("AlertInfo.Logout.btnTitle.logout", comment: "")
            static let cancelBtnTitle = NSLocalizedString("AlertInfo.cancel", comment: "")
        }
        struct questionsFormNotValid {
            static let title = NSLocalizedString("AlertInfo.QuestionsAnswers.FormNotValid.title", comment: "")
            static let msg = NSLocalizedString("AlertInfo.QuestionsAnswers.FormNotValid.msg", comment: "")
        }
        struct readingCampaignsError {
            static let title = NSLocalizedString("AlertInfo.Campaigns.CantReadResponse.title", comment: "")
            static let msg = NSLocalizedString("AlertInfo.Campaigns.CantReadResponse.msg", comment: "")
        }
        struct noCampaignsError {
            static let title = NSLocalizedString("AlertInfo.Campaigns.Empty.title", comment: "")
            static let msg = NSLocalizedString("AlertInfo.Campaigns.Empty.msg", comment: "")
        }
    }
    struct Disclaimer {
        static let title = NSLocalizedString("Disclaimer.title", comment: "")
        static let text = NSLocalizedString("Disclaimer.text", comment: "")
        static let disagree = NSLocalizedString("Disclaimer.disagree", comment: "")
        static let agree = NSLocalizedString("Disclaimer.agree", comment: "")
    }
    
    struct TermsNoSwitch {
        static let eraText = NSLocalizedString("TermsNoSwitch.era.text", comment: "")
        static let navusText = NSLocalizedString("TermsNoSwitch.navus.text", comment: "")
    }
    
    struct TermsAndConditions {
        static let url = "https://service.e-materials.com/storage/resources/era_edta/ter/terms_and_conditions_app.pdf"
    }
    
    struct PrivacyPolicy {
        static let url = "https://service.e-materials.com/storage/resources/era_edta/coo/Privacy_Policy.pdf"
        static let navusUrl =  "https://www.navus.io/wp-content/uploads/2019/04/Privacy-and-Cookies-Policy-Navus_March_26_2019.pdf"
        
        static let hyperLinkPolicyText = "Privacy Policy"
        static let navusHyperLinkPolicyText = "Navus Privacy Policy"
    }
}

extension Constants {
    struct Campaign {
        static let defaultName = NSLocalizedString("Strings.Campaign.defaultName", comment: "")
        static let defaultDesc = NSLocalizedString("Strings.Campaign.defaultDesc", comment: "")
    }
}
