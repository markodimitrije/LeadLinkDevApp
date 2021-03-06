//
//  DisclaimerResponseFactory.swift
//  LeadLinkApp
//
//  Created by Marko Dimitrijevic on 29/01/2020.
//  Copyright © 2020 Marko Dimitrijevic. All rights reserved.
//

import Foundation

protocol DisclaimerResponseFactoryProtocol {
    func make(json: [String: Any]?) -> DisclaimerResponseProtocol?
}

struct DisclaimerResponseFactory: DisclaimerResponseFactoryProtocol {
    func make(json: [String: Any]?) -> DisclaimerResponseProtocol? {
        return DisclaimerResponse(json: json)
    }
}
