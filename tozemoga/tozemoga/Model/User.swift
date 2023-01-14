//
//  User.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
}

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
    
    var fullAddress: String {
        var address = ""
        if let street = self.street {
            address.append(street)
        }
        if let suite = self.suite {
            address.append(" \(suite)")
        }
        if let city = self.city {
            address.append("\n\(city)")
        }
        if let zipcode = self.zipcode {
            address.append("\n\(zipcode)")
        }
        return address
    }
}

struct Geo: Codable {
    let lat: String?
    let lng: String?
}

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}
