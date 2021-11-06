//
//  SwiftUIText.swift
//  SwiftUIDemo
//
//  Created by Ravi Patel on 10/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SwiftUIText: View {
    var strId = ""
    @State var dictData: [SwiftUIResultModel] = []
    let webService = SwiftUIWebService()
    
    var body: some View {
        Text("Your Id is \(strId)")
    }
}

struct IdView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIText()
    }
}
