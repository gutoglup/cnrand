//
//  CategoriesViewModel.swift
//  CNRand
//
//  Created by Augusto Reis on 03/07/19.
//  Copyright © 2019 Augusto Reis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CategoriesViewModel {

    public var categories: PublishSubject<[Category]> = PublishSubject()
    let disposeBag = DisposeBag()
    
    init() {
        categories.subscribe { (categories) in
            if let categories = categories.element,
                let categoriesEncoded = DataHelper.encodeToData(element: categories){
                
                UserDefaults.standard.setValue(categoriesEncoded, forKey: "categories")
            }
        }.disposed(by: disposeBag)
    }
    
    func listCategories() {
        Services().listCategories(completionHandler: { (categories) in
            if let categories = categories as? [Category] {
                self.categories.onNext(categories)
            }
        }) { (error) in
            print(error)
        }
    }
    
}
