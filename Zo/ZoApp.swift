//
//  Zo_2App.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI
import Foundation

@main
struct ZoApp: App {
    

    @AppStorage("signUp") var signedUp = false
    @AppStorage("firstTime") var firstTime = true
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var isDarkModeOn = false
    @State var loggedIn = false
    
    //var vm = UserStateViewModel
    
    @StateObject var dataController = DataController()
    
    init(){
        setAppTheme()
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            /** If it's the user's first time, they will be prompted with the Walkthrough and if they're not a new user, they will automatically be prompted with the sign in **/
            if firstTime {
                WalkthroughDelegate(loggedIn: $loggedIn)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(dataController)
            }else{
                //if signedUp {
                    if loggedIn {
                        ContentView()
                            .environment(\.managedObjectContext, dataController.container.viewContext)
                            .environmentObject(dataController)
                    }else{
                        NewLogin(loggedIn: $loggedIn)
                    }
                //}else{
                    //NewLogin(loggedIn: $loggedIn)
                //}
            }
        }
    }
    
    /** App Theme meaning dark and light mode **/
    func setAppTheme(){
        //MARK: use saved device theme from toggle
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        changeDarkMode(state: isDarkModeOn)
        //MARK: or use device theme
        if (colorScheme == .dark)
        {
            isDarkModeOn = true
        }
        else{
            isDarkModeOn = false
        }
        changeDarkMode(state: isDarkModeOn)
    }
    
    /** Toggle App Theme  **/
    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ?   .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    
    
}


