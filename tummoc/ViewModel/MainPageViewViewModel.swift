import SwiftUI

final class MainPageViewViewModel: ObservableObject {
    @Published private var favorites: Set<Int> = []
    @Published private var cart: [Int: Int] = [:]
    @Published private var selectedCategory: Int?
    @Published private var isCategorySheetPresented: Bool = false
    @Published var isCreatorDetailsSheetPresented: Bool = false  // Add this line
    
    
    func toggleFavorite(_ itemId: Int) {
        if favorites.contains(itemId) {
            favorites.remove(itemId)
        } else {
            favorites.insert(itemId)
        }
    }

    func incrementCart(_ itemId: Int) {
        if let currentQuantity = cart[itemId] {
            cart[itemId] = currentQuantity + 1
        } else {
            cart[itemId] = 1
        }
    }

    func calculateOffset(for index: Int) -> Int? {
        return index
    }

    func removeAllItemsFromCart() {
        cart.removeAll()
    }

    func removeItemFromCart(_ itemId: Int) {
        cart[itemId] = nil
    }
    func leadingButtons(isCreatorDetailsSheetPresented: Binding<Bool>) -> some View {
            HStack {
                Button(action: {
                    // Hamburger button action
                    isCreatorDetailsSheetPresented.wrappedValue.toggle()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            }
        }

    func listSection(scrollView: ScrollViewProxy, categories: [Category], selectedCategory: Binding<Int?>) -> some View {
        List {
            ForEach(categories) { category in
                Section(header: Text(category.name).id(category.id)) {
                    ForEach(category.items) { item in
                        NavigationLink(destination: ItemDetailView(item: item,
                                                                     addToFavorites: { self.toggleFavorite(item.id) },
                                                                     addToCart: { _ in self.incrementCart(item.id) },
                                                                     isFavorite: self.favorites.contains(item.id))) {
                            ItemRowView(item: item, isFavorite: self.favorites.contains(item.id))
                        }
                    }
                }
            }
        }
        .onChange(of: selectedCategory.wrappedValue) {
            let newCategoryID = selectedCategory.wrappedValue

            withAnimation {
                guard let index = categories.firstIndex(where: { $0.id == newCategoryID }) else {
                    return
                }

                if let offset = self.calculateOffset(for: index) {
                    scrollView.scrollTo(offset)
                }
            }
        }
    }

    func floatingButton(categories: [Category], selectedCategory: Binding<Int?>) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                FloatingCategoriesButton(categories: categories, selectedCategory: selectedCategory)
                    .padding()
            }
        }
    }


    func trailingButtons(categories: [Category]) -> some View {
        HStack {
            NavigationLink(destination: FavoritesView(favorites: self.favorites, items: categories.flatMap { $0.items }, toggleFavorite: self.toggleFavorite)) {
                Image(systemName: "heart.fill")
                    .imageScale(.large)
            }
            NavigationLink(destination: CartView(cart: self.cart, toggleCart: self.incrementCart, removeAllItems: self.removeAllItemsFromCart, removeItem: self.removeItemFromCart, items: categories.flatMap { $0.items })) {
                Image(systemName: "cart.fill")
                    .imageScale(.large)
            }
        }
    }

    func calculateTotalCartValue(cart: [Int: Int], items: [Item]) -> String {
        var totalValue = 0.0
        for (itemId, quantity) in cart {
            if let item = items.first(where: { $0.id == itemId }) {
                totalValue += item.price * Double(quantity)
            }
        }

        return String(format: "₹%.2f", totalValue)
    }
}
