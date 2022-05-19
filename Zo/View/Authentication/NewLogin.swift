//
//  NewLogin.swift
//  Zo
//
//  Created by Brian Heralall on 5/18/22.
//

import AuthenticationServices
import SwiftUI
import CloudKit


/** Credentials of user would be stored in these variables for usage **/

struct AppleUser: Codable {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential) {
        guard
            let firstName = credentials.fullName?.givenName,
            let lastName = credentials.fullName?.familyName,
            let email = credentials.email
                
        else { return nil }
        
        self.userId = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

/** This login view is in replacement of the SignUp view because of the fact that you technically don't have to sign up if you're signing in with Apple **/

struct NewLogin: View {
    @Environment(\.colorScheme) var colorScheme
    //@AppStorage("loginUpdate") var loggedInUpdate = false
    @Binding var loggedIn: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Image("UpperBubble")
                        Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Image("LowerBubble")
                }
            }
            VStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Welcome to ZoZo!")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.bottom, 2)
                    Text("Create shortcuts for the pictures, text phrases, files & links you use the most and access them right from the ZoZo keyboard.")
                    HStack {
                        Spacer()
                        /** Sign In With Apple Button (UI) **/
                        SignInWithAppleButton(
                            .signIn,
                            onRequest: configure,
                            onCompletion: handle
                        )
                            .signInWithAppleButtonStyle(
                                colorScheme == .dark ? .white : .black /** Button conforms to light and dark mode **/
                            )
                            .frame(height: 45)
                        .padding()
                        .padding(.top, 30)
                        Spacer()
                    }
                }.padding(30)
                    .padding(.bottom, 70)
                Spacer()
            }
        }.overlay(alignment: .topLeading, content: {
            Logo()
                .padding(40)
        })
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        }
    }
    
    /** Function that handles this: Once user clicks on button, sign in will request name and email of the user for sign in. Will configure to get back properties in function. **/
    func configure(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    /** Deals with result of sign in. Result<ASAuthorization> = Successful Sign In, Vice - Versa. The print statements will help to determine what's working in the handle function. **/
    func handle(_ authResult: Result<ASAuthorization, Error>) {
        switch authResult {
        case .success(let auth):
            //loggedInUpdate = true
            loggedIn = true
            //print(auth)
            switch auth.credential {
            /** Will collect the user's credentials that we're interested in as per the AppleUser function above. JSON will parse that data to store **/
            case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                if let appleUser = AppleUser(credentials: appleIdCredentials),
                    let appleUserData = try? JSONEncoder().encode(appleUser) {
                    UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)
                    
                    print("saved apple user", appleUser)
                } else {
                    print("missing some fields", appleIdCredentials.email, appleIdCredentials.fullName, appleIdCredentials.user)
                    
                    guard
                        let appleUserData = UserDefaults.standard.data(forKey: appleIdCredentials.user),
                        let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
                    else {return}
                    
                    print(appleUser)
                }
                
            default:
                print(auth.credential)
            }
            
        case .failure(let error):
            print(error)
        }
    }

}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
*/
