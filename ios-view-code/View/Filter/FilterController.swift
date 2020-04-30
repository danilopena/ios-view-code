//
//  FilterController.swift
//  ios-view-code
//
//  Created by Danilo Pena on 28/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

protocol FilterControllerDelegate {
    func radioCellDeselection(cell: FilterTableCell)
}

final class FilterController: UIViewController {

    private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(FilterTableCell.self, forCellReuseIdentifier: "filterCell")
        }
    }
    private let topView = UIView()
    
    // Number of rows on sections
    private let sectionOrganizer = [0, 0, 0, 3, 4]
    private let sectionHeight = [60.0, 20.0, 60.0, 44.0, 44.0]
    
    private let cellsStatusContent = [StatusCharEnum.alive.rawValue,
                                      StatusCharEnum.dead.rawValue,
                                      StatusCharEnum.unknown.rawValue]
    
    private let cellGenderContent = [GenderEnum.female.rawValue,
                                     GenderEnum.male.rawValue,
                                     GenderEnum.genderless.rawValue,
                                     GenderEnum.unknown.rawValue]

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
        viewSeparator.backgroundColor = Colors.graybase_Gray1

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
    
    func makeCellItems(content: [String], row: Int, section: Int) -> FilterTableCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? FilterTableCell {
            cell.selectionStyle = .none
            
            // Verifying last cell to add bottom separator.
            if sectionOrganizer[section] == row + 1 {
                cell.setupBasicElements()
            } else {
                cell.setupBasicElements(withBottomSeparator: false)
            }
            cell.makeLabelStack(withTwoLabels: true, titleStr: content[row])

            return cell
        }
        return FilterTableCell()
    }
}

extension FilterController: FilterControllerDelegate {
    func radioCellDeselection(cell: FilterTableCell) {

    }
}

extension FilterController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionOrganizer[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            return makeCellItems(content: cellsStatusContent, row: indexPath.row, section: indexPath.section)
        } else if indexPath.section == 4 {
            return makeCellItems(content: cellGenderContent, row: indexPath.row, section: indexPath.section)
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let cellSpacer = UITableViewCell()
            let bottomSeparatorView = UIView()
            bottomSeparatorView.backgroundColor = Colors.graybase_Gray1
            bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
            cellSpacer.addSubview(bottomSeparatorView)

            bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            bottomSeparatorView.leadingAnchor.constraint(equalTo: cellSpacer.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            bottomSeparatorView.trailingAnchor.constraint(equalTo: cellSpacer.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            bottomSeparatorView.bottomAnchor.constraint(equalTo: cellSpacer.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            
            return cellSpacer
        }
        if section == 0 || section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? FilterTableCell {
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                cell.setupBasicElements()
                if section == 0 {
                    cell.makeLabelStack(titleStr: "Name", subTitleStr: "Give a name")
                } else {
                    cell.makeLabelStack(titleStr: "Species", subTitleStr: "Select one")
                }

                return cell
            }
        } else {
            let cell = UITableViewCell()
            let label = UILabel()
            label.text = "Teste"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = Colors.graybase_Gray1
            cell.addSubview(label)
            
            label.leadingAnchor.constraint(equalTo: cell.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
            label.bottomAnchor.constraint(equalTo: cell.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
            
            let bottomSeparatorView = UIView()
            bottomSeparatorView.backgroundColor = Colors.graybase_Gray1
            bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(bottomSeparatorView)

            bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            bottomSeparatorView.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            bottomSeparatorView.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            bottomSeparatorView.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(sectionHeight[section])
    }
}
