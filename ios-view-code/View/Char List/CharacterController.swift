//
//  ViewController.swift
//  ios-view-code
//
//  Created by Danilo Pena on 28/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

final class CharacterController: UIViewController {
    
    // Mark: - Variables and Lets
    private var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    private var viewModel: CharacterViewModel!

    // Mark: - Variables and Lets
    override func viewDidLoad() {
        super.viewDidLoad()
     
        viewModel = CharacterViewModel(delegate: self)
        viewModel.getCharacters()

        makeCollectionViewLayout()
        addBarButtonItem()
    }
    
    // Mark: - Support methods
    func addBarButtonItem() {
        let barButton = UIBarButtonItem(title: viewModel.filterString, style: .plain, target: self, action: #selector(showFilter))
        barButton.setTitleTextAttributes([.foregroundColor: Colors.indigo ?? .blue,
                                          .font: UIFont.boldSystemFont(ofSize: 18)],
                                         for: .normal)
        
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func showFilter() {
        let controller = FilterController()
        controller.modalPresentationStyle = .overFullScreen
        
        navigationController?.present(controller, animated: true, completion: nil)
    }
    
    func makeCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(CharacterCollectionCell.self, forCellWithReuseIdentifier: Constants.cellIdenfier)
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView
            .topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                        constant: 0)
            .isActive = true
        
        collectionView
            .rightAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                        constant: 0)
            .isActive = true
        
        collectionView
            .leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                        constant: 0)
            .isActive = true
        
        collectionView
            .bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                        constant: 0)
            .isActive = true
    }
}

private extension CharacterController {
    private enum Constants {
        static let cellIdenfier    = "charCell"
    }
}

extension CharacterController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.chars?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let char = viewModel.getCharOfIndex(index: indexPath.row),
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdenfier, for: indexPath) as? CharacterCollectionCell else {
                return CharacterCollectionCell()
        }
        cell.setupView()
        cell.applyStyleAndTexts(char: char)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(CharacterDetailController(idToDetail: viewModel.getCharOfIndex(index: indexPath.row)?.id ?? 0), animated: true)
    }
}

extension CharacterController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 20) / 2.0
        return CGSize(width: width, height: 219)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension CharacterController: PatternViewModelDelegate {
    func loaded(state: State) {
        DispatchQueue.main.async {
            switch state {
            case .success:
                self.collectionView.reloadData()
            case .failed(let error):
                self.showAlert(with: self.viewModel.attentionString, message: error)
            }
        }
    }
}


