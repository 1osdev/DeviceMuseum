//
//  DeviceDetail.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI
import QuickLook
import NavigationStack

struct DeviceDetail: View {
    
    @State private var bottomSheetShown = true
    @State private var deviceInfo = false
    @State private var deviceWeb = false
    
    @State var device: Device
    var screenRect = UIScreen.main.bounds
    
    var body: some View {
        Screen {
            ZStack {
                VStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    Color.white
                        .frame(width:
                            self.screenRect.width, height: 200, alignment: .bottom)
                }
                ZStack {
                    if self.device.imageName != "" {
                        VStack {
                            ModelView(device: self.device)
                                .frame(width: self.screenRect.size.width, height: 680, alignment: .bottom)
                            Spacer()
                        }
                    } else {
                        VStack {
                            Image(self.device.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                        }
                    }

                    HStack(alignment: .top) {
                        PopView(destination: .root) {
                            ZStack {
                                Blur(style: .light).background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .black]),
                                        startPoint: UnitPoint(x: 0.2, y: 0.2),
                                        endPoint: .bottomTrailing
                                    )
                                )

                                Image(systemName: "arrow.left")
                                    .foregroundColor(.white)
                                    .font(.system(size: 26))
                                    .shadow(radius: 4)
                            }
                        }.frame(width: 52, height: 52)
                            .cornerRadius(20)
                            .padding(.leading, 30)

                        Spacer()

                        ARButtonView(device: self.device).padding(.trailing, 30)
                    }.padding(.bottom, 600)
                }

                if self.bottomSheetShown == true {
                    BottomView(isOpen: self.$deviceInfo, maxHeight: 700, minHeight: 178) {
                        DeviceInfo(device: self.device)
                    }.edgesIgnoringSafeArea(.all)
                }

            }.frame(width: self.screenRect.size.width, height: self.screenRect.size.height)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DeviceDetail_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetail(device: deviceData[1])
    }
}
