//
//  ViewController.swift
//  calculatorApp
//
//  Created by ahnzihyeon on 6/26/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var viewNum = 123
    
    var numLabel = UILabel()
    let buttonNums = ["7", "8", "9", "+",
                      "4", "5", "6", "-",
                      "1", "2", "3", "×",
                      "AC", "0", "=", "÷"]
    
    
    //horizontalStackView 클로저 사용
    private func horizontalStackView(_ buttons: [UIButton])-> UIStackView {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    //버튼 한줄을 만들어서 horizontalStackView에 넣어주는 함수
    private func makeNumButton(buttonNums: [String]) {
        var buttonArray: [UIButton] = []
        
        for num in buttonNums {
            let button = UIButton()
            button.setTitle(num, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 30)
            button.layer.cornerRadius = 40
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            
            buttonArray.append(button)
            
            if buttonArray.count == 4 {
                verticalStackView.addArrangedSubview(horizontalStackView(buttonArray))
                buttonArray = []
            }
        }
    }
    
    
    
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
        
        //view에
        [numLabel, verticalStackView].forEach{view.addSubview($0)}
        
        
        //AutoLayout
        numLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(200)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.height.equalTo(350)
            $0.width.equalTo(350)  //button.frame.size.height /width = 80를 생략해도 되는 이유
            $0.top.equalTo(numLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    
}

#Preview{
    let preview = ViewController()
    return preview
}

