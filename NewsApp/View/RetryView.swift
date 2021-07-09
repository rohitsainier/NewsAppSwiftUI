//
//  RetryView.swift
//  NewsApp
//
//  Created by Rohit Saini on 09/07/21.
//

import SwiftUI

struct RetryView: View {
    let text:String
    let retryAction: () -> ()
    var body: some View {
        VStack(spacing:8){
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            Button(action: retryAction) {
                Text("Try Again")
            }
        }
    }
}


