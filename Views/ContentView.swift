import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            ZStack {
                
                AppBackground()

                VStack(spacing: 24) {

                    Spacer()

                    // Logo
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .padding(.bottom, 10)

                    // Titel
                    Text("Managerial Grid Führungsstil-Selbsttest")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // Beschreibung
                    Text("Dieser Selbsttest ermittelt Ihre Ausprägung in den Dimensionen Aufgabenorientierung und Mitarbeiterorientierung nach dem Managerial Grid von Blake und Mouton.\n\nDas Modell beschreibt Führungsverhalten anhand dieser beiden Faktoren und dient als Hilfsmittel, um unterschiedliche Führungsstile besser zu verstehen und einzuordnen.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)

                    // Start-Button
                    NavigationLink {
                        QuestionView()
                    } label: {
                        Text("Test starten")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding(.horizontal, 40)

                    Spacer()
                }
                .padding()
            }
        }
    }
}
