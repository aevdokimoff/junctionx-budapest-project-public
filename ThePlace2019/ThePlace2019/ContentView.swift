//
//  ContentView.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import SwiftUI

struct GMapKitView: UIViewRepresentable {
    func updateUIView(_ uiView: MapController, context: UIViewRepresentableContext<GMapKitView>) {
    }
    
    func makeUIView(context: Context) -> MapController {
        MapController(frame: .zero)
    }
}

struct ContentView: View {
    
    @State var text = ""
    @State private var animals: Bool = false
    @State private var constructions: Bool = false
    @State private var presentPlaceManagerView: Bool = false
    func action() {
        
    }
    
    var body: some View {
            VStack {
                HStack(spacing: 10) {
                    Text(" Search address...")
                        .frame(minWidth: UIScreen.main.bounds.width - 110, maxWidth: .infinity, minHeight: 32, maxHeight: 32)
                        .background(Color.black.opacity(0.1))
                        .foregroundColor(Color.black.opacity(0.5))
                        .cornerRadius(8)
                        .padding(.horizontal, 8)
                        .onTapGesture {
                            self.presentPlaceManagerView = true
                        }

                    Button(action: {
                        print("clicked")
                    }) {
                        Text("🏢")
                    }

                    Button(action: {
                        print("clicked")
                    }) {
                        Text("🐗")
                    }.padding(.horizontal, 8)
                }
                GMapKitView()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
                
           
        }
        .sheet(isPresented: $presentPlaceManagerView) {
            NavigationView {
                PlaceManagerView()
            }
        }
        .onAppear(perform: action)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
