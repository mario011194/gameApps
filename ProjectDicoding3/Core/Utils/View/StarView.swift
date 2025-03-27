//
//  StarView.swift
//  ProjectDicoding3
//
//  Created by Mario Alexander on 3/20/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    let maxRating: Int = 5

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(systemName: self.starType(for: index))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.yellow)
            }
            Text(String(format: "%.2f", rating))
                .font(.system(size: 14))
                .fontWeight(.semibold)
        }
    }

    private func starType(for index: Int) -> String {
        let starValue = Double(index) + 1

        if rating >= starValue {
            return "star.fill"
        } else if rating >= starValue - 0.5 {
            return "star.lefthalf.fill"
        } else {
            return "star"
        }
    }
}
