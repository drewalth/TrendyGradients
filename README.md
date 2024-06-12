# TrendyGradients

Super cool boxes with trendy neon gradient backgrounds for SwiftUI. Use the provided ViewModifiers or copy pasta and make your own :) 

![photo](trendy-hero.gif)

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/drewalth/TrendyGradients.git", from: "2.0.0")
]
```

## Usage
    
### ViewModifier - Default

```swift
import TrendyGradients

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(TrendyGradient())
                .cornerRadius(10)
                .padding()
        }.gradient(colors: (Color.pink, Color.purple))
    }
}
```

### ViewModifier - Animated

```swift
import TrendyGradients

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(TrendyGradient())
                .cornerRadius(10)
                .padding()
        }.animatedGradient(colors1: [Color.red, Color.blue], colors2: [Color.green, Color.yellow])
    }
}
```

### ButtonStyle

```swift
import TrendyGradients

Button("Gradient Button") {
  print("Button tapped")
}.gradientButton(colors: (Color.pink, Color.purple))
  .foregroundColor(.white)
```
