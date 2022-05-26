
import SwiftUI

//My first SwiftUI app

struct ContentView: View {
    
    @State private var billValue = 0.0
    @State private var peopleNumber: Int = 2
    @State private var tipsPes = 20
    
    @FocusState private var isFocused: Bool
    
    let tipsPecentage = [10,15,20,25,0]
    
    var totallPerPerson: Double {
        
        let doublePeople = Double(peopleNumber + 2)
        let doubleTips = Double(tipsPes)
        
        let tipsValue = billValue / 100 * doubleTips
        let grandSumm = billValue + tipsValue
        let perPerson = grandSumm / doublePeople
        
        return perPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Summ", value: $billValue, format: .currency(code: Locale.current.currencyCode ?? "USD" ))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                }
                Section {
                    Picker("Количество людей", selection: $peopleNumber) {
                        ForEach(2..<48) {human in
                            Text("\(human) человек")
                        }
                    }
                }
                Section {
                    Picker("Tips", selection: $tipsPes) {
                        ForEach(tipsPecentage, id: \.self) {
                            Text($0, format: .percent)
                        }
                        //                            ForEach(tipsPes) {choise in
                        //                                Text("\(choise)", format: .percent)
                        
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Хотите оставить чаевые?")
                }
                
                Section {
                    Text(totallPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD" ))
                }
            }
            .navigationTitle("WeSplit")

        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isFocused = false
                }
            }
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
