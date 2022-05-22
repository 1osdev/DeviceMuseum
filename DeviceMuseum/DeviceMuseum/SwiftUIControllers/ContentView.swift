//
//  ContentView.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 22.04.22.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        (WelcomeView(areYouGoingToListView: false))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
