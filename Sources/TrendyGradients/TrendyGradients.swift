// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

// MARK: - TrendyGradients

public struct TrendyGradients: ViewModifier {
  private let colors: (Color, Color)

  public init(colors: (Color, Color)) {
    self.colors = colors
  }

  public func body(content: Content) -> some View {
    content
      .background(
        Rectangle()
          .fill(
            LinearGradient(
              gradient: Gradient(colors: [colors.0, colors.1]),
              startPoint: .topLeading,
              endPoint: .bottomTrailing))
          .shadow(color: colors.0.opacity(0.5), radius: 6, x: 0.0, y: 0.0))
  }
}

// MARK: - AnimatedTrendyGradients

public struct AnimatedTrendyGradients: ViewModifier {

  // MARK: Lifecycle

  public init(colors1: [Color] = [Color.red, Color.blue], colors2: [Color] = [Color.green, Color.yellow]) {
    self.colors1 = colors1
    self.colors2 = colors2
  }

  // MARK: Public

  public func body(content: Content) -> some View {
    content.background(ZStack {
      Rectangle()
        .fill(
          LinearGradient(
            gradient: Gradient(colors: colors1),
            startPoint: .topLeading,
            endPoint: .bottomTrailing))
        .opacity(isAnimating ? 0 : 1)

      Rectangle()
        .fill(
          LinearGradient(
            gradient: Gradient(colors: colors2),
            startPoint: .topLeading,
            endPoint: .bottomTrailing))
        .opacity(isAnimating ? 1 : 0)

    }.onAppear {
      withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: true)) {
        isAnimating = true
      }
    })
  }

  // MARK: Private

  private let colors1: [Color]
  private let colors2: [Color]


  @State private var isAnimating = false

}

extension View {
  public func trendyGradients(colors: (Color, Color)) -> some View {
    modifier(TrendyGradients(colors: colors))
  }

  public func animatedTrendyGradients(
    colors1: [Color] = [Color.red, Color.blue],
    colors2: [Color] = [Color.green, Color.yellow])
    -> some View
  {
    modifier(AnimatedTrendyGradients(colors1: colors1, colors2: colors2))
  }
}

#if DEBUG
#Preview("TrendyGradients") {
  VStack {
    Text("Trendy Gradients")
      .font(.title)
      .padding()
      .foregroundColor(.white)

  }.trendyGradients(colors: (Color.pink, Color.purple))
}

#Preview("AnimatedTrendyGradients") {
  VStack {
    Text("Animated Trendy Gradients")
      .font(.title)
      .padding()
      .foregroundColor(.white)

  }.animatedTrendyGradients()
}
#endif
