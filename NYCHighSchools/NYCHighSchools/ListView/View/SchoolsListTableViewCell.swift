//
//  SchoolsListTableViewCell.swift
//  NYCHighSchools
//
//  Created by Rambabu on 20/12/23.
//

import UIKit

/**
    Schools list table view cell, displaying basic school info.
 */
class SchoolsListTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func addBorder() {
        containerView.layer.cornerRadius = 5.0
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    func setUp(_ school: School) {
        addBorder()
        titleLabel.text = school.name
        addressLabel.text = school.address
        gradesLabel.text = school.availableGrades
    }
}
