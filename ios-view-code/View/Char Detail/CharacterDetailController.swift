//
//  CharacterDetailController.swift
//  ios-view-code
//
//  Created by Danilo Pena on 28/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

final class CharacterDetailController: UIViewController {
    
    // Mark: - Variables and Lets
    private var viewModel: CharacterDetailViewModel!
    private var id: Int!
    private let topView = UIView()
    private let topImage = UIImageView()
    private let charImage = UIImageView()
    private let status = UILabel()
    private let name = UILabel()
    private let species = UILabel()
    private let tableView = UITableView()

    // Mark: - Father class methods
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CharacterDetailViewModel(delegate: self)
        viewModel.getCharacter(id: "\(id ?? 0)")
        
        view.backgroundColor = .white
        
        topView.backgroundColor = Colors.graybase_Gray6
        topView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(topView)
        topView.addSubview(topImage)
        topView.addSubview(charImage)

        topView
            .topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                        constant: 0)
            .isActive = true
        
        topView
            .rightAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                        constant: 0)
            .isActive = true
        
        topView
            .leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                        constant: 0)
            .isActive = true
        
        topView
            .heightAnchor
            .constraint(equalToConstant: 254)
            .isActive = true
        
        topImage.image = #imageLiteral(resourceName: "ic-header-detail")
        topImage.contentMode = .scaleAspectFill
        
        topImage.translatesAutoresizingMaskIntoConstraints = false
        topImage
            .topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                        constant: 0)
            .isActive = true
        
        topImage
            .rightAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                        constant: 0)
            .isActive = true
        
        topImage
            .leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                        constant: 0)
            .isActive = true
        
        topImage
            .heightAnchor
            .constraint(equalToConstant: 84)
            .isActive = true
        
        charImage.image = #imageLiteral(resourceName: "ic-char-test")
        charImage.layer.masksToBounds = true
        charImage.layer.borderWidth = 5
        charImage.layer.borderColor = Colors.graybase_Gray6?.cgColor
        charImage.layer.cornerRadius = 65
        
        charImage.translatesAutoresizingMaskIntoConstraints = false
        charImage
            .topAnchor
            .constraint(equalTo: topImage.safeAreaLayoutGuide.topAnchor,
                        constant: 20)
            .isActive = true
        
        charImage
            .centerXAnchor
            .constraint(equalTo: topView.centerXAnchor)
            .isActive = true
        
        charImage
            .heightAnchor
            .constraint(equalToConstant: 130)
            .isActive = true
        
        charImage
            .widthAnchor
            .constraint(equalToConstant: 130)
            .isActive = true
        
        makeStackWithLabels()
        makeTableViewWithInfosAndEpisodes()
    }
    
    init(idToDetail: Int) {
        super.init(nibName: nil, bundle: nil)
        self.id = idToDetail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Support methods
    func makeTableViewWithInfosAndEpisodes() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(TableHeaderDetailChar.self, forHeaderFooterViewReuseIdentifier: Constants.header)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView
            .topAnchor
            .constraint(equalTo: topView.safeAreaLayoutGuide.bottomAnchor,
                        constant: 0)
            .isActive = true
        
        tableView
            .rightAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                        constant: 0)
            .isActive = true
        
        tableView
            .leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                        constant: 0)
            .isActive = true
        
        tableView
            .bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                        constant: 0)
            .isActive = true
    }
    
    func makeStackWithLabels() {
        let stackLabels = UIStackView()
        stackLabels.alignment = .center
        stackLabels.axis = .vertical
        stackLabels.spacing = 6
        stackLabels.translatesAutoresizingMaskIntoConstraints = false
        
        status.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        status.textColor = Colors.graybase_Gray1
        
        name.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        name.textColor = .black
        
        species.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        species.textColor = Colors.graybase_Gray1

        stackLabels.addArrangedSubview(status)
        stackLabels.addArrangedSubview(name)
        stackLabels.addArrangedSubview(species)

        topView.addSubview(stackLabels)
        stackLabels
            .topAnchor
            .constraint(equalTo: charImage.safeAreaLayoutGuide.bottomAnchor,
                        constant: 10)
            .isActive = true
        
        stackLabels
            .centerXAnchor
            .constraint(equalTo: topView.centerXAnchor)
            .isActive = true
    }
    
    func populateTopCharData() {
        navigationItem.title = viewModel.char?.name
        status.text = viewModel.char?.status
        name.text = viewModel.char?.name
        species.text = viewModel.char?.species?.uppercased()
        if let url = URL(string: viewModel.char?.image ?? "") {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    self.charImage.image = #imageLiteral(resourceName: "ic-tab-chars")
                    return
                }
                DispatchQueue.main.async(execute: {
                    if let unwrappedData = data,
                       let image = UIImage(data: unwrappedData) {
                            self.charImage.image = image
                    }
                })
            }).resume()
        }
    }
    
    func makeHeaderCell(title: String) -> TableHeaderDetailChar {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.header) as? TableHeaderDetailChar {
            header.title = title
            header.makeLayout()
            return header
        }
        return TableHeaderDetailChar()
    }
}

extension CharacterDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return makeHeaderCell(title: viewModel.informationsString)
        } else {
            return makeHeaderCell(title: viewModel.episodesString)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.informationsData.count
        } else {
            return viewModel.episodeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.basicCellIdenfier)
            cell.selectionStyle = .none
            cell.textLabel?.text = viewModel.informationsData[indexPath.row].title
            cell.detailTextLabel?.text = viewModel.informationsData[indexPath.row].subTitle
            cell.detailTextLabel?.textColor = Colors.graybase_Gray1

            return cell
        } else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.basicCellIdenfier)
            cell.selectionStyle = .none
            cell.textLabel?.text = viewModel.episodeList[indexPath.row].episode
            cell.detailTextLabel?.text = viewModel.episodeList[indexPath.row].name
            cell.detailTextLabel?.textColor = Colors.graybase_Gray1
            
            return cell
        }
    }
}

private extension CharacterDetailController {
    private enum Constants {
        static let basicCellIdenfier = "basicCell"
        static let header            = "header"
    }
}

extension CharacterDetailController: CharacterDetailViewModelDelegate {
    func loadedEpisodes(state: State) {
        DispatchQueue.main.async {
            switch state {
            case .success:
                self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
                break
            case .failed(let error):
                self.showAlert(with: self.viewModel.attentionString, message: error)
            }
        }

    }
    
    func loaded(state: State) {
        DispatchQueue.main.async {
            switch state {
            case .success:
                self.populateTopCharData()
                self.viewModel.arrangeInfoData()
                self.viewModel.getEpisodes()

                self.tableView.reloadData()
                break
            case .failed(let error):
                self.showAlert(with: self.viewModel.attentionString, message: error)
            }
        }
    }
}
