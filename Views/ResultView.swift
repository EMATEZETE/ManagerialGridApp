import SwiftUI

struct ResultView: View {

    let antworten: [Int: AntwortOption]
    let onNeustart: () -> Void

    var body: some View {

        let punkteAufgaben = berechnePunkte(fuer: .aufgabenorientierung)
        let punkteMitarbeiter = berechnePunkte(fuer: .mitarbeiterorientierung)

        let gridAufgaben = Double(punkteAufgaben) / 5.0
        let gridMitarbeiter = Double(punkteMitarbeiter) / 5.0

        let stil = bestimmeFuehrungsstil(
            gridAufgaben: gridAufgaben,
            gridMitarbeiter: gridMitarbeiter
        )

        return ZStack {

            AppBackground()

            ScrollView {
                VStack(spacing: 16) {

                    // Karte 1: Zahlen
                    kartenBlock {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Ihr Ergebnis")
                                .font(.title2)
                                .bold()

                            Text("Aufgabenorientierung: \(punkteAufgaben) Punkte")
                            Text("Mitarbeiterorientierung: \(punkteMitarbeiter) Punkte")

                            Divider()

                            Text("Grid-Wert Aufgaben: \(String(format: "%.1f", gridAufgaben))")
                            Text("Grid-Wert Mitarbeiter: \(String(format: "%.1f", gridMitarbeiter))")
                        }
                    }

                    // Karte: Führungsstil + Erklärung
                    kartenBlock {
                        VStack(alignment: .leading, spacing: 10) {

                            Text("Führungsstil")
                                .font(.headline)

                            Text(stil)
                                .font(.title3)
                                .bold()
                                .foregroundColor(.blue)

                            Text(erklaerungFuerStil(stil))
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }

                    // Reset Button 
                    Button {
                        onNeustart()
                    } label: {
                        Text("Test neu starten")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .contentShape(Rectangle())
                    .padding(.top, 8)
                }
                .padding()
            }
        }
    }

    // MARK: - Hilfsfunktionen

    func berechnePunkte(fuer dimension: Dimension) -> Int {
        var summe = 0

        for (index, antwort) in antworten {
            let frage = alleFragen[index]
            if frage.dimension == dimension {
                summe += antwort.punkte
            }
        }

        return summe
    }

    func erklaerungFuerStil(_ stil: String) -> String {

        switch stil {

        case "1,1 Gleichgültig":
            return "Impoverished Management: Die Aufgaben und die Mitarbeiter stehen hier nur minimal im Fokus der Führungskraft. Dies bedeutet, dass sich auch das Führungsverhalten nur in reduzierter Form auf die Arbeitsleistung der Belegschaft auswirkt. Die Ziele des Unternehmens werden hier ebenso wenig berücksichtigt wie die Motivation der Arbeitnehmer. Für die Unternehmensführung ist dieses Verhaltensmuster ausschließlich negativ besetzt."

        case "1,9 Entgegenkommend":
            return "Country Club Management: Hier richtet die Führungskraft ihre Aufmerksamkeit vor allem auf die Mitarbeiter. Das Betriebsklima steht im Vordergrund, während das Erreichen der Unternehmensziele eine geringere Rolle spielt. Dieser Führungsstil funktioniert nur dann gut, wenn die Mitarbeiter ihre Verantwortung kennen und entsprechend handeln."

        case "9,1 Diktatorisch":
            return "Authority Compliance Management: Bei diesem Führungsstil steht die Erreichung der Unternehmensziele im Mittelpunkt. Die Bedürfnisse der Mitarbeiter werden nur wenig berücksichtigt. Im Extremfall wird das Verhalten der Mitarbeiter sogar als störend empfunden."

        case "9,9 Team-Stil":
            return "Team Management: Führungskräfte und Mitarbeiter arbeiten eng zusammen. Die Teambildung führt zu einer klassischen Win-win-Situation. Durch eine hohe Motivation der Mitarbeiter können sowohl ein gutes Betriebsklima als auch bessere Ergebnisse für das Unternehmen erreicht werden."

        default:
            return "Middle of the Road Management: Dieser Führungsstil kennzeichnet sich durch ein ausgewogenes Verhältnis von Aufgabenorientierung und Mitarbeiterorientierung. Oft handelt es sich um einen Kompromiss, bei dem entweder die Aufgaben oder die Mitarbeiter etwas in den Hintergrund treten."
        }
    }

    func kartenBlock<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 3)
    }
}
