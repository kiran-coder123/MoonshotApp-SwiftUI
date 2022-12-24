//
//  ContentView.swift
//  MoonshotApp
//
//  Created by Kiran Sonne on 23/11/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State private  var showingGrid = false
    @State private  var showingList = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(mission) { mission in
                        NavigationLink {
                              MissionView(mission: mission, astrounauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                                 
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal,.bottom])
            }
            
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            
//            .toolbar {
//                ToolbarItem(placement: .bottomBar){
//                    Button("List", action: {showList()})
//                        .foregroundColor(.white)
//                        .font(.title)
//                 }
//                ToolbarItem(placement: .bottomBar){
//                    Button("Grid", action: {showGridView()})
//                        .foregroundColor(.white)
//                        .font(.title)
//                 }
//            }
        }
    }
//    func showList() {
//        print("item show in grid ")
//     }
//    func showGridView() {
//        print("item show in grid ")
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
