//
//  DeviceItem.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI

struct DeviceItem: View {
    
    var device: Device
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                Image(device.imageName)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 170)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            ZStack {
                
                Blur(style: .light).cornerRadius(20).shadow(radius: 2)
                
                if device.starImage {
                    Image(systemName: "star.circle.fill")
                        .foregroundColor(Color.blue)
                        .frame(width: 40, height: 40)
                        .font(.system(size: 40))
                        .background(Circle().fill(Color.white))
                        .offset(x: 75, y: -173)
                }
                
                VStack {
                    Text(device.company.uppercased())
                        .font(.system(size: 12))
                        .frame(width: 110, height: 15, alignment: .leading)
                        .foregroundColor(Color.blue)
                    Text(device.name)
                        .font(Font.system(size: 17))
                            .foregroundColor(.black)
                        .frame(width: 110, height: (device.name.count > 12 ? 44 : 30), alignment: .topLeading)
                        .padding(.top, 6)
                }.padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            }.padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                .frame(width: 140, height: 100)
                .offset(x: 0, y: 100)
        }
    }
}

#if DEBUG
struct DeviceItem_Previews: PreviewProvider {
    static var previews: some View {
        DeviceItem(device: deviceData[5])
    }
}
#endif
