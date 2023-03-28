//
//  LogInViewController.swift
//  Animations
//
//  Created by Andrew Acton on 3/27/23.
//

import UIKit

class LogInViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var FAQButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        toggleToLogin()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        toggleToSignUp()
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        presentCardVC()
    }
    
    //MARK: - Helper Methods
    
    func setupView() {
        confirmButton.layer.cornerRadius = 8.0
        signUpButton.rotate()
        loginButton.rotate()
    }
    
    func toggleToLogin(){
        UIView.animate(withDuration: 0.2) {
            self.confirmPasswordTextField.isHidden = true
            self.loginButton.alpha = 1.0
            self.signUpButton.alpha = 0.3
            self.confirmButton.setTitle("Log me in!", for: .normal)
            self.helpButton.setTitle("Forgot?", for: .normal)
            self.FAQButton.setTitle("Hint", for: .normal)
        }
    }
    
    func toggleToSignUp() {
        UIView.animate(withDuration: 0.2) {
            self.confirmPasswordTextField.isHidden = false
            self.loginButton.alpha = 0.3
            self.signUpButton.alpha = 1.0
            self.confirmButton.setTitle("Sign me up!", for: .normal)
            self.helpButton.setTitle("Help", for: .normal)
            self.FAQButton.setTitle("FAQ", for: .normal)
        }
    }
    
    func presentCardVC() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let cardVC = main.instantiateViewController(withIdentifier: "cardVC")
        cardVC.modalPresentationStyle = .fullScreen
        self.present(cardVC, animated: true)
    }

}//End Of Class

extension UIView {
    func rotate(by radians: CGFloat = (-CGFloat.pi/2)) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}//End Of Extensions
