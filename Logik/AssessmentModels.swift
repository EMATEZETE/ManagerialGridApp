import Foundation

enum Dimension {
    case aufgabenorientierung
    case mitarbeiterorientierung
}

enum AntwortOption: Int, CaseIterable {
    case nie = 0
    case selten = 1
    case manchmal = 2
    case oft = 3
    case sehrOft = 4
    case immer = 5
    
    var punkte: Int {
        return self.rawValue
    }
}

struct Frage {
    let text: String
    let dimension: Dimension
}

let alleFragen: [Frage] = [
    
    // Aufgabenorientierung (1–9)
    Frage(text: "Ich analysiere gerne Probleme.", dimension: .aufgabenorientierung),
    Frage(text: "Ich manage meine Zeit sehr effizient.", dimension: .aufgabenorientierung),
    Frage(text: "Große Projekte in kleine, überschaubare Aufgaben zu unterteilen, ist für mich selbstverständlich.", dimension: .aufgabenorientierung),
    Frage(text: "Wenn ich eine komplexe Aufgabe zu Ende führe, achte ich darauf, dass jedes Detail berücksichtigt wird.", dimension: .aufgabenorientierung),
    Frage(text: "Ich überwache den Zeitplan genau, um sicherzustellen, dass eine Aufgabe oder ein Projekt rechtzeitig abgeschlossen wird.", dimension: .aufgabenorientierung),
    Frage(text: "Je anspruchsvoller eine Aufgabe ist, desto mehr Spaß macht sie mir.", dimension: .aufgabenorientierung),
    Frage(text: "Nichts ist wichtiger als das Erreichen eines Ziels oder einer Aufgabe.", dimension: .aufgabenorientierung),
    Frage(text: "Es fällt mir leicht, mehrere komplizierte Aufgaben gleichzeitig zu erledigen.", dimension: .aufgabenorientierung),
    Frage(text: "Ich lese gerne Artikel, Bücher und Fachzeitschriften über meinen Beruf und setze dann die neu erlernten Methoden um.", dimension: .aufgabenorientierung),

    // Mitarbeiterorientierung (10–18)
    Frage(text: "Es macht mir Spaß, meinen Mitarbeitern die Feinheiten und Details einer komplexen Aufgabe oder eines Projekts zu erklären.", dimension: .mitarbeiterorientierung),
    Frage(text: "Ich ermutige mein Team, sich an Entscheidungsfindungen zu beteiligen, und versuche, ihre Ideen und Vorschläge umzusetzen.", dimension: .mitarbeiterorientierung),
    Frage(text: "Ich lese gerne Artikel, Bücher und Zeitschriften über Training, Führung und Psychologie und setze das Gelesene dann in die Tat um.", dimension: .mitarbeiterorientierung),
    Frage(text: "Nichts ist so wichtig wie der Aufbau eines großartigen Teams.", dimension: .mitarbeiterorientierung),
    Frage(text: "Wenn ich Fehler kritisiere, mache ich mir keine Sorgen darüber, dass ich Beziehungen gefährden könnte.", dimension: .mitarbeiterorientierung),
    Frage(text: "Es macht mir Spaß, Menschen in neue Aufgaben und Verfahren einzuweisen.", dimension: .mitarbeiterorientierung),
    Frage(text: "Es ist für mich selbstverständlich, meine Mitarbeiter zu beraten, um ihre Leistung oder ihr Verhalten zu verbessern.", dimension: .mitarbeiterorientierung),
    Frage(text: "Ich ermutige meine Mitarbeiter, bei ihrer Arbeit kreativ zu sein.", dimension: .mitarbeiterorientierung),
    Frage(text: "Ich respektiere die Grenzen anderer Menschen.", dimension: .mitarbeiterorientierung)
]

func bestimmeFuehrungsstil(gridAufgaben: Double, gridMitarbeiter: Double) -> String {
    
    let aufgabenHoch = gridAufgaben > 6
    let aufgabenNiedrig = gridAufgaben < 4
    
    let mitarbeiterHoch = gridMitarbeiter > 6
    let mitarbeiterNiedrig = gridMitarbeiter < 4
    
    if aufgabenNiedrig && mitarbeiterNiedrig {
        return "1,1 Gleichgültig"
    }
    
    if aufgabenNiedrig && mitarbeiterHoch {
        return "1,9 Entgegenkommend"
    }
    
    if aufgabenHoch && mitarbeiterNiedrig {
        return "9,1 Diktatorisch"
    }
    
    if aufgabenHoch && mitarbeiterHoch {
        return "9,9 Team-Stil"
    }
    
    return "5,5 Mittelweg"
}
