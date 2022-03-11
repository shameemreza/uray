//
//  DetailView.swift
//  Uray
//
//  Created by Shameem Reza on 11/3/22.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var baseData: BaseViewModel
    //FOR HERO EFFECT
    var animation: Namespace.ID
    
    
    @State var size = "2 Grams"
    @State var itemColor: Color = .red
    
    var body: some View {
        
        //MARK: SAFE CHECK
        if let product = baseData.currentProduct, baseData.showDetail {
            VStack(spacing: 0) {
                //MARK: - APP BAR
                HStack {
                    //MARK: DRAWER MENU
                    Button {
                        withAnimation{
                            baseData.showDetail = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    } // END DRAWER MENU
                    
                    Spacer()
                    
                    //MARK: SEARCH ICON
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.red, in: Circle())
                    } // END SEARCH ICON
                }
                .foregroundColor(.black)
                .overlay(
                    Image("logo")
                        .resizable()
                        .frame(width: 74, height: 34)
                        .padding(.horizontal)
                        .padding(.bottom)
                )
                .padding()
                // END APP BAR
                
                //MARK: - PRODUCT IMAGE
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 220, height: 220)
                    .matchedGeometryEffect(id: product.productImage, in: animation)
                    .rotationEffect(.init(degrees: -20))
                    .background(
                        ZStack {
                            Circle()
                                .fill(product.productColor)
                                .padding()
                            Circle()
                                .fill(Color.white.opacity(0.5))
                                .padding(60)
                            
                        }
                    )
                    .frame(height: getScreenBound().height / 3)
                
                //MARK: - PRODUCT DETAILS
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text(product.productTitle)
                            .font(.title.bold())
                        
                        Spacer(minLength: 10)
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Text("(\(product.productRating))")
                            .foregroundColor(.gray)
                        
                    }
                    Text(product.productDescription)
                        .font(.callout)
                        .lineSpacing(10)
                    
                    //MARK: PRODUCT SIZE
                    HStack(spacing: 0) {
                        Text("Size: ")
                            .font(.caption.bold())
                            .foregroundColor(.gray)
                            .padding(.trailing)
                        
                        ForEach(["1 Grams", "2 Grams", "3 Grams"], id: \.self){size in
                            Button {
                                self.size = size
                                
                            } label: {
                                Text(size)
                                    .font(.callout)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.blue)
                                            .opacity(self.size == size ? 0.3 : 0)
                                    )
                            }
                        }
                    } // END SIZE
                    .padding(.vertical)
                    
                    //MARK: PRODUCT COLOR
                    HStack(spacing: 15) {
                        let colors: [Color] = [.red, .yellow,.purple,.green]
                        Text("Colors: ")
                            .font(.caption.bold())
                            .foregroundColor(.gray)
                            .padding(.trailing)
                        
                        ForEach(colors, id: \.self){color in
                            Button {
                                self.itemColor = color
                                
                            } label: {
                                Circle()
                                    .fill(color.opacity(0.5))
                                    .frame(width: 25, height: 25)
                                    .overlay(
                                    Circle()
                                        .stroke(Color("Btnbg"), lineWidth: 1.5)
                                        .opacity(itemColor == color ? 0.2 : 0)
                                        .padding(-4)
                                    )
                            }
                        }
                    } // END Color
                    .padding(.vertical)
                    
                    //MARK: - ADD TO CART
                    Button {
                        
                    } label: {
                        HStack(spacing: 15) {
                            Image("cart")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            
                            Text("Add to cart")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(Color("Btnbg"))
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Btnbg").opacity(0.06))
                        .clipShape(Capsule())
                    }
                    .padding(.top)
                    
                }
                .padding(.top)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(
                    Color("Btnbg")
                        .opacity(0.05)
                        .cornerRadius(20)
                        .ignoresSafeArea(.container, edges: .bottom)
                )
            }
            .padding(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.white)
            .transition(.opacity)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - VIEW EXTENSION

extension View {
    func getScreenBound()-> CGRect {
        return UIScreen.main.bounds
    }
}
