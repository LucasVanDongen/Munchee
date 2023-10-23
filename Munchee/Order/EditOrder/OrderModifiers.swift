//
//  OrderModifiers.swift
//  Munchee
//
//  Created by Lucas van Dongen on 26/10/2023.
//

import MuncheeModel

protocol OrderAdding {
    var product: Product { get }
    var order: Order { get }

    func add()
}

extension OrderAdding {
    func add() {
        order.add(
            amount: 1,
            of: product
        )
    }
}

protocol OrderRemoving {
    var orderLine: OrderLine { get }
    var order: Order { get }

    func remove()
}

extension OrderRemoving {
    func remove() {
        switch orderLine.amount <= 1 {
        case true:
            order.delete(product: orderLine.product)
        case false:
            order.update(
                amount: orderLine.amount - 1,
                of: orderLine.product
            )
        }
    }
}
