//
//  AuthorizationViewController.swift
//  SolarSystem2
//
//  Created by Даниил Никулин on 07.11.2020.
//

import UIKit

//protocol ResultsViewControllerDelegate {
//    var userNameDelegate: String { get }
//}

class AuthorizationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    private let userData = User.userData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "menu" else { return }
        guard
            let destination = segue.destination as? MenuViewController
        else { return }
        destination.name = userData.username
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 50
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func passButtonTapped() {
        showAlertView(title: "Забыл пароль?",
                      message: "Твой пароль: \(userData.password)")
    }
    
    @IBAction func nameButtonTapped() {
        showAlertView(title: "Забыл имя?",
                      message: "Твоё имя: \(userData.username)")
    }
    
    @IBAction func enterButtonPressed() {
        guard
            userTextField.text == userData.username,
            passTextField.text == userData.password
        else {
            showAlertView(title: "Что-то пошло не так",
                          message: "Проверь введенные данные",
                          textField: passTextField)
            return
        }
        performSegue(withIdentifier: "menu", sender: nil)
    }
    
    @IBAction func aboutButtonPressed() {
        showAlertView(
            title: "About",
            message: "Приложение разработано при участии: Hayyim Vital, D.N.A.,\n Kate Mamafitness,Vladislav Popov,\n helloslytherin, Artur."
        )
    }
    
    @IBAction func backSegue(segue: UIStoryboardSegue) {
        userTextField.text = nil
        passTextField.text = nil
    }
}

extension AuthorizationViewController {
    private func showAlertView(title: String,
                               message: String,
                               textField: UITextField? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Закрыть",
                                     style: .default) { _ in
            textField?.text = nil
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension AuthorizationViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField {
            passTextField.becomeFirstResponder()
        } else {
            enterButtonPressed()
        }
        return true
    }
}

//extension AuthorizationViewController: ResultsViewControllerDelegate {
//    var userNameDelegate: String {
//        userData.username
//    }
//}

