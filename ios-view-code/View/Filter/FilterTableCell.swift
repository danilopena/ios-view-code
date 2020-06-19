//
//  FilterTableCell.swift
//  ios-view-code
//
//  Created by Danilo Pena on 30/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class ButtonRadio: UIButton {
    var selectedRadio = false
}

final class FilterTableCell: UITableViewCell {
    private let buttonRadio = ButtonRadio()
    private let title = UILabel()
    private let subTitle = UILabel()
    private let stack = UIStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupBasicElements(withBottomSeparator: Bool = true) {
        if withBottomSeparator {
            let bottomSeparatorView = UIView()
            bottomSeparatorView.backgroundColor = Colors.graybase_Gray1
            bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(bottomSeparatorView)

            bottomSeparatorView
                .heightAnchor
                .constraint(equalToConstant: 0.5)
                .isActive = true
            
            bottomSeparatorView
                .leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                            constant: 0)
                .isActive = true
            
            bottomSeparatorView
                .trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                            constant: 0)
                .isActive = true
            
            bottomSeparatorView
                .bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                            constant: 0)
                .isActive = true
        }
        
        buttonRadio.setImage(#imageLiteral(resourceName: "ic-radio-empty"), for: .normal)
        buttonRadio.addTarget(self, action: #selector(selectRadioOption), for: .touchUpInside)
        addSubview(buttonRadio)
        
        buttonRadio.translatesAutoresizingMaskIntoConstraints = false
        buttonRadio
            .leadingAnchor
            .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                        constant: 0)
            .isActive = true
        
        buttonRadio
            .centerYAnchor
            .constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
            .isActive = true
        
        buttonRadio
            .widthAnchor
            .constraint(equalToConstant: 44)
            .isActive = true
        
        buttonRadio
            .heightAnchor
            .constraint(equalToConstant: 44)
            .isActive = true
        
        subTitle.textColor = Colors.graybase_Gray1
    }
    
    @objc func selectRadioOption() {
        let image = buttonRadio.selectedRadio ? UIImage(named: "ic-radio-empty") : UIImage(named: "ic-radio-check")
        buttonRadio.setImage(image, for: .normal)
        buttonRadio.selectedRadio = !buttonRadio.selectedRadio
    }
    
    func makeLabelStack(withTwoLabels: Bool = true, titleStr: String, subTitleStr: String = "") {
        title.text = titleStr
        subTitle.text = subTitleStr
        
        stack.addArrangedSubview(title)
        if withTwoLabels {
            stack.addArrangedSubview(subTitle)
        }
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        stack
            .leadingAnchor
            .constraint(equalTo: buttonRadio.trailingAnchor,
                        constant: 10)
            .isActive = true
        
        stack
            .centerYAnchor
            .constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
            .isActive = true
        
        stack
            .trailingAnchor
            .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                        constant: 10)
            .isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
