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
        
        let jsonEncoder = JSONEncoder()
        let cityData = try! jsonEncoder.encode(city)
        aCoder.encode(cityData, forKey: "city")
        
        aCoder.encode(imageData, forKey: "imageData")
    }
    
    required init?(coder aDecoder: NSCoder) {
        print(#function, #line)
        name = aDecoder.decodeObject(forKey: "name") as! String
        age = aDecoder.decodeInteger(forKey: "age")

        do {
            let jsonDecoder = JSONDecoder()
            let cityData = aDecoder.decodeObject(forKey: "city") as! Data
            self.city = try jsonDecoder.decode(City.self, from: cityData)
        } catch {
            self.city = City(name: "error", num: 10)
        }
        
        imageData = aDecoder.decodeObject(forKey: "imageData") as! Data
        
    }
    
}
