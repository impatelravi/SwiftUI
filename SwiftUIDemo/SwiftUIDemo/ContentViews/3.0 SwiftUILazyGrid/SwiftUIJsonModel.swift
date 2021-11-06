//
//  SwiftUIJsonModel.swift
//  SwiftUIDemo
//
//  Created by Ravi Patel on 11/08/21.
//

import Foundation

class SwiftUIJsonModel: Identifiable {
    
    /*static func == (lhs: SwiftUIJsonModel, rhs: SwiftUIJsonModel) -> Bool {
        return lhs.id == rhs.id
        return lhs.name == rhs.name
        return lhs.image == rhs.image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(image)
    }*/
    
    //MARK:- Variables
    var id: String
    var name: String
    var image: String
    
    enum Keys: String {
        case id = "id"
        case name = "name"
        case img = "img"
    }
    
    //MARK:- Initializer
    init(dict: [String : Any]) {
        id = getString(anything: dict[Keys.id.rawValue])
        name = getString(anything: dict[Keys.name.rawValue])
        image = getString(anything: dict[Keys.img.rawValue])
        
    }
}
