//
//  MockData.swift
//  Munchee
//
//  Created by Lucas van Dongen on 25/10/2023.
//

import CoreLocation
import MuncheeModel

struct MockData {
    static let address1 = Address(
        street: "",
        number: "",
        city: "",
        zipCode: "",
        country: ""
    )
    static let ham = Product(id: "20", name: "Baguette with Ham", price: 1.25)
    static let cheese = Product(id: "2", name: "Baguette with Cheese", price: 1)
    static let sandwichRestaurant = Restaurant(
        id: "1",
        name: "La Jamboneria",
        address: address1,
        location: CLLocation(latitude: 0, longitude: 0),
        products: [
            ham,
            cheese,
        ],
        minimumValueForDelivery: 10
    )
    static let address2 = Address(
        street: "",
        number: "",
        city: "",
        zipCode: "",
        country: ""
    )
    static let pizzaMargherita = Product(id: "20", name: "Pizza Margherita", price: 10.25)
    static let pizzaSalame = Product(id: "2", name: "Pizza Salame", price: 12.5)
    static let pizzaRestaurant = Restaurant(
        id: "2",
        name: "Paul's Deep Dish Pizza Parlor",
        address: address2,
        location: CLLocation(latitude: 0, longitude: 0),
        products: [
            pizzaMargherita,
            pizzaSalame,
        ],
        minimumValueForDelivery: 20
    )
}
