//
//  AddedProductView.swift
//  Munchee
//
//  Created by Lucas van Dongen on 26/10/2023.
//

import MuncheeModel
import SwiftUI

@Observable
final class AddedProductViewModel: OrderAdding, OrderRemoving {
    var amount: String { "\(orderLine.amount)" }
    var productName: String { orderLine.product.name }
    var formattedPrice: String { formatter.format(orderLine.product.price) }
    var formattedTotalPrice: String { formatter.format(Decimal(orderLine.amount) * orderLine.product.price) }

    internal let orderLine: OrderLine
    internal let order: Order
    internal var product: Product { orderLine.product }

    private let formatter = CurrencyFormatter()

    init(
        orderLine: OrderLine,
        order: Order
    ) {
        self.orderLine = orderLine
        self.order = order
    }

    func delete() {
        order.delete(product: orderLine.product)
    }
}

struct AddedProductView: View {
    @State var viewModel: AddedProductViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.productName)
            HStack {
                Text("\(viewModel.amount)\u{00a0}x\u{00a0}\(viewModel.formattedPrice) =\u{00a0}\(viewModel.formattedTotalPrice)")
                Spacer()
                Button(
                    "Add",
                    systemImage: "plus",
                    action: viewModel.add
                )
                .buttonStyle(BorderlessButtonStyle())
                .labelStyle(.iconOnly)
                .frame(minWidth: 44, minHeight: 44)
                Button(
                    "Remove",
                    systemImage: "minus",
                    action: viewModel.remove
                )
                .buttonStyle(BorderlessButtonStyle())
                .labelStyle(.iconOnly)
                .frame(minWidth: 44, minHeight: 44)
                Button(
                    "Delete",
                    systemImage: "trash",
                    action:  { viewModel.delete() }
                )
                .buttonStyle(BorderlessButtonStyle())
                .labelStyle(.iconOnly)
                .frame(minWidth: 44, minHeight: 44)
            }.padding(0)
        }
    }
}


#Preview {
    let order = Order(restaurant: MockData.pizzaRestaurant)

    order.add(amount: 1, of: MockData.pizzaMargherita)

    let viewModel = AddedProductViewModel(
        orderLine: order.lines.first!,
        order: order
    )

    return AddedProductView(viewModel: viewModel)
        .padding()
}
