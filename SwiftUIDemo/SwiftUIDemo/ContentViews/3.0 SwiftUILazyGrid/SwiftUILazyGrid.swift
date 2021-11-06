//
//  SwiftUILazyGrid.swift
//  SwiftUIDemo
//
//  Created by Ravi Patel on 11/08/21.
//

import SwiftUI

struct SwiftUILazyGrid: View {
    @State var jsonData: [SwiftUIJsonModel] = []
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 50
            ) {
                ForEach(jsonData.indices, id: \.self) { i in
                    HStack() {
                        VStack(spacing: 16.0) {
                            Image(jsonData[i].image).resizable()
                                .frame(width: 50.0, height: 50.0)
                                .scaledToFit()
                                .clipShape(Circle())
                            
                            Text("")
                                .foregroundColor(Color.green)
                            
                            Text(jsonData[i].name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                        }.padding(.top, 24.0).shadow(color: .gray, radius: 15, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/).onTapGesture {
                            NavigationLink(destination: SwiftUIText()) { }
                        }
                    }
                    
                    Divider()
                }
            }
        }
        .padding(.vertical, 16.0)
        .onAppear(perform: { setupData() })
        .navigationBarTitle("Grid View")
    }
    
    private func setupData() {
        let dictJson = readJsonFile(ofName: "FlowerList")
        if let arrJson = dictJson["list"] as? [Dictionary] {
            jsonData = arrJson.map({SwiftUIJsonModel(dict: $0)})
        }
    }
    
    /*private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]

    private var colors: [Color] = [.yellow, .purple, .green]

    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(width: 50, height: 50)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }*/
}

struct SwiftUILazyGrid_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUILazyGrid()
    }
}

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
