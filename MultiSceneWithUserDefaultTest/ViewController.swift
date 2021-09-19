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

    }

    @IBAction func buttonTouched(_ sender: UIButton) {
        showLabel.text = player?.descriptionToPrint() ?? "none"
        
        imageView.image = UIImage(data: player!.imageData)
    }
    
    @IBAction func resetButtonTouched(_ sender: UIButton) {
        showLabel.text = ""
        imageView.image = nil
    }
    
    @IBAction func saveButtonTouched(_ sender: UIButton) {
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        let fileNames = ["apple", "cherry", "grape", "medal", "orange"]
        
        let image = UIImage(named: fileNames.randomElement()!)!
        let data = image.jpegData(compressionQuality: 1)!
        
        sceneDelegate.player = Player(name: "turu", age: Int.random(in: 10...20), city: City(name: "Seoul", num: 1), imageData: data)
    }
}
