//
//  ExtensionsView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 29.03.2022.
//

import Foundation
import SwiftUI

public extension View {
    func fullBackground(imageName: String) -> some View {
       return background(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
       )
    }
}

public extension View {
    func drawBorder(color : Color) -> some View{
        return overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color, lineWidth: 4)
        )
    }
}

public extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}
