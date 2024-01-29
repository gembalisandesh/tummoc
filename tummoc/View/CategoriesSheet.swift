
import SwiftUI

struct CategoriesSheet: View {
    let categories: [Category]
    @Binding var selectedCategory: Int?
    @Binding var isSheetPresented: Bool

    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { category in
                    Button(action: {
                        selectedCategory = category.id
                        isSheetPresented.toggle()
                    }) {
                        Text(category.name)
                    }
                }
            }
            .navigationTitle("Categories")
            .navigationBarItems(trailing: Button("Close") {
                isSheetPresented.toggle()
            })
        }
    }
}
#Preview {
    CategoriesSheet(
        categories: [
            Category(id: 1, name: "Category 1", items: []),
            Category(id: 2, name: "Category 2", items: []),
            // Add more categories as needed
        ],
        selectedCategory: .constant(nil),
                isSheetPresented: .constant(false)
    )
}
