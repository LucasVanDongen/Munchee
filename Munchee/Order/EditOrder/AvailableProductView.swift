//
//  AvailableProductView.swift
//  Munchee
//
//  Created by Lucas van Dongen on 26/10/2023.
//

import MuncheeModel
import SwiftUI

@Observable
class AvailableProductViewModel: OrderAdding {
    var productName: String { product.name }
    var formattedPrice: String { formatter.format(product.price) }

    internal let product: Product
    internal let order: Order

    private let formatter = CurrencyFormatter()

    init(
        product: Product,
        order: Order
    ) {
        self.product = product
        self.order = order
    }
}

struct AvailableProductView: View {
    @State var viewModel: AvailableProductViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.productName)
                .multilineTextAlignment(.leading)
            HStack {
                Text(viewModel.formattedPrice)
                Spacer()
                Button(
                    "Add",
                    systemImage: "plus",
                    action: viewModel.add
                )
                .labelStyle(.iconOnly)
                .padding()
            }
        }
    }
}
