import SwiftUI

struct MainPageView: View {
    @StateObject var viewModel = MainPageViewViewModel()
    
    static let categories: [Category] = [
        Category(id: 55, name: "Food", items: [
            Item(id: 5501, name: "Potato Chips", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553691.png", price: 40.00),
            Item(id: 5502, name: "Penne Pasta", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553691.png", price: 110.40),
            Item(id: 5503, name: "Tomato Ketchup", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553691.png", price: 80.00),
            Item(id: 5504, name: "Nutella Spread", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553691.png", price: 120.00),
            Item(id: 5505, name: "Everyday Granola", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553691.png", price: 450.00),
        ]),
        Category(id: 56, name: "Beverages", items: [
            Item(id: 5601, name: "Orange Fanta 1 Litre", icon: "https://cdn-icons-png.flaticon.com/128/2405/2405479.png", price: 100.00),
            Item(id: 5602, name: "Keventers Thick Shake 60 ml", icon: "https://cdn-icons-png.flaticon.com/128/2405/2405479.png", price: 79.99),
            Item(id: 5603, name: "Fresh Jaljeera", icon: "https://cdn-icons-png.flaticon.com/128/2405/2405479.png", price: 50.00),
        ]),
        Category(id: 57, name: "Hygiene Essentials", items: [
            Item(id: 5701, name: "Clear Baby Shampoo", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553642.png", price: 300.00),
            Item(id: 5702, name: "Walnut Scrub Daily Glow", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553642.png", price: 165.00),
            Item(id: 5703, name: "Shine Detergent Powder 1 kg", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553642.png", price: 300.00),
            Item(id: 5704, name: "All-in-one Cleaner", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553642.png", price: 90.00),
            Item(id: 5705, name: "Soft Tissue Box", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553642.png", price: 40.00),
            Item(id: 5706, name: "Aroma Essence Balls 10 Pieces", icon: "https://cdn-icons-png.flaticon.com/128/2553/2553642.png", price: 200.00),
        ]),
    ]
    @State private var selectedCategory: Int?
        @State private var isCreatorDetailsSheetPresented = false
        @State private var isCategorySheetPresented = false

        var body: some View {
            NavigationView {
                ScrollViewReader { scrollView in
                    ZStack {
                        VStack {
                            Spacer()
                            viewModel.listSection(scrollView: scrollView, categories: MainPageView.categories, selectedCategory: $selectedCategory)
                        }

                        HStack {
                            viewModel.leadingButtons(isCreatorDetailsSheetPresented: $isCreatorDetailsSheetPresented)
                            Spacer()
                            FloatingCategoriesButton(categories: MainPageView.categories, selectedCategory: $selectedCategory)
                                .padding()
                        }
                    }
                    .navigationTitle("My Store")
                    .navigationBarItems(
                        leading: viewModel.leadingButtons(isCreatorDetailsSheetPresented: $isCreatorDetailsSheetPresented),
                        trailing: viewModel.trailingButtons(categories: MainPageView.categories)
                            .sheet(isPresented: $isCreatorDetailsSheetPresented) {
                                CreatorDetailsView()
                            }
                    )
                }
            }
        }
    }

    #Preview{
        MainPageView()
    }
