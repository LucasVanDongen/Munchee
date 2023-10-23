//
//  MuncheeApp.swift
//  Munchee
//
//  Created by Lucas van Dongen on 23/10/2023.
//

import MuncheeModel
import SwiftUI

@main
struct MuncheeApp: App {
    private let model = Model()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}
