//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Ravi Patel on 11/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
        }.onAppear(perform: {
            NavigationLink(destination: SwiftUIList()) { }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
