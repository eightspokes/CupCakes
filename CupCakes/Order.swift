//
//  File.swift
//  CupCakes
//
//  Created by Roman on 12/25/22.
//

import SwiftUI

class OrderWrapper:  ObservableObject, Codable{
    @Published var order = Order()
    enum CodingKeys: CodingKey {
        case order
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decode(Order.self, forKey: .order)
    }
    init(){}
    
}

struct Order:  Codable{
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  {
            return false
        }else{
            return true
        }
    }
    
    
    var cost: Double {
        // $2 per cake
        
        var cost = Double(quantity) * 2
        
        if extraFrosting || addSprinkles{
            cost += (Double(type)/2)
        }
        
        // $1 for extra sprincles
        
        if extraFrosting{
            cost += Double(quantity)
        }
        
        if addSprinkles{
            cost += Double(quantity)/2
        }
        return cost
        
    }
    
}
