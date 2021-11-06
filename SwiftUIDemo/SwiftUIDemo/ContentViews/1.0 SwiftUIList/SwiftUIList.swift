//
//  SwiftUIList.swift
//  SwiftUIDemo
//
//  Created by Ravi Patel on 09/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SwiftUIList: View {
    @State var dictData: [SwiftUIResultModel] = []
    let webService = SwiftUIWebService()
    
    var body: some View {
        NavigationView {
                List(dictData) { item in
                    HStack(spacing: 16.0) {
                        WebImage(url: URL(string: item.media[0].gifURL))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .scaledToFill()
                            .frame(width: 75, height: 75, alignment: .center)
                            .clipShape(Circle())
                        
                        Divider()
                            .background(Color.blue)
                        
                        Text(item.id)
                            .font(.headline)
                        
                    }
                    NavigationLink(destination: SwiftUILazyGrid()) { }
                        .frame(width: 0.0)
                        
                }.onAppear {
                    webService.getData { (response) in
                        dictData = response!.results
                    }
                }.navigationBarTitle("List View", displayMode: .inline)
            }
    
}
}

struct SwiftUIContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwiftUIList()
        }
    }
}
