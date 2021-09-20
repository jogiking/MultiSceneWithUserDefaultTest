//
//  ViewController.swift
//  MultiSceneWithUserDefaultTest
//
//  Created by turu on 2021/09/16.
//

import UIKit

class ViewController: UIViewController {

    private var player: Player? {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        return sceneDelegate.player
    }
    
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: .didUpdateUI, object: nil)
    }
    
    @objc func updateUI(_ notification: Notification) {
        print(#function, #line)
        if let (text, data) = notification.object as? (String, Data) {
            drawUI(text: text, imageData: data)
        }
    }
    
    private func drawUI(text: String, imageData: Data) {
        showLabel.text = text
        imageView.image = UIImage(data: imageData)
    }
 
    @IBAction func buttonTouched(_ sender: UIButton) {
        let text = player?.descriptionToPrint() ?? "none"
        let data = player!.imageData
        drawUI(text: text, imageData: data)
    }
    
    @IBAction func resetButtonTouched(_ sender: UIButton) {
        showLabel.text = ""
        imageView.image = nil
    }
    
    @IBAction func saveButtonTouched(_ sender: UIButton) {
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        let fileNames = ["apple", "cherry", "grape", "medal", "orange"]
        let cities = ["Seoul", "Busan", "Jeju"]
        
        let image = UIImage(named: fileNames.randomElement()!)!
        let cityName = cities.randomElement()!
        let data = image.jpegData(compressionQuality: 1)!
        
        sceneDelegate.player = Player(name: "turu",
                                      age: Int.random(in: 10...20),
                                      city: City(name: cityName, num: 1),
                                      imageData: data)
    }
}
