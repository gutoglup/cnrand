//
//  CategoriesViewController.swift
//  CNRand
//
//  Created by Augusto Reis on 03/07/19.
//  Copyright © 2019 Augusto Reis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoriesTableViewController: UITableViewController {
    
    
    let disposeBag = DisposeBag()
    var viewModel = CategoriesViewModel()
    public var theItems = PublishSubject<[Category]>()
    
    @IBOutlet var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBindings()
        viewModel.listCategories()
    }
    
    func configureBindings() {
        categoriesTableView.dataSource = nil
        categoriesTableView.delegate = nil
        
        viewModel.categories.bind(to: categoriesTableView.rx.items(cellIdentifier: CategoriesTableViewCell.reusableIdentifier, cellType: CategoriesTableViewCell.self)) { (row, category, cell) in
            cell.labelTitle.text = category.title
            }.disposed(by: disposeBag)
        
        categoriesTableView.rx.itemSelected.subscribe({ (indexPath) in
            if let row = indexPath.element?.row {
                self.performSegue(withIdentifier: PhraseDetailViewController.reusableIdentifier, sender: row)
            }
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PhraseDetailViewController.reusableIdentifier,
            let destination = segue.destination as? PhraseDetailViewController,
            let index = sender as? Int{
            
            destination.viewModel.categoryIndex.onNext(index)
        }
    }
    
}
