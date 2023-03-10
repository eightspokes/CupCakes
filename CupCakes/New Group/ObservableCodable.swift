//
//  ObservableCodable.swift
//  CupCakes
//
//  Created by Roman on 12/22/22.
//

import Foundation


class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey{
        case name
    }
    @Published  var name: String = "Roman Kozulia"
    required init (from decoder: Decoder) throws{
        let container = try
        decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    func encode(to encoder: Encoder) throws {
        var container =
        encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
