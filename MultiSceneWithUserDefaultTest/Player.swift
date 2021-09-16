//
//  Player.swift
//  MultiSceneWithUserDefaultTest
//
//  Created by turu on 2021/09/17.
//

import Foundation



class Player: NSObject, NSCoding {
    enum Gender: String {
        case man
        case woman
        case other
    }
    
    func descriptionToPrint() -> String {
        return "\(name), \(gender), \(age)"
    }

    var name: String
    var age: Int
    var gender: String
    
    init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender.rawValue
    }
    
    func encode(with aCoder: NSCoder) {
        print(#function, #line)
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(gender, forKey: "gender")
    }
    
    required init?(coder aDecoder: NSCoder) {
        print(#function, #line)
        name = aDecoder.decodeObject(forKey: "name") as! String
        age = aDecoder.decodeInteger(forKey: "age")
        gender = aDecoder.decodeObject(forKey: "gender") as! String
    }
    
}
