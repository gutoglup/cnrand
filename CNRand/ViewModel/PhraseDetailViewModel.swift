//
//  PhraseDetailViewModel.swift
//  CNRand
//
//  Created by Augusto Reis on 04/07/19.
//  Copyright © 2019 Augusto Reis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PhraseDetailViewModel {
    
    var category: PublishSubject<String> = PublishSubject()
    let phrase: PublishSubject<Phrase> = PublishSubject()
    var categoryIndex: PublishSubject<Int> = PublishSubject()
    let disposeBag = DisposeBag()
    
    init() {
        categoryIndex.subscribe { (event) in
            if let categoryIndex = event.element,
                let categories = DataHelper<[Category]>.decode(data: UserDefaults.standard.value(forKey: "categories") as! Data) {
                
                let categorySelected = categories[categoryIndex]
                self.category.onNext(categorySelected.title)
            }
        }.disposed(by: disposeBag)
        
        loadRandomPhraseByCategory()
    }
    
    func loadRandomPhraseByCategory() {
        category.subscribe() { event in
            if let category = event.element {
                Services().loadRandomPhraseByCategory(category: category, completionHandler: { (phrase) in
                    if let phrase = phrase as? Phrase {
                        self.phrase.onNext(phrase)
                    }
                }) { (error) in
                  print(error)
                }
            }
        }.disposed(by: disposeBag)
        
    }
    
}
