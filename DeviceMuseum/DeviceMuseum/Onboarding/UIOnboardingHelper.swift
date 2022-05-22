//
//  File.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 22.05.22.
//

import UIKit
import UIOnboarding

struct UIOnboardingHelper {
    static func setUpIcon() -> UIImage {
        return Bundle.main.appIcon ?? .init(named: "onboarding-icon")!
    }

    static func setUpTitle() -> NSMutableAttributedString {
        let welcomeText: NSMutableAttributedString = .init(string: "Device \n",
            attributes: [.foregroundColor: UIColor.label]),
            appNameText: NSMutableAttributedString = .init(string: Bundle.main.displayName ?? "Museum",
            attributes: [.foregroundColor: UIColor.init(named: "camou")!])
        welcomeText.append(appNameText)
        return welcomeText
    }

    static func setUpFeatures() -> Array<UIOnboardingFeature> {
        return .init([
                .init(icon: .init(named: "person")!,
                title: "Please go through the registration",
                description: "Enter your email and create a password to register a user."),
                .init(icon: .init(named: "iphone")!,
                title: "The main menu consists of 4 categories of devices",
                description: "Clicking on an item opens a detailed view of the device with a rotated 3D image and a detailed description."),
                .init(icon: .init(named: "map")!,
                title: "Map navigation",
                description: "Using maps you can get acquainted with the location of the museum."),
                .init(icon: .init(named: "arkit")!,
                title: "Get an augmented reality experiences",
                description: "Rotate the 3D model 360 degrees, zoom in and out, explore the device from all angles.")
            ])
    }

    static func setUpNotice() -> UIOnboardingTextViewConfiguration {
        return .init(icon: .init(named: "apple")!,
            text: "App developed and designed for detailed view of devices history.",
            linkTitle: "Open web site...",
            link: "https://www.apple.com",
            tint: .init(named: "camou"))
    }

    static func setUpButton() -> UIOnboardingButtonConfiguration {
        return .init(title: "Continue",
            backgroundColor: .init(named: "camou")!)
    }
}

extension UIOnboardingViewConfiguration {
    static func setUp() -> UIOnboardingViewConfiguration {
        return .init(appIcon: UIOnboardingHelper.setUpIcon(),
            welcomeTitle: UIOnboardingHelper.setUpTitle(),
            features: UIOnboardingHelper.setUpFeatures(),
            textViewConfiguration: UIOnboardingHelper.setUpNotice(),
            buttonConfiguration: UIOnboardingHelper.setUpButton())
    }
}
