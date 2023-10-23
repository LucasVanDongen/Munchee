//
//  CurrencyFormatter.swift
//  Munchee
//
//  Created by Lucas van Dongen on 30/10/2023.
//

import Foundation

final class CurrencyFormatter {
    private static let formatter: NumberFormatter = {
        var formatter = NumberFormatter()

        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .halfUp
        formatter.currencyCode = "€"

        return formatter
    }()


    func format(_ value: Decimal) -> String {
        Self.formatter.string(from: value as NSDecimalNumber)
            ?? "\(Self.formatter.currencyCode ?? "") \(value)"
    }
}
