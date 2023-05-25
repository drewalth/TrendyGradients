import SwiftUI

struct ContentView: View {
    let colors: [Color] = [
        .red, .green, .blue, .orange, .yellow, .pink, .purple, .blue, .indigo, .mint
    ]
    
    var body: some View {
        ScrollView {
            let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
            AnimatedExampleView()
            LazyVGrid(columns: columns) {
                ForEach(0..<colors.count, id: \.self) { i in
                    ForEach(i+1..<colors.count, id: \.self) { j in
                        GradientView(colors: (colors[i], colors[j]))
                            .padding()
                    }
                }
            }
        }.padding(.top, 16)
    }
}

struct GradientView: View {
    let colors: (Color, Color)
    
    var body: some View {
        Text("Hello")
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 100, height: 100, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [colors.0, colors.1]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: colors.0.opacity(0.5), radius: 6, x: 0.0, y: 0.0)
            )
    }
}

struct AnimatedExampleView: View {
    @State private var isAnimating = false

    let colors1 = [Color.red, Color.blue]
    let colors2 = [Color.green, Color.yellow]

    var body: some View {
        Text("Animated")
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 200, height: 200)
            .background(
                AnimatedGradientView(isAnimating: $isAnimating, colors1: colors1, colors2: colors2)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
    }
}

struct AnimatedGradientView: View {
    @Binding var isAnimating: Bool
    let colors1: [Color]
    let colors2: [Color]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: colors1),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .opacity(isAnimating ? 0 : 1)

            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: colors2),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .opacity(isAnimating ? 1 : 0)
        }
    }
}
