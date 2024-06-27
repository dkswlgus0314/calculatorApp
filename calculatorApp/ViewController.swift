//
//  ViewController.swift
//  calculatorApp
//
//  Created by ahnzihyeon on 6/26/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var viewNum = 12345
    
    var numLabel = UILabel()
    var buttons: [UIButton] = []
    let buttonNums = ["7", "8", "9", "+"]
    //                   "4", "5", "6", "-",
    //                   "1", "2", "3", "*",
    //                   "AC", "0", "=", "/"]
    

    
    
    //버튼 한줄을 만들어서 horizontalStackView에 넣어주는 함수
    private func makeNumButton(buttonNums: [String]) {
        for num in buttonNums {
            let button = UIButton()
            //UIButton 속성
            button.setTitle(num, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 30)
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
//            button.frame.size.height = 80
//            button.frame.size.width = 80
            button.layer.cornerRadius = 40
            horizontalStackView.addArrangedSubview(button)
        }
    }
    
    //
    var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        makeNumButton(buttonNums: buttonNums)
    }
    
    func configureUI(){
        //속성
        view.backgroundColor = .black
        
        numLabel.backgroundColor = .black
        numLabel.textColor = .white
        numLabel.text = "\(viewNum)"
        numLabel.textAlignment = .right
        numLabel.font = .boldSystemFont(ofSize: 60)
        
        
        [numLabel, horizontalStackView].forEach{view.addSubview($0)}
        
        
        //AutoLayout
        numLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(200)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.width.equalTo(350)
            $0.top.equalTo(numLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        
    }

    
}

