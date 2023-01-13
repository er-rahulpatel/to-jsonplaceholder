//
//  UserView.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-12.
//

import UIKit

class UserView: UIView {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userWebsiteLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    
    var user: User? {
        didSet {
            DispatchQueue.main.async {
                self.userNameLabel.text = self.user?.name
                self.userEmailLabel.text = self.user?.email
                self.userPhoneLabel.text = self.user?.phone
                self.userWebsiteLabel.text = self.user?.website
                self.userAddressLabel.text = self.user?.address?.fullAddress
            }
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
