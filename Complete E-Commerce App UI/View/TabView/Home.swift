//
//  Home.swift
//  Complete E-Commerce App UI
//
//  Created by Boris Zinovyev on 09.02.2022.
//

import SwiftUI

struct Home: View {
    @Namespace var animation
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15) {
                
//MARK: - SearchBar (Поиск)
                ZStack {
                    
                    if homeData.searchActivated {
                        SearchBar()
                    }
                    else {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
//   посмотреть видео 1 когда он настраивает getRect!!!! и сделать через способ ниже
//                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 15)
// не понял зачем это нужно .contentShape(Rectangle())
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated = true
                    }
                }

                
//MARK: - Верхний заголовок
                Text("Order online\ncollect in store")
                    .font(Font.system(.largeTitle, design: .default).weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipped()
                    .padding(.leading)
//        можно убрать можно оставить .padding(.bottom), смотреть итоговый результат
//                    .padding(.bottom)

                
//MARK: - Товарный горизонтальный Скролл
                
        ScrollView(.horizontal, showsIndicators: false) {
                    
            HStack(spacing: 18) {
                ForEach(ProductType.allCases, id: \.self) {type in
                    
//MARK: - Product Type View
                    ProductTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 20)
            }

//MARK: - ProductPage
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 25) {
                    
                    ForEach(homeData.filteredProducts) { product in
                        
                        ProductCardView(product: product)
                        
                        }
                    }
                Divider()
                
                .padding(.horizontal, 20)
                }
            .padding(.top,20)
            }
//        можно убрать можно оставить .padding
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//   обновление списка продуктов после смены категории
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
    }
        
//MARK: - SearchView дополнение 
        .overlay(
            ZStack {
                if homeData.searchActivated {
//                    SearchView(animation: animation)
                    SearchView()
                        .environmentObject(homeData)
            }
        }
    )
}
    
//MARK: - ProductCardView
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

//MARK: - SearchBar

    @ViewBuilder
    func SearchBar() -> some View {
        
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
    
// серый текст перед поиском
            TextField("Search", text: .constant(""))
                        .disabled(true)
        }
                .padding(.vertical, 10)
                .padding(.horizontal)
// Закругленный TextField поиска, обрати внимание что без background не работает
                .background(
//       можно в приложение РЕНТЕЛ сделать
//                RoundedRectangle(cornerRadius: 25, style: .continuous)
//                        .fill(Color.red)
//                        .frame(width: 200, height: 200)
                Capsule()
                    .strokeBorder(Color.gray, lineWidth: 0.8))
}


    
//MARK: - ProductTypeView дополнение
    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
    
        Button {
//MARK: Смена выбранной категории
            withAnimation {
                homeData.productType = type
            }
        } label: {
//MARK:      категория
            Text(type.rawValue)
                .font(Font.system(.title3, design: .default)
                .weight(.semibold))
//        смена цвета выбранной категории
                .foregroundColor(homeData.productType == type ? Color.blue : Color.gray)
//       перепроверить нужен ли он вообще
                .padding(.bottom, 10)
//MARK:     индикатор полоска снизу
                .overlay(
//     переключение с плавной анимацией (matche Geometry Effect)
                    ZStack {
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color.blue)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                    }
                        else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                }
                ,alignment: .bottom
            )
        }
    }
}

