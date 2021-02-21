//
//  InstaView.swift
//  Game of Life
//
//  Created by Lucas Wang on 2021-02-21.
//  Copyright © 2021 AppDev@UW. All rights reserved.
//

import SwiftUI

// UI dimensions has not been tuned yet, plz tune accordingly
struct InstaView: View {
    var body: some View {
      VStack {
        HStack(spacing: 50) {
          Text("<")
            .font(.title)
          Text("Posts")
            .font(.title)
          Text("Follow")
            .foregroundColor(.blue)
        }
        
        HStack {
          Image(systemName: "questionmark") //placeholder, profile pic
          VStack {
            Text("Some person")
              .font(.headline)
            Text("Some romantic place")
          }
          Spacer()
        }
        
        Image(systemName: "questionmark") //placeholder, main image OK we need to find something for this cause even Lucas cannot seem to get over the sheer degeneracy of using random people's pics
        
        HStack {
          HStack(spacing: 15) {
            Image(systemName: "heart")
            Image(systemName: "bubble.right")
            Image(systemName: "paperplane")
          }
          Spacer()
          Image(systemName: "bookmark")
        }
        
        HStack(spacing: 5) {
          Image(systemName: "questionmark")
          Image(systemName: "questionmark")
          Image(systemName: "questionmark")
          Text("Liked by some people and some other people")
          Spacer()
        }
        
        Text("the same valentine 4 years later... and I can still surprise him by how much dessrt I eat 😜")
        
        Button(action: {
          
        }) {
          Text("View all comments") // goes onto transition while showing all the positive comments?
        }
      }
    }
}

struct InstaView_Previews: PreviewProvider {
    static var previews: some View {
        InstaView()
    }
}
