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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func buttonTouched(_ sender: UIButton) {
        showLabel.text = player?.descriptionToPrint() ?? "none"
    }
    
    @IBAction func resetButtonTouched(_ sender: UIButton) {
        showLabel.text = ""
    }
    
    @IBAction func saveButtonTouched(_ sender: UIButton) {
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        
        sceneDelegate.player = Player(name: "turu", age: Int.random(in: 10...20), gender: .man)
    }
}
