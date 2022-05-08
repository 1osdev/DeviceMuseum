//
//  DeviceInfo.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI

struct DeviceInfo: View {
    
    var device: Device
    var screenRect = UIScreen.main.bounds
    
    @State var deviceWeb: Bool = false
    @ObservedObject var webViewStateModel: WebViewStateModel = WebViewStateModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text(device.company.uppercased())
                    .font(Font.system(size: 20))
                    .bold()
                        .padding(.init(top: 80, leading: 30, bottom: 30, trailing: 40))
                        .frame(width: screenRect.width, height: 10, alignment: .leading)
                        .lineLimit(2)
                        .foregroundColor(.blue)
                          HStack {
                        Text(device.name)
                                  .font(Font.system(size: 30))
                            .padding(.init(top: 15, leading: 35, bottom: 2, trailing: 0))
                            .frame(width: screenRect.width-70, height: (device.name.count > 11 ? 140 : 80), alignment: .leading)
                            .lineLimit(2)
                        Button(action: {
                            self.deviceWeb.toggle()
                        }) {
                            Image(systemName:
                                    "link.circle.fill")
                            .font(.system(size: 45))
                            .foregroundColor(.black)
                        }.frame(width: 50, height: 30, alignment: .trailing)
                            .padding(.init(top: (device.name.count > 11 ? 20 : 0), leading: 0, bottom: 0, trailing: 30))
            }.frame(width: screenRect.width)
                          ScrollView {
                        Text(device.description)
                            .font(Font.system(size: 18))
                    }.padding(.init(top: 0, leading: 30, bottom: 0, trailing: 30))
                    .frame(width: screenRect.width, height: 380)
                
                Spacer()
                
                Text("3D Models downloaded from the sketchfab.com")
                    .font(.system(size: 18))
                    .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .frame(width: screenRect.width, height: 70, alignment: .leading)
                    .lineLimit(2)
                    .foregroundColor(.black)
                
                Spacer()
        }
        }.sheet(isPresented: self.$deviceWeb) {
            WebView(url: URL.init(string: "\(self.device.urlString)")!, webViewStateModel: self.webViewStateModel)
        }
    }
}

struct DeviceInfo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 1).fill(Color.mint)
                    .edgesIgnoringSafeArea(.all)
                BottomView(isOpen: .constant(false), maxHeight: 700, minHeight: 405) {
                    DeviceInfo(device: deviceData[1])
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}
