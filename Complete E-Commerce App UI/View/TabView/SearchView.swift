//
//  SearchView.swift
//  Complete E-Commerce App UI
//
//  Created by Boris Zinovyev on 11.02.2022.
//

import SwiftUI

struct SearchView: View {
    
//    var animation: Namespace.ID
    
    @EnvironmentObject var homeData: HomeViewModel
    
// Activation Text Field with the help of Focus (нужно тестировать, может быть можно отказаться) 5 01
    @FocusState var startTF: Bool
    
    var body: some View {

        VStack(spacing: 0) {
            
            HStack(spacing: 20) {
//MARK: - Close Button
                
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                        }
                    
                    } label: {
                    
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundColor(Color.black.opacity(0.7))
                }

//MARK: - SearchBar
            HStack(spacing: 15) {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.gray)
            
// серый текст перед поиском
                TextField("Search", text: $homeData.searchText)
                    .focused($startTF)
                    .textCase(.lowercase)
                    .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
// Закругленный TextField поиска, обрати внимание что без background не работает
                .background(
//       можно в приложение РЕНТЕЛ сделать
//                RoundedRectangle(cornerRadius: 25, style: .continuous)
//                        .fill(Color.red)
//                        .frame(width: 200, height: 200)
                    Capsule()
                        .strokeBorder(Color.gray, lineWidth: 0.8)
                )
//                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal])
            .padding(.top)
            
            
//MARK: - Fileter Results
            ScrollView(.vertical, showsIndicators: false) {
//MARK: - Staggered Grid
                StraggeredGrid(columns: 2, list: homeData.products) { product in
                    
//MARK: - Card View
                    ProductCardView(product: product)
                    
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
//MARK: !!! background всегo searchView ( темная тема не работает в поисковике)
        .background(Color.white)
        
//MARK: - Activation Text Field финалочка
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                startTF = true
            }
        }
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        
        VStack(spacing: 10) {
//  картинка
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 160)
                .padding(.horizontal, 10)
//   Заголовок
            Text(product.title)
                .font(Font.system(.title3, design: .default).weight(.semibold))
//                .frame(maxWidth: .infinity, alignment: .leading)
                .clipped()
                .padding(.leading)
//   Модель
            Text(product.subTitle)
                .font(Font.system(.title2, design: .default).weight(.light))
                .foregroundColor(Color.gray)
                .clipped()
                .padding(.leading)
//  Цена
            Text(product.price)
                .font(Font.system(.title3, design: .default).weight(.semibold))
        }
    }
}
