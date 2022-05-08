//
//  BottomView.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}

struct BottomView<Content: View>: View {
    @Binding var isOpen: Bool

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.init(#colorLiteral(red: 0.890096128, green: 0.8902521729, blue: 0.8900978565, alpha: 1)))
            .frame(
            width: Constants.indicatorWidth,
            height: Constants.indicatorHeight
        ).onTapGesture {
            self.isOpen.toggle()
        }
    }

    init(isOpen: Binding<Bool>, maxHeight: CGFloat, minHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                self.content
            }
                .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
                .background(Color(.white))
                .cornerRadius(50)
                .frame(height: geometry.size.height, alignment: .bottom)
                .offset(y: max(self.offset + self.translation, 0))
                .animation(Animation.easeInOut(duration: 1.0), value: offset)
                //.animation(Animation.interactiveSpring())
                //.animation(.interactiveSpring())
                .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1).fill(Color.mint).edgesIgnoringSafeArea(.all)
            BottomView(isOpen: .constant(false), maxHeight: 600, minHeight: 400) {
                Rectangle().fill(Color.red)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}
