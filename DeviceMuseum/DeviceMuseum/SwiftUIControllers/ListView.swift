//
//  ListView.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI
import NavigationStack

struct ListView: View {
    
    var screenRect = UIScreen.main.bounds
    
    var categories:[String:[Device]] {
        .init(
            grouping: deviceData,
            by: {$0.category.rawValue}
        )
    }
    
    var body: some View {
        NavigationStackView(transitionType: .custom(.slide), easing: .easeInOut) {
            Screen {
                VStack {
                    Text("Museum")
                        .padding(.top, 30)
                        .font(Font.system(size: 25, weight: .semibold))
                        .frame(width: self.screenRect.width-35, height: 15, alignment: .leading)
                        .foregroundColor(.blue)
                    
                    Text("Devices")
                        .font(Font.system(size: 40, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: self.screenRect.width-35, height: 30, alignment: .topLeading)
                        .padding(.top, 7)
                        .padding()
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: self.screenRect.width-30, height: 5, alignment: .center)
                        .foregroundColor(Color.blue)
                    
                    List(self.categories.keys.sorted(by: >),
                        id: \.self){ key in DeviceStack(categoryName: "\(key)", devices: self.categories[key]!)
                            .frame(height: 290)
                            .padding(.top, 8)
                            .padding(.bottom)
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
