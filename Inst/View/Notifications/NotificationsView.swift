import SwiftUI

struct NotificationsView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(0..<21) { _ in
                        NotificationCell()
                }
            }
        }.padding(.top)
    }
}

#Preview {
    NotificationsView()
}
