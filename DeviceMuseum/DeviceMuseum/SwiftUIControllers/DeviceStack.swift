//
//  DeviceStack.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI
import NavigationStack

struct DeviceStack: View {

    @State private var isActive = false

    var categoryName: String

    var devices: [Device]

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(Font.system(size: 25))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(self.devices, id: \.name) {
                        device in
                        VStack {
                            PushView(destination: DeviceDetail(device: device), isActive: self.$isActive) {
                                DeviceItem(device: device)
                                    .frame(width: 170, height: 220, alignment: .top)
                                    .padding(EdgeInsets(top: 17, leading: 17, bottom: 17, trailing: 30))
                            }
                        }
                    }
                }
            }
        }
    }
}

struct DeviceStack_Previews: PreviewProvider {
    static var previews: some View {
        DeviceStack(categoryName: "iPhone", devices: deviceData)
    }
}
