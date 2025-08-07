import SwiftUI

/*
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.pink)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
 */

/*
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
 */

// MARK: Challenge
struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func blueTitle() -> some View {
        modifier(BlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
//        Text("Hello, dear!")
////            .modifier(Title())
//            .titleStyle()
        
//        Color.blue
//            .frame(width: 300, height: 200)
//            .watermarked(with: "My content*")
        
        Text("Challenge with Modifiers")
            .blueTitle()
    }
}

#Preview {
    ContentView()
}
