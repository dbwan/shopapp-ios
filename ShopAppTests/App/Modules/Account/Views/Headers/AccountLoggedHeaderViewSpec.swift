//
//  AccountLoggedHeaderViewSpec.swift
//  ShopAppTests
//
//  Created by Radyslav Krechet on 3/6/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import AvatarImageView
import Nimble
import Quick
import ShopApp_Gateway

@testable import ShopApp

class AccountLoggedHeaderViewSpec: QuickSpec {
    override func spec() {
        var view: AccountLoggedHeaderView!
        var welcomeLabel: UILabel!
        var customerNameLabel: UILabel!
        var customerImageView: AvatarImageView!
        
        beforeEach {
            let customer = Customer()
            customer.firstName = "First"
            customer.lastName = "Last"
            
            view = AccountLoggedHeaderView(frame: CGRect.zero, customer: customer)
            
            welcomeLabel = self.findView(withAccessibilityLabel: "welcome", in: view) as! UILabel
            customerNameLabel = self.findView(withAccessibilityLabel: "customerName", in: view) as! UILabel
            customerImageView = self.findView(withAccessibilityLabel: "customerImage", in: view) as! AvatarImageView
        }
        
        describe("when view initialized") {
            it("should have correct welcome label text") {
                expect(welcomeLabel.text) == "Label.Welcome".localizable
            }
            
            it("should have correct customer name label text") {
                expect(customerNameLabel.text) == "First Last"
            }
            
            it("should have correct customer image configuration") {
                expect(customerImageView.configuration.bgColor) == .black
                expect(customerImageView.configuration.textSizeFactor) == 0.4
            }
            
            it("should have correct customer image data source") {
                expect(customerImageView.dataSource?.name) == "First Last"
            }
        }
    }
}
