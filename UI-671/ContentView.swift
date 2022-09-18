//
//  ContentView.swift
//  UI-671
//
//  Created by nyannyan0328 on 2022/09/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
