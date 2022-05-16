//
//  Device.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 3.05.22.
//

import SwiftUI

struct Device: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var description: String
    var category: Category
    var urlString : String
    var company: String
    var starImage: Bool
    var cameraPositionXYZ: [Float]
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case iPhone = "iPhone"
        case iPad = "iPad"
        case Watch = "Watch"
        case Other = "Mac & Other"
    }
}

struct Device_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
