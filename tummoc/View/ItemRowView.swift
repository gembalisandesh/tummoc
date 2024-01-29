
import SwiftUI
struct ItemRowView: View {
    let item: Item
    let isFavorite: Bool   

    var body: some View {
        HStack {
            URLImage(url: item.icon)
                .frame(width: 40, height: 40)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("₹\(item.price, specifier: "%.2f")")
                    .foregroundColor(.secondary)
            }

            Spacer()

            if isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
#Preview {
    ItemRowView(item: Item(id: 1, name: "Sample Item", icon: "https://example.com/icon.png", price: 19.99), isFavorite: true)
}
