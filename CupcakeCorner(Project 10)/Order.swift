//
//  Order.swift
//  CupcakeCorner(Project 10)
//
//  Created by mac on 14.04.2023.
//

import SwiftUI
class Order : ObservableObject, Codable{
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, address, city, zip
    }
    
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var type = 0
    @Published var quantity = 3
    @Published var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }

    var address: String {
        didSet {
            UserDefaults.standard.set(address, forKey: "address")
        }
    }

    var city: String {
        didSet {
            UserDefaults.standard.set(city, forKey: "city")
        }
    }

    var zip: String {
        didSet {
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }
    var hasValidAddress: Bool {
        if name.isEmpty || address.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    var cost: Double{
        
        var cost = Double(quantity)*2
        
        cost += Double(type)/2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        if addSprinkles {
            cost += Double(quantity)/2
        }
        return cost
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
        
    }
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        
        address = try container.decode(String.self, forKey: .address)
        name = try container.decode(String.self, forKey: .name)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    init() {
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        address = UserDefaults.standard.string(forKey: "address") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    }
}
