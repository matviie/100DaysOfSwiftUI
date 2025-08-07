import SwiftUI

struct ContentView: View {
    @State private var counties = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var numberQuestion = 1
    private let maxQuestions = 8
    
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy)) // subheadline - Dynamic Type
                        
                        Text(counties[correctAnswer])
                            .font(.largeTitle.weight(.semibold)) // largeTitle - Dynamic Type
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            // flag was tapped
                            flagTapped(number)
                        } label: {
                            Image(counties[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Wrong! That’s the flag of \(counties[correctAnswer]).")
        }
        
        .alert("Game over!", isPresented: $showingFinalScore) {
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is \(score)/\(maxQuestions)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            askQuestion()
        } else {
            scoreTitle = "Wrong"
            showingScore = true
        }
        
        if numberQuestion == (maxQuestions + 1) {
            showingFinalScore = true
        }
    }
    
    func askQuestion() {
        counties.shuffle()
        correctAnswer = Int.random(in: 0...2)
        numberQuestion += 1
    }
    
    func reset() {
        score = 0
        numberQuestion = 1
        counties.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
