//
//  ContentView.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI

/** After the user logs in, the ContentView will appear in which they will be able to navigate between the views **/

struct ContentView: View {
    @StateObject var bottomNavigationBarViewModel = BottomNavigationBarViewModel()
    @State var pickedView: TabView = .home
    var body: some View {
        VStack{
            switch(pickedView){
            case .home: AnyView(HomeView())
            case .add: AnyView(CreateView(bottomNavigationBarViewModel: bottomNavigationBarViewModel))
            case .settings: AnyView(SettingsView())
            }
            BottomTabBar(pickedView: $pickedView, bottomNavigationBarViewModel: bottomNavigationBarViewModel)
        }.ignoresSafeArea()
    }
}

/** Bottom Nav Bar view **/
struct BottomTabBar: View {
    
    @Binding var pickedView: TabView
    @Environment(\.colorScheme) var scheme
    
    @ObservedObject var bottomNavigationBarViewModel: BottomNavigationBarViewModel
    
    var body: some View {
        if bottomNavigationBarViewModel.showBottomBar {
            HStack(spacing: 120){
                Spacer()
                Button {
                    withAnimation {
                        pickedView = .home
                    }
                } label: {
                    Image(systemName: "house.circle")
                        .foregroundColor(pickedView == .home ? scheme == .dark ? .white : .black : .gray)
                }
                //Spacer()
                Button {
                    withAnimation {
                        pickedView = .add
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(pickedView == .add ? scheme == .dark ? .white : .black : .gray)
                }
                //Spacer()
                Button {
                    withAnimation {
                        pickedView = .settings
                    }
                } label: {
                    Image(systemName: "gear.circle")
                        .foregroundColor(pickedView == .settings ? scheme == .dark ? .white : .black : .gray)
                }

                Spacer()
            }.font(.system(size: 27, weight: .bold))
                .frame(height: screenH/10)
        }else{
            
        }
    }
}

enum TabView{
    case home, add, settings
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}

