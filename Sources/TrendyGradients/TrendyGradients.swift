// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

// MARK: - GradientButtonStyle

public struct GradientButtonStyle: ButtonStyle {

  // MARK: Lifecycle

  public init(colors: (Color, Color), animated: Bool = false) {
    self.colors = colors
    self.animated = animated

    colorSetOne = [colors.0, colors.1]
    colorSetTwo = [colors.1, colors.0]
  }

  // MARK: Public

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(
            LinearGradient(
              gradient: Gradient(colors: [colors.0, colors.1]),
              startPoint: .topLeading,
              endPoint: .bottomTrailing)
              .opacity(configuration.isPressed ? 0.8 : 1)))
  }

  // MARK: Private

  private let colors: (Color, Color)
  private let animated: Bool
  private let colorSetOne: [Color]
  private let colorSetTwo: [Color]
}

// MARK: - TrendyGradientViewModifier

/// A view modifier that applies a gradient to the background of the view.
public struct TrendyGradientViewModifier: ViewModifier {
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

// TODO: rework the modifier API to something like: `.trendyGradients(colors: (Color.pink, Color.purple), animation: .easeInOut(duration: 2))`

/// A view modifier that applies an animated gradient to the background of the view.
/// It animates between two sets of colors.
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

// MARK: - View Extensions

// MARK: General View Extensions

extension View {
  public func gradient(colors: (Color, Color)) -> some View {
    modifier(TrendyGradientViewModifier(colors: colors))
  }

  public func animatedGradient(
    colors1: [Color] = [Color.red, Color.blue],
    colors2: [Color] = [Color.green, Color.yellow])
    -> some View
  {
    modifier(AnimatedTrendyGradients(colors1: colors1, colors2: colors2))
  }
}

// MARK: - Gradient Button Styles Extensions

extension View {
  public func gradientButton(colors: (Color, Color)) -> some View {
    buttonStyle(GradientButtonStyle(colors: colors))
  }
}


#if DEBUG
#Preview("Gradient - Basic") {
  VStack {
    Text("Trendy Gradients")
      .font(.title)
      .padding()
      .foregroundColor(.white)
  }.gradient(colors: (Color.pink, Color.purple))
}

#Preview("Animated Gradient") {
  VStack {
    VStack {
      Text("Animated Gradients")
        .font(.title)
        .padding()
        .foregroundColor(.white)

    }.animatedGradient()
      .padding(.bottom, 24)
    VStack {
      Text("Animated Gradients")
        .font(.title)
        .padding()
        .foregroundColor(.white)

    }.animatedGradient(colors1: [.cyan, .yellow], colors2: [.yellow, .cyan])
  }
}

#Preview("Gradient Button Style - Default") {
  VStack {
    Button("Gradient Button") {
      print("Button tapped")
    }.gradientButton(colors: (Color.pink, Color.purple))
      .foregroundColor(.white)
  }
}
#endif
