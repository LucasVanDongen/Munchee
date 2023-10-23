//
//  EditOrderView.swift
//  Munchee
//
//  Created by Lucas van Dongen on 23/10/2023.
//

import MuncheeModel
import SwiftUI

@Observable
final class EditOrderViewModel {
    var restaurantName: String { order.restaurant.name }
    var showsAddedProducts: Bool { !order.lines.isEmpty }
    var showsOrderTotal: Bool { !order.lines.isEmpty }
    var canSubmitOrder: Bool { order.total >= order.restaurant.minimumValueForDelivery }
    var formattedTotal: String { formatter.format(order.total) }
    var formattedMinimumOrderValue: String { formatter.format(order.restaurant.minimumValueForDelivery) }

    private let order: Order
    private let router: OrderRouter
    private let formatter = CurrencyFormatter()

    init(
        order: Order,
        router: OrderRouter
    ) {
        self.order = order
        self.router = router
    }

    func confirmOrder() {
        router.goToConfirmation()
    }
}

struct EditOrderView: View {
    @Environment(Order.self) private var order: Order
    @Environment(OrderRouter.self) private var router: OrderRouter

    @State var viewModel: EditOrderViewModel

    var body: some View {
        VStack(alignment: .leading) {
            List {
                if viewModel.showsAddedProducts {
                    Section(header: Text("Added products")) {
                        ForEach(order.lines, id: \.product.id) { orderLine in
                            let viewModel = AddedProductViewModel(
                                orderLine: orderLine,
                                order: order
                            )
                            AddedProductView(viewModel: viewModel)
                        }
                    }
                }
                Section(header: Text("Available products")) {
                    ForEach(order.restaurant.products, id: \.id) { product in
                        let viewModel = AvailableProductViewModel(
                            product: product,
                            order: order
                        )
                        AvailableProductView(viewModel: viewModel)
                    }
                }
            }.frame(maxHeight: .infinity)
            if viewModel.showsOrderTotal {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Total: \(viewModel.formattedTotal)")
                        if !viewModel.canSubmitOrder {
                            Text("Minimum value to order: \(viewModel.formattedMinimumOrderValue)")
                                .font(.caption)
                                .foregroundStyle(.red)
                        }
                    }.padding()
                    Spacer()
                    Button(
                        "Confirm Order",
                        systemImage: "bicycle",
                        action: {
                            viewModel.confirmOrder()
                        }
                    )
                        .disabled(!viewModel.canSubmitOrder)
                        .padding()
                }
            }
        }
        .navigationDestination(for: OrderRouter.OrderRoute.self) { route in
            switch route {
            case .confirm:
                let viewModel = ConfirmOrderViewModel(
                    order: order,
                    router: router
                )
                ConfirmOrderView(viewModel: viewModel)
            case .pay:
                PayOrderView()
            case .paid:
                PaidOrderView()
            }
        }.navigationTitle(viewModel.restaurantName)
    }
}

#Preview {
    let order = Order(restaurant: MockData.sandwichRestaurant)

    order.add(amount: 1, of: MockData.ham)

    let viewModel = EditOrderViewModel(
        order: order,
        router: OrderRouter()
    )

    return EditOrderView(viewModel: viewModel)
}
