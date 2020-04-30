//
//  FilterController.swift
//  ios-view-code
//
//  Created by Danilo Pena on 28/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

final class FilterController: UIViewController {

    private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(FilterTableCell.self, forCellReuseIdentifier: "filterCell")
        }
    }
    private let topView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        makeTopView()
        makeTableViewLayout()
        addApplyButton()
        addClearButton()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(myDismiss))
        swipeGesture.direction = .down
        topView.addGestureRecognizer(swipeGesture)
    }

    @objc func myDismiss() {
        dismiss(animated: true) {}
    }
    
    func makeTopView() {
        topView.backgroundColor = .white
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        let grayIndicator = UIView()
        grayIndicator.backgroundColor = Colors.basic
        grayIndicator.layer.cornerRadius = 4
        grayIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let titleController = UILabel()
        titleController.text = "Filter"
        titleController.translatesAutoresizingMaskIntoConstraints = false
        
        let viewSeparator = UIView()
        viewSeparator.backgroundColor = Colors.basic

        view.addSubview(topView)
        topView.addSubview(grayIndicator)
        topView.addSubview(titleController)
        topView.addSubview(viewSeparator)

        // TopView Constraints
        topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        topView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        topView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
        // GrayIndicator Constraints
        grayIndicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
        grayIndicator.widthAnchor.constraint(equalToConstant: 36).isActive = true
        grayIndicator.centerXAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        grayIndicator.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: 6).isActive = true
        
        // TitleController Constraints
        titleController.centerXAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleController.centerYAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        // ViewSeparator Constraints
        viewSeparator.translatesAutoresizingMaskIntoConstraints = false
        viewSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        viewSeparator.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        viewSeparator.trailingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        viewSeparator.bottomAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func addClearButton() {
        let clearButton = UIButton()
        clearButton.setTitleColor(Colors.indigo, for: .normal)
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(clearFilter), for: .touchUpInside)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        topView.addSubview(clearButton)
        
        clearButton.centerYAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    }
    
    @objc func clearFilter() {}
    
    func addApplyButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
        button.widthAnchor.constraint(equalToConstant: 65).isActive = true
        button.layer.cornerRadius = 14
        button.backgroundColor = Colors.indigo
        button.setTitleColor(.white, for: .normal)
        button.setTitle("APPLY", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        
        topView.addSubview(button)
        
        button.centerYAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    @objc func applyFilter() {}
    
    func makeTableViewLayout() {
        tableView = UITableView()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}

extension FilterController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? FilterTableCell {
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                cell.setupBasicElements()
                cell.setupBasicElements()
                cell.makeLabelStack(titleStr: "Name", subTitleStr: "Give a name")

                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
