//
//  Player.swift
//  MultiSceneWithUserDefaultTest
//
//  Created by turu on 2021/09/17.
//

import Foundation

struct City {
    var name: String
    var num: Int
}

class Player: NSObject, NSCoding {
    
    func descriptionToPrint() -> String {
        return "\(name), \(age), \(city.name)"
    }

    var name: String
    var age: Int
    var city: City
    var imageData: NSData
    
    init(name: String, age: Int, city: City, imageData: NSData) {
        self.name = name
        self.age = age
        self.city = city
        self.imageData = imageData
    }
    
    func encode(with aCoder: NSCoder) {
        print(#function, #line)
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
        
        aCoder.encode(city.name, forKey: "city_name")
        aCoder.encode(city.num, forKey: "city_num")
        
        aCoder.encode(imageData, forKey: "imageData")
    }
    
    required init?(coder aDecoder: NSCoder) {
        print(#function, #line)
        name = aDecoder.decodeObject(forKey: "name") as! String
        age = aDecoder.decodeInteger(forKey: "age")
        
        guard let city_name = aDecoder.decodeObject(forKey: "city_name") as? String
        else {
            print(#file, #function, #line)
            return nil
            
        }
        let city_num = aDecoder.decodeInteger(forKey: "city_num")
        city = City(name: city_name, num: city_num)
        
        imageData = aDecoder.decodeObject(forKey: "imageData") as! NSData
        
    }
    
}
