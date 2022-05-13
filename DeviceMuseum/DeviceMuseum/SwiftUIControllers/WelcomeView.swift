//
//  WelcomeView.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var areYouGoingToListView: Bool
    
    var body: some View {
       // NavigationView {
            ZStack {
                LinearGradient(gradient:Gradient(colors:[.mint, .blue]),
                               startPoint: UnitPoint(x: 0.2, y: 0.2),
                               endPoint: .bottomTrailing
                             ).edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Welcome")
                        .font(.system(size: 50, weight:.light))
                        .frame(width: 250, height: 120, alignment: .topLeading)
                    
                    Text("The Device museum application allows you to get acquainted with the collections of various devices, see realistic 3D images, read the description, and also watch a video presentation")
                        .font(.system(size: 25, weight: .light))
                        .frame(width: 250, height: 350, alignment: .top)
//                    NavigationLink("NavLinkView", destination: ListView()) Создание кнопки и переход на вью
                    
                    NavigationLink(destination: ListView( areYouGoingToMapView: false), isActive: $areYouGoingToListView) { EmptyView() }
                    Button(action: { self.areYouGoingToListView = true }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white).frame(width: 250, height: 60, alignment: .center)
                            Text("Let's start").foregroundColor(.blue)
                                .font(.system(size: 25, weight: .regular))
                        }
                    })
                }
                //.navigationTitle("Navigation") Изменение кнопки назад
            }
        //}
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(areYouGoingToListView: true)
    }
}
