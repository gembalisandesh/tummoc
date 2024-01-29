import SwiftUI
struct FavoritesView: View {
    let favorites: Set<Int>
    let items: [Item]
    let toggleFavorite: (Int) -> Void

    var body: some View {
        List {
            ForEach(favorites.sorted(), id: \.self) { itemId in
                if let item = items.first(where: { $0.id == itemId }) {
                    NavigationLink(destination: ItemDetailView(item: item,
                                                               addToFavorites: { toggleFavorite(item.id) },
                                                               addToCart: { _ in},
                                                               isFavorite: true)) {
                        ItemRowView(item: item, isFavorite: true)
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}
struct FavoritesView_Previews: PreviewProvider {
    static let sampleFavorites: Set<Int> = [5501, 5602, 5703]
    static let sampleItems: [Item] = [
        Item(id: 5501, name: "Potato Chips", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553691.png", price: 40.00),
        Item(id: 5602, name: "Keventers Thick Shake 60 ml", icon: "https://cdn-icons-png.flaticon.com/128/2405/2405479.png", price: 79.99),
        Item(id: 5703, name: "Shine Detergent Powder 1 kg", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553642.png", price: 300.00),
    ]

    static var previews: some View {
        FavoritesView(favorites: sampleFavorites, items: sampleItems, toggleFavorite: { _ in })
    }
}
