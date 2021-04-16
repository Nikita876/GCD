//
//  SecondViewController.swift
//  GCD
//
//  Created by Никита Коголенок on 23.02.21.
//

import UIKit

class SecondViewController: UIViewController {
    // MARK: - Variables
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    // MARK: - Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
    //запаздывания
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let alertController = UIAlertController(title: "Зарегистрированы?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        alertController.addTextField { (usernameTF) in
            usernameTF.placeholder = "Ведите логин"
        }
        alertController.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        //создаем очередь
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL,
                  let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
