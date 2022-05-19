//
//  SettingsView.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @Environment(\.colorScheme) var scheme
    @Environment(\.openURL) var openURL
    
    @State private var isLog = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        Image("CreateSnipBubble")
                        Spacer()
                    }
                    Spacer()
                }
                VStack{
                    Spacer()
                    VStack{
                        
                        /** Toggle between light and dark mode button. If else to ensure the state of the UI is changed accordingly. **/
                        Button {
                            if scheme == .light {
                                changeDarkMode(state: true)
                            }else{
                                changeDarkMode(state: false)
                            }
                        } label: {
                            if scheme == .light {
                                CustomButton(text: "Toggle Dark Mode", isLogout: false, isDarkModeToggle: true)
                            } else {
                                CustomButton(text: "Toggle Light Mode", isLogout: false, isDarkModeToggle: true)
                            }
                        }

                    }
                    Spacer()
                    VStack{
                        
                        /** Terms & Agreements. In the form of a button and action where once the user clicks on the button, it will navigate them to Zo's terms & agreements */
                        Button(action: {

                            if let yourURL = URL(string: "https://app.termly.io/document/terms-of-use-for-online-marketplace/b5002e65-2c63-4367-ac78-49f355bf22f7") {
                                UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
                            }

                        }, label: {
                            CustomButton(text: "Terms & Agreements", isLogout: false, isDarkModeToggle: false)
                        })
                        
                        
                        /**Privacy Policy. In the form of a button and action where once the user clicks on the button, it will navigate them to Zo's privacy policy */
                        Button(action: {

                            if let yourURL = URL(string: "https://app.termly.io/document/privacy-policy/84fda466-df65-4c0d-96c3-5400d19bc050") {
                                UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
                            }

                        }, label: {
                            CustomButton(text: "Privacy Policy", isLogout: false, isDarkModeToggle: false)
                        })
                    }
                    Spacer()
                    VStack{
                        
                        /** Contact Us. In the form of a button and action where once the user clicks on the button, it will navigate them to a mail to view in which they will be able to send an email **/
                        Button(action: {
                            if MFMailComposeViewController.canSendMail() {
                                self.isShowingMailView.toggle()
                            } else {
                                print("Can't send emails from this device")
                            }
                            if result != nil {
                                print("Result: \(String(describing: result))")
                            }
                        }, label: {
                            CustomButton(text: "Contact Us", isLogout: false, isDarkModeToggle: false)
                        })
                        
                        /** The credentials of the composed email that would be send with the subject line and recepient **/
                        .sheet(isPresented: $isShowingMailView) {
                                    MailView(result: $result) { composer in
                                        composer.setSubject("ZoZo App Support")
                                        composer.setToRecipients(["ajpicard25@icloud.com"])
                                    }
                                }
                        
                        
                        
                        CustomButton(text: "Logout", isLogout: true, isDarkModeToggle: false)
                        
                        
                        
                    }
                    Spacer()
                }.padding(.top, 100)
            }.navigationTitle("Settings")
            .ignoresSafeArea()
            
        }
    }
    /** Toggle UI preference functionality **/
    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ?   .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}

/** The look and style of the button in SettingsView **/
struct CustomButton: View {
    let text: String
    let isLogout: Bool
    let isDarkModeToggle: Bool
    
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(isLogout ? Color("CustomRed") : scheme == .dark ? Color(.gray) : Color(.white))
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
                .fill(scheme == .dark ? .white : .black)
                
            HStack{
                if isDarkModeToggle{
                    Image(systemName: "moon.circle.fill")
                }
                Text(text)
                    .bold()
            }.foregroundColor(isLogout ? .white : scheme == .dark ? Color(.white) : Color(.black))
        }.frame(height: 60)
        .padding(.horizontal, 30)
            .padding(.bottom, 5)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

/** FOR TESTING PURPOSES, KEEP JUST IN CASE **/

struct LinkButton: View {
    let text: String
    let isLogout: Bool
    let isDarkModeToggle: Bool
    
    @Environment(\.colorScheme) var scheme
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
                .fill(scheme == .dark ? .white : .black)
                
            HStack{
                if isDarkModeToggle{
                    Image(systemName: "moon.circle.fill")
                }
                Button("Visit Apple") {
                    openURL(URL(string: "https://www.apple.com")!)
                }
                //Text(text)
                    //.bold()
            }.foregroundColor(isLogout ? .white : scheme == .dark ? Color(.white) : Color(.black))
        }.frame(height: 60)
        .padding(.horizontal, 30)
            .padding(.bottom, 5)
    }
}

/*struct SupportEmail {
    let toAddress: String
    let subject: String
    
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        guard let url = URL(string: urlString) else { return }
    }
}*/
