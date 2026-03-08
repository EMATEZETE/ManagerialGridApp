import SwiftUI

struct QuestionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var aktuellerIndex = 0
    @State private var antworten: [Int: AntwortOption] = [:]
    @State private var zeigeErgebnis = false
    @State private var zeigeHinweis = false
    @State private var zeigeAbbruchDialog = false
    
    // feste Höhe für den Fragetextbereich
    private let frageTextBereichHoehe: CGFloat = 150
    
    var body: some View {
        ZStack {
            
            AppBackground()
            
            VStack {
                
                // Oberer Bereich
                VStack(spacing: 16) {
                    
                    Text("Frage \(aktuellerIndex + 1) von \(alleFragen.count)")
                        .font(.headline)
                    
                    ProgressView(
                        value: Double(aktuellerIndex + 1),
                        total: Double(alleFragen.count)
                    )
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(.blue)
                    .scaleEffect(x: 1, y: 2)
                    .padding(.horizontal)
                    
                    // Fragekarte
                    VStack {
                        Text(alleFragen[aktuellerIndex].text)
                            .font(.system(size: 18, weight: .medium))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .frame(height: frageTextBereichHoehe)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    
                }
                .padding(.top)
                
                // Antwortoptionen
                VStack(spacing: 12) {
                    ForEach(AntwortOption.allCases, id: \.self) { option in
                        
                        Button {
                            antworten[aktuellerIndex] = option
                        } label: {
                            Text(optionTitel(option))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    antworten[aktuellerIndex] == option
                                    ? Color.blue
                                    : Color.gray.opacity(0.2)
                                )
                                .foregroundColor(
                                    antworten[aktuellerIndex] == option
                                    ? .white
                                    : .black
                                )
                                .cornerRadius(12)
                        }
                        .contentShape(Rectangle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                if zeigeHinweis {
                    Text("Bitte wählen Sie zunächst eine Antwort aus.")
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 6)
                }
                
                Spacer()
                
                // Navigation Buttons unten
                HStack(spacing: 20) {
                    
                    if aktuellerIndex == 0 {
                        Button {
                            zeigeAbbruchDialog = true
                        } label: {
                            Text("Abbrechen")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    } else {
                        Button {
                            aktuellerIndex -= 1
                        } label: {
                            Text("Zurück")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    
                    Button {
                        if antworten[aktuellerIndex] == nil {
                            zeigeHinweis = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                zeigeHinweis = false
                            }
                            
                            return
                        }
                        
                        if aktuellerIndex < alleFragen.count - 1 {
                            aktuellerIndex += 1
                        } else {
                            zeigeErgebnis = true
                        }
                        
                    } label: {
                        Text("Weiter")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
        // ✅ iOS 16+ Navigation (ersetzt NavigationLink(isActive:))
        .navigationDestination(isPresented: $zeigeErgebnis) {
            ResultView(antworten: antworten) {
                starteTestNeu()
            }
        }
        .navigationBarBackButtonHidden(true)   // entfernt den Button oben links
        .alert("Test wirklich abbrechen?",
               isPresented: $zeigeAbbruchDialog) {
            
            Button("Fortfahren", role: .cancel) { }
            
            Button("Abbrechen bestätigen", role: .destructive) {
                dismiss()
            }
            
        } message: {
            if antworten.count > 0 {
                Text("Wenn Sie abbrechen, gehen alle bisher gespeicherten Antworten verloren.")
            } else {
                Text("Möchten Sie den Test wirklich abbrechen?")
            }
        }
    }
    
    // Neustart
    func starteTestNeu() {
        zeigeErgebnis = false
        aktuellerIndex = 0
        antworten = [:]
        zeigeHinweis = false
        zeigeAbbruchDialog = false
        dismiss()
    }
    
    // Titel der Antwortoption
    func optionTitel(_ option: AntwortOption) -> String {
        switch option {
        case .nie: return "Nie"
        case .selten: return "Selten"
        case .manchmal: return "Manchmal"
        case .oft: return "Oft"
        case .sehrOft: return "Sehr oft"
        case .immer: return "Immer"
        }
    }
}
