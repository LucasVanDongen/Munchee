//
//  SelectRestaurantView.swift
//  Munchee
//
//  Created by Lucas van Dongen on 23/10/2023.
//

import MuncheeModel
import SwiftUI

struct SelectRestaurantView: View {
    @Environment(Model.self) private var model: Model
    @Environment(OrderRouter.self) private var router: OrderRouter

    let availableRestaurants = [
        MockData.sandwichRestaurant,
        MockData.pizzaRestaurant
    ]

    var body: some View {
        VStack {
            Text("These restaurants are open for delivery in your neighborhood:")
                .padding()
            List {
                ForEach(availableRestaurants, id: \.id) {
                    restaurant in
                    Text(restaurant.name)
                        .onTapGesture {
                            selected(restaurant: restaurant)
                        }
                }
            }.frame(maxHeight: .infinity)
        }
    }

    func selected(restaurant: Restaurant) {
        model.select(restaurant: restaurant)
        router.goTo(order: model.order!)
    }
}

#Preview {
    SelectRestaurantView()
        .environment(Model())
}
