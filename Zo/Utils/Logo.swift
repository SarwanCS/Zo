//
//  Logo.swift
//  Zo
//
//  Created by Brian Heralall on 4/21/22.
//

// A logo class to use for the walkthrough scenes. If a logo is needed anywhere, just call this class

import SwiftUI

struct Logo: View {
    var body: some View {
        ZStack{
            /*Image("Zwhite")
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .opacity(0.99)
            Image("Zblack")
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .offset(x: 5)*/
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .opacity(0.99)
        }
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
