//
//  ViewController.swift
//  calculatorApp
//
//  Created by ahnzihyeon on 6/26/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var numLable = UILabel()
    var viewNum = 12345
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        //속성
        view.backgroundColor = .black
        numLable.backgroundColor = .black
        numLable.textColor = .white
        numLable.text = "\(viewNum)"
        numLable.textAlignment = .right
        numLable.font = .boldSystemFont(ofSize: 60)
        
        [numLable].forEach{view.addSubview($0)}
        
        //AutoLayout
        numLable.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(200)
        }
    }
}

