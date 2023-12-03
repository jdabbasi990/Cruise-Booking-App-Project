import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        // Check entered credentials
           guard let enteredEmail = emailTextField.text, !enteredEmail.isEmpty,
                 let enteredPassword = passwordTextField.text, !enteredPassword.isEmpty else {
               showIncorrectCredentialsAlert(message: "Please enter both email and password.")
               return
           }
   
           // Validate credentials against the database
           let customerDBManager = CustomerDBManager()
           if customerDBManager.customerExists(email: enteredEmail, password: enteredPassword) {
               // Credentials are correct, show login successful popup
               showLoginSuccessfulPopup()
           } else {
               // Credentials are incorrect, show an error message
               showIncorrectCredentialsAlert(message: "Invalid email or password.")
           }
    }
    


    func showLoginSuccessfulPopup() {
        let alertController = UIAlertController(title: "Login Successful", message: "Welcome!", preferredStyle: .alert)

        // Add an action to dismiss the alert
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle any additional actions after login success
            // For example, navigate to the Dashboard
            self.navigateToDashboard()
        }
        alertController.addAction(okAction)

        // Present the alert
        present(alertController, animated: true, completion: nil)
    }

    func showIncorrectCredentialsAlert(message: String) {
        let alertController = UIAlertController(title: "Incorrect Credentials", message: message, preferredStyle: .alert)

        // Add an action to dismiss the alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        // Present the alert
        present(alertController, animated: true, completion: nil)
    }

    func navigateToDashboard() {
        // Perform segue to Dashboard or navigate programmatically
        // Ensure to set the correct identifier for the segue in your storyboard
        performSegue(withIdentifier: "DashboardScreen", sender: self)
    }

    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        backgroundImageView.image = UIImage(named: "teal_background3")
        view.sendSubviewToBack(backgroundImageView)
    }
}

