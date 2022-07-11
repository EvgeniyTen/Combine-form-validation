//
//  ViewController.swift
//  Combine framework basics
//
//  Created by Евгений Тимофеев on 11.07.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var userButton: UIButton!
    
    private var textFieldDidChangeCancellable: AnyCancellable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        combineAction()
    }
    
    // Хороший способ валидации форм

    
    func combineAction() {
        
        /// Назначние свойств переменной textFieldDidChangeCancellable
        ///  для оповещения кнопки и передачи ей состояния  ниже описаны свойства нотификации
        textFieldDidChangeCancellable = NotificationCenter.default
        
        // создаем паблишер в виде изменений текстфилда с распространиением действий на объект userButton
            .publisher(for: UITextField.textDidChangeNotification, object: userTextField)
            .map{ $0.object as? UITextField }
            .compactMap { $0?.text }
        
                    /// мапим введенную строку
///
            .map { string -> Bool in
                    ///  - конвертируем сроку в число
///
                if let number = Double(string){
                    ///  - стравниваем число с условием (в данном случае это число 10)
///
                    return number > 10
                }else {
                    return false
                }
                    ///  - возвращаем условие  и передаем его в условие оторажения кнопки
///
            }
            .assign(to: \.isEnabled, on: userButton)
    }
}


