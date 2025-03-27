//
//  ProfileView.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject var presenter: ProfilePresenter

    var body: some View {
        VStack(spacing: 16) {
            Image("ic-profile-avatar")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 5)

            Text("Mario Alexander")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text("iOS Developer")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
