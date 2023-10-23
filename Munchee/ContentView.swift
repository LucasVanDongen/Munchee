//
//  ContentView.swift
//  Munchee
//
//  Created by Lucas van Dongen on 23/10/2023.
//

import MuncheeModel
import SwiftUI

@Observable
class OrderRouter {
    enum SelectRoute: Hashable {
        case order(_ order: Order)
    }

    enum OrderRoute {
        case confirm
        case pay
        case paid
    }

    var path = NavigationPath()

    private(set) var editViewModel: EditOrderViewModel!

    func goTo(order: Order) {
        popToRootView()

        let viewModel = EditOrderViewModel(
            order: order,
            router: self
        )

        editViewModel = viewModel

        path.append(SelectRoute.order(order))
    }

    func goToConfirmation() {
        path.append(OrderRoute.confirm)
    }

    func startPaying() {
        path.append(OrderRoute.pay)
    }

    func confirmPayment() {
        path.append(OrderRoute.paid)
    }

    func popToRootView() {
        path.removeLast(path.count)
    }
}

struct ContentView: View {
    @Bindable var orderRouter = OrderRouter()
    @Environment(Model.self) private var model: Model

    var body: some View {
        TabView {
            NavigationStack(path: $orderRouter.path) {
                SelectRestaurantView()
                .navigationDestination(for: OrderRouter.SelectRoute.self) { route in
                    switch route {
                    case let .order(order):
                        let viewModel = EditOrderViewModel(
                            order: order,
                            router: orderRouter
                        )
                        EditOrderView(viewModel: viewModel)
                            .environment(model.order)
                    }
                }
            }
            .tabItem {
                Label("Order", systemImage: "cart.fill")
            }
            DeliveryView()
            .tabItem {
                Label("Delivery", systemImage: "bicycle")
            }
        }
        .environment(orderRouter)
    }
}

#Preview {
    ContentView()
        .environment(Model())
}
