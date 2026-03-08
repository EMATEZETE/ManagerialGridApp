import SwiftUI

struct AppBackground: View {
    
    var body: some View {
        LinearGradient(
            colors: [
                Color.blue.opacity(0.14),
                Color.white
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
