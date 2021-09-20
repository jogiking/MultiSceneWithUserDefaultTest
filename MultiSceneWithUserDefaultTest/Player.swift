//
//  Player.swift
//  MultiSceneWithUserDefaultTest
//
//  Created by turu on 2021/09/17.
//

import Foundation

struct City: Codable {
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
    var imageData: Data
    
    init(name: String, age: Int, city: City, imageData: Data) {
        self.name = name
        self.age = age
        self.city = city
        self.imageData = imageData
    }
    
    func encode(with aCoder: NSCoder) {
        print(#function, #line)
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
        
        do {
            let cityData = try PropertyListEncoder.init().encode(city)
            aCoder.encode(cityData, forKey: "city")
        } catch {
            print(#function, #line)
        }
        
        aCoder.encode(imageData, forKey: "imageData")
    }
    
    required init?(coder aDecoder: NSCoder) {
        print(#function, #line)
        name = aDecoder.decodeObject(forKey: "name") as! String
        age = aDecoder.decodeInteger(forKey: "age")

        let cityData = aDecoder.decodeObject(forKey: "city") as! Data
        city = try! PropertyListDecoder.init().decode(City.self, from: cityData)
        
        imageData = aDecoder.decodeObject(forKey: "imageData") as! Data
        
    }
    
}
