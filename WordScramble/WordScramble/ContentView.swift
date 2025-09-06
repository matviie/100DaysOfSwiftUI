import SwiftUI

struct ContentView: View {
    
    @State private var usedWord = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    @State private var questionCount = 1
    private let maxQuestions = 10
    
    @State private var showingFinalAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section {
                        ForEach(usedWord, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                    
                }
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("OK") { }
                } message: {
                    Text(errorMessage)
                }
                .alert("Game over", isPresented: $showingFinalAlert) {
                    Button("Restart") {
                        restartGame()
                    }
                } message: {
                    Text("Your score is \(score) 🎉")
                }
                
                Text("Score: \(score) | Round: \(questionCount)")
                    .font(.largeTitle)
                
                Button("Next word") {
                    startGame()
                }
                .padding()
                .foregroundStyle(.white)
                .font(.headline)
                .background(.indigo)
                .clipShape(.capsule)
                
            }
        }
    }
    
    func restartGame() {
        usedWord.removeAll()
        score = 0
        questionCount = 0
        showingFinalAlert = false
    }
    
    func addNewWord() {
        
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isLong(word: answer) else {
            wordError(title: "Word not long", message: "Use words larger than three letters")
            return
        }
        
        score += answer.count
        
        
        withAnimation {
            usedWord.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        questionCount += 1
        
        if questionCount == maxQuestions {
            showingFinalAlert = true
        }
        usedWord.removeAll()
        
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // If we are here everything has worked, so we can exit
                return
            }
        }
        
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        if word == rootWord { return false }
        return !usedWord.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord // skippers
        
        for letter in word { // sir // s // i // r
            // firstIndex повертає індекс знайденого елемента
            if let pos = tempWord.firstIndex(of: letter) { // s = 0 // i = 1 // r = 4
                tempWord.remove(at: pos) // kippers // kppers // kppes
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLong(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        
        return true
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        
        
    }
}

#Preview {
    ContentView()
}


// MARK: Loading resources from app bundle
/*
 func testBundles() {
 if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
 
 // we found the file in our bundle
 
 if let fileContents = try? String(contentsOf: fileURL) {
 // we loaded the file into a string
 }
 }
 }
 */


// MARK: Working with strings
/*
 func testString() {
 let word = "swift"
 let checker = UITextChecker()
 
 let range = NSRange(location: 0, length: word.utf16.count)
 // Ініціює пошук слова з орфографічною помилкою в діапазоні рядка
 let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
 
 let allGood = misspelledRange.location == NSNotFound
 
 
 /*
  let input = """
  a
  b
  c
  """
  let letters = input.components(separatedBy: "\n")
  let letter = letters.randomElement()
  let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
  */
 }
 */
