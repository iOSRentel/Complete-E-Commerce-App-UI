//
//  StaggeredGrid.swift
//  Complete E-Commerce App UI
//
//  Created by Boris Zinovyev on 12.02.2022.
//

import SwiftUI
// Custom ViewBuilder
// T -> is to hold the idetifiable collection of data

struct StraggeredGrid<Content: View,T: Identifiable>: View where T: Hashable {
    
    var content: (T) -> Content
    
    var list: [T]
    
    var columns: Int
    
    var showsIndicators: Bool
    var spacing: CGFloat
    
    init(columns: Int, showsIndicators: Bool = false, spacing: CGFloat = 10, list: [T],
         @ViewBuilder content: @escaping (T) -> Content) {
        
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.columns = columns
    }
    
func setUpList() -> [[T]] {
    
    var gridArray: [[T]] = Array(repeating: [], count: columns)
    
    var currentIndex: Int = 0
    
    for object in list {
        gridArray[currentIndex].append(object)
        
// increasing index count
// and resetting if overbounds the columns count
        if currentIndex == (columns - 1) {
            currentIndex = 0
            }
            else {
            currentIndex += 1
        }
    }
        return gridArray
}

var body: some View {
        
    ScrollView(.vertical, showsIndicators: showsIndicators) {
            
        HStack(alignment: .top, spacing: 20) {
            ForEach(setUpList(),id: \.self) {columnsData in
                LazyVStack(spacing: spacing) {
                    ForEach(columnsData) { object in
                        content(object)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
