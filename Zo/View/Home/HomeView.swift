//
//  HomeView.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI

struct HomeView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var longPressed = false
    @State var startAnimation = false
    
    
    let cellSize = screenW/2 - 29
    
    
    
    var animation: Animation {
        Animation
            .default
            .speed(5)
    }
    
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: []) var snips: FetchedResults<Snip>
    
    @State var defaultsSnipsArray: [Sniptest] = []
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        Image("HomeBubble")
                        Spacer()
                    }
                    Spacer()
                } .ignoresSafeArea()
                
                /** If the homepage is empty than the page will view a statement saying that the homepage is empty.
                 Else if it indeed is
                 
                 ScrollView is what will display the content within the scrollable region (What's utilized to actually scroll
                 
                 LazyVGrid is the constraints that the shortcuts would be place in, hence Vertical Stack and in columns
                 
                    If the shortcut is longPressed (if you hold on the shortcut)
                    Then the animation will appear where you will be able to delete a shortcut
                 
                 **/
                if snips.isEmpty {
                    HStack{
                        Image("homeEmpty").resizable().scaledToFit().frame(width: screenW - 100)
                            .onAppear {
                                longPressed = false
                                startAnimation = false
                            }
                            .padding(.bottom, 150)
                    }
                }else{
                    
                    ScrollView{
                        VStack{
                            LazyVGrid(columns: columns, spacing: 12){
                                ForEach(snips){ snip in
                                    if longPressed {
                                        CustomGridCell(snip: snip, longPressed: $longPressed)
                                            .rotationEffect(Angle.degrees(startAnimation ? 2 : 0))
                                            .rotationEffect(Angle.degrees(longPressed ? -1 : 0))
                                        
                                    }else{
                                        CustomGridCell(snip: snip, longPressed: $longPressed)
                                            .onTapGesture {  }
                                            .simultaneousGesture(
                                                LongPressGesture(minimumDuration: 1)
                                                    .onEnded { _ in
                                                        longPressed = true
                                                        withAnimation(animation.repeat(while: longPressed)){
                                                            startAnimation = true
                                                        }
                                                    }
                                            )
                                    }
                                }
                                
                            }
                        }.padding()
//                            .padding(.horizontal, 25)
                        
                    }
                    
                }
            }.navigationTitle("Home")
            
        }.onTapGesture {
            longPressed = false
            startAnimation = false
                
        }
        .onAppear(perform: {
            //print(snips)
            update()
            
            //print(defaultsSnipsArray)
            
        })
        
        
        
        
        
        /** THE COMMENTED OUT CODE WAS USED IN TESTING THE SCROLL CAPABILITY. CAN USE FOR REFERENCE **/
        /** THE COMMENTED OUT CODE WAS USED IN TESTING THE SCROLL CAPABILITY. CAN USE FOR REFERENCE **/
        /** THE COMMENTED OUT CODE WAS USED IN TESTING THE SCROLL CAPABILITY. CAN USE FOR REFERENCE **/
        /** THE COMMENTED OUT CODE WAS USED IN TESTING THE SCROLL CAPABILITY. CAN USE FOR REFERENCE **/
        /** THE COMMENTED OUT CODE WAS USED IN TESTING THE SCROLL CAPABILITY. CAN USE FOR REFERENCE **/
        
        /*
        
        
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        Image("HomeBubble")
                        Spacer()
                    }
                    Spacer()
                } .ignoresSafeArea()
                
                if snips.isEmpty {
                    HStack{
                        Image("homeEmpty").resizable().scaledToFit().frame(width: screenW - 100)
                            .onAppear {
                                longPressed = false
                                startAnimation = false
                            }
                            .padding(.bottom, 150)
                    }
                }else{
                    ScrollView{
                        VStack{
                            LazyVGrid(columns: columns, spacing: 12){
                                ForEach(snips){ snip in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(snip.color ?? ""))
                                            .frame(width: cellSize, height: cellSize)
                                        VStack{
                                            Image(systemName: snip.image ?? "")
                                                .font(.system(size: 35, weight: .bold))
                                            Text(snip.name ?? "")
                                                .font(.system(size: 15, weight: .bold))
                                                .padding(.top, 15)
                                            
                                        }.foregroundColor(.white)
                                        
                                }
                                }
                            }
                        }.padding()
//                            .padding(.horizontal, 25)
                        
                        
                        ForEach(snips){ snip in
                        if longPressed {
                            CustomGridCell(snip: snip, longPressed: $longPressed)
                                .rotationEffect(Angle.degrees(startAnimation ? 2 : 0))
                                .rotationEffect(Angle.degrees(longPressed ? -1 : 0))
                        } else {
                            CustomGridCell(snip: snip, longPressed: $longPressed)
                                .onTapGesture {}
                                .simultaneousGesture(
                                    LongPressGesture(minimumDuration: 1)
                                        .onEnded { _ in
                                            longPressed = true
                                            withAnimation(animation.repeat(while: longPressed)){
                                            startAnimation = true
                        }
                    }
                    )
                    }
                        }
                        
                    }
                }
            }.navigationTitle("Home")
            
        }.onTapGesture {
            longPressed = false
            startAnimation = false
                
        }
        .onAppear(perform: {
            //print(snips)
            update()
            
            //print(defaultsSnipsArray)
            
        })
        
        
        */
        
        
        
        
        /*
        
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Image("HomeBubble")
                        Spacer()
                    }
                    Spacer()
                }.ignoresSafeArea()
                
                if snips.isEmpty {
                    HStack {
                        Image("homeEmpty").resizable().scaledToFit().frame(width: screenW - 100)
                            .onAppear {
                                longPressed = false
                                startAnimation = false
                            }
                            .padding(.bottom, 150)
                    }
                } else {
                    ScrollView {
                        VStack {
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(snips) { snip in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(snip.color ?? ""))
                                            .frame(width: cellSize, height: cellSize)
                                        VStack{
                                            Image(systemName: snip.image ?? "")
                                                .font(.system(size: 35, weight: .bold))
                                            Text(snip.name ?? "")
                                                .font(.system(size: 15, weight: .bold))
                                                .padding(.top, 15)
                                            
                                        }.foregroundColor(.white)
                                        
                                        if longPressed {
                                            CustomGridCell(snip: snip, longPressed: $longPressed)
                                                .rotationEffect(Angle.degrees(startAnimation ? 2 : 0))
                                                .rotationEffect(Angle.degrees(longPressed ? -1 : 0))
                                        } else {
                                            CustomGridCell(snip: snip, longPressed: $longPressed)
                                                .onTapGesture {}
                                                .simultaneousGesture(
                                                    LongPressGesture(minimumDuration: 1)
                                                        .onEnded { _ in
                                                            longPressed = true
                                                            withAnimation(animation.repeat(while: longPressed)){
                                                            startAnimation = true
                                        }
                                    
                                    }
                                                    
                                    )
                                    }
                                }
                            }
                        }.padding()
                    }
                }
                
                };.navigationTitle("Home")
        
            } .onTapGesture {
            longPressed = false
            startAnimation = false
         
            }
        
        .onAppear(perform: {
            update()
    })
}

}*/
    }
        
    /** Function to update the home view with shortcuts that the user has made. The use of JSON Encoder is to parse into JSON data for easier data model usage and storing user data **/
    func update() {
        for snip in snips {
            let defaultSnip = Sniptest(name: snip.name ?? "", content: snip.content ?? "", color: snip.color ?? "", image: snip.image ?? "", pickedimage: snip.pickedimage ?? Data())
            defaultsSnipsArray.append(defaultSnip)
        
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(defaultsSnipsArray) {
                shareDefault.set(encoded, forKey: "snip")
            }
        }
    }
}


/** The look of the user's specified shortcuts and functionality**/
struct CustomGridCell: View {
    let snip: Snip
    @Binding var longPressed: Bool
    @Environment(\.managedObjectContext) var moc
    let cellSize = screenW/2 - 29
    
    /** Functional usage to remove a shortcut and update the HomeView with said information, so that the change will reflect to the database **/
    func RemoveShortcut(delName: String!) {
        var a: [Sniptest] = []
        
        if let savedSnips = shareDefault.object(forKey: "snip") as? Data {
            let decoder = JSONDecoder()
            if let loadedSnip = try? decoder.decode([Sniptest].self, from: savedSnips) {
                a = loadedSnip.uniqued()
            }
            
        }
        if let index = a.firstIndex(where: {
            $0.name == delName}){
            a.remove(at: index)
        }
        /*let defaultSnip = Sniptest(name: "Third", content: "Third Content", color: "TextSnipColor", image: "doc.text.image", pickedimage: Data())
        a.append(defaultSnip)*/
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(a) {
            shareDefault.set(encoded, forKey: "snip")
    }
    }
    
    var body: some View {
        
        /** Look and style of the user's shortcut conforming to the Home page **/
        ZStack{
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(snip.color ?? ""))
                .frame(width:cellSize, height: cellSize)
            VStack{
                Image(systemName: snip.image ?? "")
                    .font(.system(size: 35, weight: .bold))
                Text(snip.name ?? "")
                    .font(.system(size: 15, weight: .bold))
                    .padding(.top, 15)
                
            }.foregroundColor(.white)
            
        }.overlay(
            /** Look and action of the user removing a shortcut(s) **/
            ZStack{
                if longPressed {
                    Button(action: {
                        //HomeView.removeSnip(snip.name)
                        RemoveShortcut(delName: snip.name)
                        moc.delete(snip)
                        try? moc.save()
                    }, label: {
                        ZStack{
                            Circle()
                                .fill(.red)
                                .frame(width: 30, height: 30)
                        }
                    })
                    Image(systemName: "minus")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                }
            }.offset(x: 5, y: -10)
            , alignment: .topTrailing
            
        )
        .padding(.horizontal,25)
    }
}

