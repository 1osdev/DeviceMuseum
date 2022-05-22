//
//  WelcomeView.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI
import UIKit
import Firebase

struct WelcomeView: View {

    @State var areYouGoingToListView: Bool
    //@Environment(\.dismiss) private var dismiss
    //@Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        //NavigationView {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.mint, .blue]),
                startPoint: UnitPoint(x: 0.2, y: 0.2),
                endPoint: .bottomTrailing
            ).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Welcome!🎉")
                    .font(.system(size: 47, weight: .light))
                    .frame(width: 250, height: 120, alignment: .topLeading)

                Text("The Device museum application allows you to get acquainted with the collections of various devices, see realistic 3D images, read the description, and also watch a video presentation")
                    .font(.system(size: 25, weight: .light))
                    .frame(width: 250, height: 350, alignment: .top)
                NavigationLink(destination: ListView(areYouGoingToMapView: false), isActive: $areYouGoingToListView) { EmptyView() }
                Button(action: { self.areYouGoingToListView = true }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white).frame(width: 250, height: 55, alignment: .center)
                            Text("Let's start").foregroundColor(.blue)
                                .font(.system(size: 35, weight: .regular))
                                .shadow(radius: 20)
                        }
                    }).padding(.bottom)

                Button(action: { signOutTapped() }, label: {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
                                    .frame(width: 120, height: 40, alignment: .center)
                                    .padding()
                                Text("Sign Out")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 15, weight: .light))
                            }
                        }
                    })
            }
            //.navigationTitle("Navigation") Change previous button
        }
        //  }
    }

    // Firebase user profile logout function
    func signOutTapped() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        withAnimation {
            //dismiss()
            //self.mode.wrappedValue.dismiss()
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(areYouGoingToListView: true)
    }
}
