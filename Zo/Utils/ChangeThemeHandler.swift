//
//  ChangeThemeHandler.swift
//  Zo
//
//  Created by Brian Heralall on 4/21/22.
//

// Caters to the user's mode that they've adjusted on their phone.
// If the user is in dark mode, the app will default to dark mode. Vice - versa

import Foundation

class UserDefaultsUtils {
    static var shared = UserDefaultsUtils()
    func setDarkMode(enable: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(enable, forKey: Constants.DARK_MODE)
    }
    func getDarkMode() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Constants.DARK_MODE)
    }
}


class Constants {
    public static let DARK_MODE = "DARK_MODE"
    public static let LIGHT_MODE = "LIGHT_MODE"
}
