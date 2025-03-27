//
//  CustomEmptyView.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import SwiftUI

public struct CustomEmptyView: View {
    var image: String
    var title: String

    public var body: some View {
        VStack {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 250)

            Text(title)
                .font(.system(.body, design: .rounded))
        }
    }
}
