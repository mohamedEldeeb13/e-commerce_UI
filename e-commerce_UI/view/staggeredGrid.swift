//
//  staggeredGrid.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 20/01/2024.
//

import SwiftUI

struct staggeredGrid<Content : View , T : Identifiable>: View where T : Hashable  {
    
    var content : (T)->Content
    var list : [T]
    var showIndecator : Bool
    var spacing : CGFloat
    var colums : Int
    init(colums : Int,showIndecator : Bool = false,spacing: CGFloat = 10,list: [T], @ViewBuilder content: @escaping (T)->Content) {
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showIndecator = showIndecator
        self.colums = colums
    }
    
    func setUpList() -> [[T]] {
        // creat empty subArray of colums
        var gridArray : [[T]] = Array(repeating: [], count: colums)
        // spiliting array for vstack oriented view
        var currentIndex = 0
        for object in list {
            gridArray[currentIndex].append(object)
            
            if currentIndex == (colums - 1) {
                currentIndex = 0
            }else {
                currentIndex += 1
            }
        }
        return gridArray
    }
    
    var body: some View {
        
//        ScrollView(.vertical, showsIndicators: showIndecator, content: {
            
            HStack(alignment: .top , spacing: 20)
            {
                ForEach(setUpList(), id: \.self){ columsData in
                    
                    LazyVStack(spacing: spacing)
                    {
                        ForEach(columsData){ object in
                            content(object)
                        }
                    }
                    .padding(.top, getIndex(values: columsData) == 1 ? 80 : 0)
                }
            }//: Hstack
            .padding(.vertical)
            
//        })//: ScrollView
        
    }
    
    func getIndex(values : [T]) -> Int {
        let index = setUpList().firstIndex { t in
            return t == values
        } ?? 0
        return index
    }
}

//#Preview {
//    staggeredGrid()
//}
