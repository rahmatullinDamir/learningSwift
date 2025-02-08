//
//  SecondViewController.swift
//  Lesson3
//
//  Created by Damir Rakhmatullin on 7.02.25.
//

import UIKit

class SecondViewController: UIViewController {

    var myValue: Int = 212
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        let incrementor = calculate(value: 5)
        
        incrementor()
        incrementor()
        incrementor()
        
        let myClosure: () -> Void = { [weak self] in
            guard let self else {return}
            print(self.myValue)
        }
        
        myClosure()
        
    }
    
    func calculate(value: Int) -> (() -> Void) {
        var result = 0
        
        let makeIncrementor: () -> Void = {
            result += value
            print("\(result)")
        }
        
        return makeIncrementor
    }

}
