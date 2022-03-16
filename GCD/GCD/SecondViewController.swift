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
    }
    
    //установка изображения
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        //создаем очередь с третьим приоритетом utility
        let queue = DispatchQueue.global(qos: .utility)
        //делаем асинхронно чтобы не ждать пока выполнится загрузка(задачи выполняются одновременно)
        queue.async {
            //если у нас существует такой url и если мы можем получить данные из url то
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            //возвращаемя в главную очередь потому что загрузка интерфейса происходит в главной очереди
            DispatchQueue.main.async {
                // то устанавливаем новое значение для нашего изображения
                self.image = UIImage(data: imageData)
            }
        }
        
    }
    
}
