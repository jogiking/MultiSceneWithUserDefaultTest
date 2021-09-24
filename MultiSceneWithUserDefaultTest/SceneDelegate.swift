//
//  SceneDelegate.swift
//  MultiSceneWithUserDefaultTest
//
//  Created by turu on 2021/09/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var player: Player? {
        didSet {
            print(#function, #line)
            let text = player?.descriptionToPrint()
            let data = player?.imageData
            NotificationCenter.default.post(name: .didUpdateUI, object: (text, data))
        }
    }
    
    // 1
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see application:configurationForConnectingSceneSession` instead).
//        guard let _ = (scene as? UIWindowScene) else { return }
        
        let classInstanceAddress = MemoryAddress(of: self) // and not &classInstance
        print(#function, #line, classInstanceAddress)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            window.rootViewController = // ViewController()
                storyboard.instantiateViewController(withIdentifier: "testVC")
                //UINavigationController(rootViewController: ViewController()) // ViewController()
            window.backgroundColor = .white
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        let classInstanceAddress = MemoryAddress(of: self) // and not &classInstance
        print(#function, #line, classInstanceAddress)
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    // 3
    func sceneDidBecomeActive(_ scene: UIScene) {
        let classInstanceAddress = MemoryAddress(of: self) // and not &classInstance
        print(#function, #line, classInstanceAddress)
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        if UserDefaults.standard.object(forKey: String(describing: Player.self)) != nil {
                    // key값으로 데이터 가져옴
                    guard let encodedData = UserDefaults.standard.data(forKey: String(describing: Player.self)) else { return }
            do {
                let newPlayer = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData) as! Player
//                let newPlayer = try NSKeyedUnarchiver.unarchivedObject(ofClass: Player.self, from: encodedData)

                player = newPlayer
                print(#function, #line, "age: ",player?.age)
            } catch {
                print(error, #function, #line)
            }
        }
    }

    // 4
    func sceneWillResignActive(_ scene: UIScene) {
        let classInstanceAddress = MemoryAddress(of: self) // and not &classInstance
        print(#function, #line, classInstanceAddress)
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        guard let player = player else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: player, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: String(describing: Player.self))
            print(#function, #line, player.age)
        } catch {
            print(error, #function, #line)
        }
    }

    // 2
    func sceneWillEnterForeground(_ scene: UIScene) {
        print(#function, #line)
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    // 5
    func sceneDidEnterBackground(_ scene: UIScene) {
        print(#function, #line)
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
      
    }

}

extension Notification.Name {
    static let didUpdateUI = Notification.Name("didUpdateUI")
}


struct MemoryAddress<T>: CustomStringConvertible {

    let intValue: Int

    var description: String {
        let length = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
        return String(format: "%0\(length)p", intValue)
    }

    // for structures
    init(of structPointer: UnsafePointer<T>) {
        intValue = Int(bitPattern: structPointer)
    }
}

extension MemoryAddress where T: AnyObject {

    // for classes
    init(of classInstance: T) {
        intValue = unsafeBitCast(classInstance, to: Int.self)
        // or      Int(bitPattern: Unmanaged<T>.passUnretained(classInstance).toOpaque())
    }
}
