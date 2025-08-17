import SwiftUI

struct ContentView: View {
    
    @State private var items = ["🪨", "📄", "✂️"].shuffled()
    @State private var randomItem = Int.random(in: 0...2)
    
    @State private var modes = ["Win", "Lose"].shuffled()
    
    var body: some View {
        
            VStack(spacing: 30) {
                HStack(spacing: 60) {
                    Text(items[randomItem])
                        .font(.system(size: 100))
                    
                    
                    Text(modes[0])
                        .font(.largeTitle.weight(.heavy))
                        .foregroundStyle(.secondary)
                        .padding(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(modes[0] == "Win" ? .green : .red, lineWidth: 5)
                        )
                }
                .frame(width: .infinity)
                .padding(40)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                //                arrow.down.square
                //                arrow.down.app.fill
                
                Image(systemName: "arrow.down.app.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.ultraThinMaterial)
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            //
                        } label: {
                            Text(items[number])
                                .font(.system(size: 100))
                        }
                    }
                }
                .frame(width: .infinity)
                .padding(.vertical, 40)
                .padding(.horizontal, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Text("Score: ???")
                    .font(.largeTitle)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.indigo.gradient)
        
        
    }
    
    func itemTapped(_ number: Int) {
//        var answer: Bool
        
        
    }
}

#Preview {
    ContentView()
}
