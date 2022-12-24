//
//  MissionView.swift
//  MoonshotApp
//
//  Created by Kiran Sonne on 24/11/22.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    VStack(alignment: .leading){
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                
                        Text("Mission Highlight")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                    
                        Text("Crew")
                           .font(.title.bold())
                       
                    
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(Capsule())
                                            .overlay(
                                            Capsule()
                                                .stroke(.white, lineWidth: 1)
                                    )
                                        VStack(alignment: .leading) {
                                            Text(crewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    
                    
                    
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
     }
    init(mission: Mission, astrounauts: [String: Astronaut]){
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astrounaut = astrounauts[member.name] {
                return CrewMember(role: member.role, astronaut: astrounaut)
            }else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astrounauts: astronaut)
            .preferredColorScheme(.dark)
    }
}
