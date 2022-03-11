//
//  Home.swift
//  Uray
//
//  Created by Shameem Reza on 11/3/22.
//

import SwiftUI

struct Home: View {
    //MARK: - GEOMETRY EFFECT
    @Namespace var animation
    @EnvironmentObject var baseData: BaseViewModel
    @State var currentSlider: Int = 0
    @State var sliders: [Slider] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                //MARK - APP BAR
                HStack {
                    //MARK: DRAWER MENU
                    Button {
                        
                    } label: {
                        Image("menu")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    } // END DRAWER MENU
                    
                    Spacer()
                    
                    //MARK: SEARCH ICON
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    } // END SEARCH ICON
                }
                .foregroundColor(.black)
                .overlay(
                    Image("logo")
                        .resizable()
                        .frame(width: 74, height: 34)
                )
                // END APP BAR
                
                //MARK: SLIDER
                VStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 12) {
                        HomeSlider(trailingSpace: 40, index: $currentSlider, items: sliders) {slider in
                            GeometryReader{proxy in
                                let sliderSize = proxy.size
                                
                                Image(slider.sliderImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: sliderSize.width)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.vertical,10)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .onAppear{
                        for index in 1...4 {
                            sliders.append(Slider(sliderImage: "slider\(index)"))
                        }
                    }
                } // END SLIDER
                .padding(.bottom, 20)
                
                //MARK: - SLIDER INDICATOR
                HStack(spacing: 10) {
                    ForEach(sliders.indices, id: \.self){index in
                        Circle()
                            .fill(Color.black.opacity(currentSlider == index ? 1: 0.1))
                            .frame(width: 7, height: 8)
                            .scaleEffect(currentSlider == index ? 1.4 : 1)
                            .animation(.spring(), value: currentSlider == index)
                    }
                }
                .padding(.top, 120)
                
                
                //MARK: - BODY TOP
                HStack {
                    Text("Our Products")
                        .font(.title.bold())
                    Spacer()
                    Button {
                        
                    } label: {
                        HStack(spacing: 3) {
                            Text("Sort by")
                                .font(.caption.bold())
                            Image(systemName: "chevron.down")
                                .font(.caption.bold())
                        }
                        .foregroundColor(.gray)
                    }
                } // END BODY TOP
                .padding(.top, 10)
                
                //MARK: - CATEGORY LIST SLIDER
                ScrollView(.horizontal, showsIndicators: false) {
                    //MARK: - CATEGORY LIST
                    HStack(spacing: 18) {
                        CategoryItem(image: "cat1", title: "Facewash")
                        
                        CategoryItem(image: "cat2", title: "Skin Care")
                        
                        CategoryItem(image: "cat3", title: "Health Care")
                        
                        CategoryItem(image: "cat4", title: "Backpack")
                    } // END CATEGORY LIST
                    .padding(.vertical)
                }
                //MARK: - PRODUCT LIST
                let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                
                // MARK: - GRID VIEW
                LazyVGrid(columns: columns, spacing:  18) {
                    ForEach(products){product in
                        CardView(product: product)
                            .onTapGesture {
                                withAnimation{
                                    baseData.currentProduct = product
                                    baseData.showDetail = true
                                }
                            }
                    }
                }
            }
            .padding()
            //MARK: - Bottom Tab Bar Approx Padding
            .padding(.bottom, 100)
        }
        .overlay(
            DetailView(animation: animation)
                .environmentObject(baseData)
        )
    }
    
    //MARK: PRODUCT VIEW
    @ViewBuilder
    func CardView(product: Product)-> some View {
        VStack(spacing: 15) {
            
            //MARK: LIKED BUTTON
            Button {
                
            } label: {
                Image(systemName: "suit.heart.fill")
                    .font(.system(size: 13))
                    .foregroundColor(product.isLiked ? .white : .gray)
                    .padding(5)
                    .background(
                        Color.red.opacity(product.isLiked ? 1: 0), in: Circle()
                    
                    )
            } // END LIKED BUTTON
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            //MARK: - PRODUCT IMAGE
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: product.productImage, in: animation)
                .padding()
                .rotationEffect(.init(degrees: -20))
                .background(
                    ZStack {
                        Circle()
                            .fill(product.productColor)
                            .padding(-10)
                        //MARK: - INNER CIRCLE
                        Circle()
                            .stroke(Color.white, lineWidth: 1.4)
                            .padding(-3)
                    }
                ) // END PRODUCT IMAGE
            
            //MARK: PRODUCT TITLE
            Text(product.productTitle)
                .fontWeight(.semibold)
                .padding(.top)
            
            //MARK: - PRODUCT PRICE
            Text(product.productPrice)
                .font(.title2.bold())
            
            //MARK: - RATIING
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self){index in
                    Image(systemName: "star.fill")
                        .font(.system(size: 9.5))
                        .foregroundColor(product.productRating >= index ? .yellow : Color.gray.opacity(0.6))
                }
                
                Text("(\(product.productRating).0)")
                    .font(.caption.bold())
                    .foregroundColor(.gray)
            }
            
        }
        .padding()
        .background(Color.white, in: RoundedRectangle(cornerRadius: 12))
    }
    
    //MARK: CATEGORY VIEW
    @ViewBuilder
    func CategoryItem(image: String, title: String)-> some View {
        Button {
            withAnimation{baseData.homeTab = title}
        } label: {
            HStack(spacing: 8) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 27, height: 27)
                Text(title)
                    .font(.system(size: 12.5))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                
                ZStack {
                    //MARK: - TRANSITION SLIDER
                    if baseData.homeTab == title {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                    }
                }
            
            )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
