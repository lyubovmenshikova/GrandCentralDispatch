//
//  SecondViewController.swift
//  GCD
//
//  Created by Lyubov Menshikova on 15.03.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //url для загрузки фото из инета
    fileprivate var imageURL: URL?
    
    //создано для упращенной работы с imageView
    fileprivate var image: UIImage? {
        // выполняется когда нужно получить значение image
        get {
            return imageView.image
        }
        //выполянется при установки нового значения для св-ва
        set {
            //после того как изображение было загружено - прячем индикатор
            activityIndicator.startAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        loginAlert()
    }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { usernameTF in
            usernameTF.placeholder = "Введите пароль"
        }
        
        ac.addTextField { userPasswordTF in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    
    //установка изображения
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        //если у нас существует такой url и если мы можем получить данные из url то
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
        // то устанавливаем новое значение для нашего изображения
        self.image = UIImage(data: imageData)
    }

}
