//
//  ARButtonView.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI

struct ARButtonView: View {

    var device: Device

    @State var showPreview = false
    @State var scaleImage = true


    var body: some View {
        Button(action: { self.showPreview.toggle() },
            label: {
                ZStack {
                    Blur(style: .light).background(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .black]),
                            startPoint: UnitPoint(x: 0.2, y: 0.2),
                            endPoint: .bottomTrailing
                        )
                    )
                    Text("AR").frame(width: 42, height: 42, alignment: .center)
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                        .shadow(radius: 4)
                }
            })
            .frame(width: 52, height: 52)
            .sheet(isPresented: $showPreview) {
            VStack {
                HStack {
                    Button("Close") {
                        self.showPreview.toggle()
                    }
                    Spacer()
                }
                    .padding()

                ARQuickLookView(deviceName:
                        self.device.imageName,
                    scaleImage: self.scaleImage)
            }
        }
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(20)
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct ARButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ARButtonView(device: deviceData[3])
        }
    }
}
