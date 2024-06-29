//
//  ViewController.swift
//  calculatorApp
//
//  Created by ahnzihyeon on 6/26/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var viewNum = "0" {
        didSet {
            numLabel.text = viewNum
        }
    }
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
            if Int(num) != nil {
                button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            } else{
                button.backgroundColor = .orange
            }
            button.setTitle(num, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 30)
            button.layer.cornerRadius = 40
            buttonArray.append(button)
            
            if buttonArray.count == 4 {
                verticalStackView.addArrangedSubview(horizontalStackView(buttonArray))
                buttonArray = []
            }
            
            button.addTarget(self, action: #selector(numButtonTapped), for: .touchDown)
        }
        
        
    }
    
    @objc
    private func numButtonTapped(sender: UIButton) {
        
        var userInput = sender.currentTitle!
        
        switch userInput {
        case "AC":
            viewNum = "0"
        case "=":
            var result = calculate(expression: viewNum.replacingOccurrences(of: "×", with:  "*").replacingOccurrences(of: "÷", with: "/"))
            viewNum = String(result ?? 0) //Nil-Coalescing Operation
        default:
            if numLabel.text == "0" {
                viewNum.removeFirst()
            }
            viewNum += userInput
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
        
        numLabel.text = "0"
        numLabel.backgroundColor = .black
        numLabel.textColor = .white
        numLabel.textAlignment = .right
        numLabel.font = .boldSystemFont(ofSize: 60)
        numLabel.adjustsFontSizeToFitWidth = true //label 사이즈에 맞게 폰트 크기 자동 조절
        
        
        //view에
        [numLabel, verticalStackView].forEach{view.addSubview($0)}
        
        
        //AutoLayout
        numLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(200)
        }
        
        
        verticalStackView.snp.makeConstraints {
            $0.height.equalTo(350)
            $0.width.equalTo(350)
            $0.top.equalTo(numLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
    }
    
    /// 수식 문자열을 넣으면 계산해주는 메서드.
    ///
    /// 예를 들어 expression 에 "1+2+3" 이 들어오면 6 을 리턴한다.
    /// 잘못된 형식의 수식을 넣으면 앱이 크래시 난다. ex) "1+2++"
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
    
    
}

#Preview{
    let preview = ViewController()
    return preview
}

