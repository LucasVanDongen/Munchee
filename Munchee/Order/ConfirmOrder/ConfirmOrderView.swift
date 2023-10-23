//
//  ConfirmOrderView.swift
//  Munchee
//
//  Created by Lucas van Dongen on 05/11/2023.
//

import MuncheeModel
import SwiftUI

@Observable
class ConfirmOrderViewModel {
    private let order: Order
    private let router: OrderRouter

    init(
        order: Order,
        router: OrderRouter
    ) {
        self.order = order
        self.router = router
    }

    func confirm() {
        router.startPaying()
    }
}

struct ConfirmOrderView: View {
    @State var viewModel: ConfirmOrderViewModel

    var body: some View {
        VStack {
            Text("Confirm Order")
            Button {
                viewModel.confirm()
            } label: {
                Text("Confirm and pay")
            }
        }
    }
}

#Preview {
    let order = Order(restaurant: MockData.pizzaRestaurant)
    let viewModel = ConfirmOrderViewModel(
        order: order,
        router: OrderRouter()
    )
    return ConfirmOrderView(viewModel: viewModel)
}
