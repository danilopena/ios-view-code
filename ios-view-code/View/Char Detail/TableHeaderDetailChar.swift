//
//  TableHeaderDetailChar.swift
//  ios-view-code
//
//  Created by Danilo Pena on 29/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

final class TableHeaderDetailChar: UITableViewHeaderFooterView {
    
    // Mark: - Variables and Lets
    var title: String = ""
    
    // Mark: - Father class methods
    func makeLayout() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        view.backgroundColor = .white
        
        let separatorView = UIView()
        separatorView.backgroundColor = Colors.basic
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(separatorView)
        separatorView
            .rightAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                        constant: 0)
            .isActive = true
        
        separatorView
            .leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                        constant: 0)
            .isActive = true
        
        separatorView
            .bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                        constant: 0)
            .isActive = true
        
        separatorView
            .heightAnchor
            .constraint(equalToConstant: 0.5)
            .isActive = true
        
        let label = UILabel()
        label.text = self.title
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = Colors.graybase_Gray1
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label
            .centerYAnchor
            .constraint(equalTo: view.centerYAnchor)
            .isActive = true
        
        label
            .rightAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 16)
            .isActive = true
        
        label
            .leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16)
            .isActive = true
        
        addSubview(view)
    }
}
