import SwiftUI

struct ContentView: View {
    
    let units = ["seconds", "minutes", "hours", "days"]
    @State private var selectedInputUnit = "days"
    @State private var selectedOutputUnit = "minutes"

    @State private var inputValue = 0.0

    var second: Double {
        switch selectedInputUnit {
        case "seconds":
            return inputValue
        case "minutes":
            return (inputValue * 60)
        case "hours":
            return (inputValue * 60 * 60)
        case "days":
            return (inputValue * 60 * 60 * 24)
        default:
            return 0
        }
    }
    
    var outputValue: Double {
        switch selectedOutputUnit {
        case "seconds":
            return second
        case "minutes":
            return (second / 60)
        case "hours":
            return (second / 60 / 60)
        case "days":
            return (second / 60 / 60 / 24)
        default:
            return 0
        }
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose input unit") {
                    
                    Picker("input unit", selection: $selectedInputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Input unit", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section("Choose output unit") {
                    
                    Picker("output unit", selection: $selectedOutputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("\(outputValue)")
                    
                }
            }
            .navigationTitle("Time")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
