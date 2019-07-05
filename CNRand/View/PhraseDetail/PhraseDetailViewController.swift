//
//  PhraseDetailViewController.swift
//  CNRand
//
//  Created by Augusto Reis on 04/07/19.
//  Copyright © 2019 Augusto Reis. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class PhraseDetailViewController: UIViewController, ReusableView {

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelPhrase: UILabel!
    @IBOutlet weak var labelUrl: UILabel!
    
    let viewModel = PhraseDetailViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureBindings()
    }
    
    func configureBindings() {
        viewModel.phrase.map{$0.value}.bind(to: labelPhrase.rx.text).disposed(by: disposeBag)
        viewModel.phrase.map{$0.icon_url}.asObservable().subscribe { [weak self] (event)  in 
            if let urlString = event.element as? String,
                let url = URL(string: urlString) {
                self?.imageViewIcon.kf.setImage(with: url)
            }
        }.disposed(by: disposeBag)
        viewModel.phrase.map{$0.url}.bind(to: labelUrl.rx.text).disposed(by: disposeBag)
    }

}
