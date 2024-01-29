
import SwiftUI

struct FloatingCategoriesButton: View {
    let categories: [Category]
    @Binding var selectedCategory: Int?
    @State private var isCategorySheetPresented: Bool = false

    var body: some View {
        Button(action: {
            isCategorySheetPresented.toggle()
        }) {
            Image(systemName: "square.grid.2x2.fill")
                .foregroundColor(.white)
                .padding(12)
                .background(Color.blue)
                .clipShape(Circle())
        }
        .sheet(isPresented: $isCategorySheetPresented) {
            CategoriesSheet(categories: categories, selectedCategory: $selectedCategory, isSheetPresented: $isCategorySheetPresented)
        }
    }
}
#Preview {
    FloatingCategoriesButton(
        categories: [
            Category(id: 1, name: "Category 1", items: []),
            Category(id: 2, name: "Category 2", items: []),

        ],
        selectedCategory: .constant(nil)
    )
}
