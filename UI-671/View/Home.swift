//
//  Home.swift
//  UI-671
//
//  Created by nyannyan0328 on 2022/09/18.
//

import SwiftUI

struct Home: View {
    @State var currentIndex : Int = 0
    
      @Namespace var animation
    
    @State var showDetail : Bool = false
    @State var selectedMilkShake : MilkShake?
    @State var currentTab : Tab = tabs[0]
    var body: some View {
        VStack{
            
            HeaderView()
            
            VStack(alignment:.leading,spacing: 10){
                
             
                Text(topAttributedstring)
                 
                
                Text(bottomAttributedstring)
                  
                
            }
            .font(.largeTitle)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            .opacity(showDetail ? 0 : 1)
           
            
            
            GeometryReader{proxy in
                
                let size = proxy.size
             
                CarouselView(size : size)
                    
            }
            .zIndex(-10)
            
            
            
            
            
        }
       
        
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .overlay(content: {
            
            if let selectedMilkShake,showDetail{
                
                DetailView(animation: animation, milkShake:selectedMilkShake , showDetail: $showDetail)
                    
                
                
            }
            
        })
        .background{
         
            Color("LightGreen").ignoresSafeArea()
        }
    }
 
    @ViewBuilder
    func CarouselView(size : CGSize)->some View{
        
        VStack(spacing:-40){
            
            CustomCrousel(index: $currentIndex, items:milkShakes ,spacing:0, cardPadding:size.width / 3, id: \.id) { milkshake, _ in
                
                
                VStack(spacing:20){
                    
                    ZStack{
                        
                        
                        if milkshake.id == milkshake.id && showDetail{
                            
                            
                            Image(milkshake.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                                .opacity(0)
                            
                            
                            
                            
                        }
                        else{
                            
                            Image(milkshake.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                                .matchedGeometryEffect(id: milkshake.id, in: animation)
                            
                        }
                    }
                    .background{
                     
                        RoundedRectangle(cornerRadius: size.height / 20, style: .continuous)
                            .fill(Color("LightGreen-1"))
                            .padding(.horizontal,-40)
                            .padding(.top,40)
                            .offset(y:-10)
                          
                    }
                    
                    Text(milkshake.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.top,8)
                    
                    Text(milkshake.price)
                        .font(.callout.weight(.semibold))
                        .foregroundColor(Color("LightGreen"))
                    
                        
                    
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    
                    withAnimation(.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.7)){
                     
                        selectedMilkShake = milkshake
                        showDetail = true
                    }
                    
                    
                }
                
          
                
                
                
            }
            .frame(height: size.height * 0.8)
            
            Indicators()
            
        }
        .opacity(showDetail ? 0 : 1)
        .frame(width: size.width,height: size.height,alignment: .bottom)
        .background{
            
            CustomShape()
                .fill(.white)
                .scaleEffect(showDetail ? 2 : 1,anchor: .bottomLeading)
                .overlay(alignment: .topLeading) {
                    
                    TabMenu()
                        .opacity(showDetail ? 0 : 1)
                    
                }
                .padding(.top,40)
                .ignoresSafeArea()
            
         
            
        }
        
    }
    
    @ViewBuilder
    func TabMenu ()->some View{
     
        HStack(spacing:25){
            
            
            ForEach(tabs){tab in
                
                Image(tab.tabImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                     .frame(width: 40,height: 50)
                     .padding(10)
                     .background{
                      
                         Circle()
                             .fill(Color("LightGreen-1"))
                     }
                     .shadow(color: .red.opacity(0.07), radius: 5,x:5,y:5)
                     .background{
                      
                         Circle()
                             .fill(.white)
                             .padding(-3)
                     }
                     .offset(tab.tabOffset)
                     .scaleEffect(currentTab.id == tab.id ? 1.2 : 0.8,anchor:.bottom)
                     .onTapGesture {
                         
                         withAnimation(.easeInOut){
                             
                             currentTab = tab
                         }
                     }
                   
            }
        }
        .padding(.leading,13)
            
        
        
        
    }
    @ViewBuilder
    func Indicators ()->some View{
        
        
        HStack(spacing:13){
            
            ForEach(milkShakes.indices ,id:\.self){milk in
                
                
                Circle()
                    .fill(Color("LightGreen"))
                     .frame(width: currentIndex == milk ? 10 : 6,height: currentIndex == milk ? 10 : 6)
                     .padding(5)
                      .background{
                     
                          
                          if currentIndex == milk{
                              
                              Circle()
                                  .stroke(Color("LightGreen"),lineWidth:2)
                                  .matchedGeometryEffect(id: "INDICATOR", in: animation)
                          }
                     }
                
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentIndex)
        
        
    }
    @ViewBuilder
    func HeaderView ()->some View{
     
        HStack{
            
            Button {
                
            } label: {
            
                HStack{
                    Image("Pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30,height: 30)
                        .clipShape(Circle())
                    
                    
                      Text("Animal Power")
                        .font(.caption.weight(.light))
                        .foregroundColor(.black)
                }
                
                .padding(.vertical,5)
                .padding(.horizontal,5)
            
                .background{
                 
                    Capsule()
                        .fill(.white)
                }
                .opacity(showDetail ? 0 : 1)
                
            }
            .padding(.leading,6)
              .frame(maxWidth: .infinity,alignment: .leading)
           
            .overlay(alignment: .trailing) {
                
                
                Button {
                    
                } label: {
                 
                     Image(systemName: "cart.fill")
                        .font(.title2)
                        .foregroundColor(.purple)
                        .overlay(alignment: .topTrailing) {
                            
                            Circle()
                                .fill(.red)
                                .frame(width: 16,height: 16)
                                .offset(x:5,y:-5)
                        }
                    
                }
            }
            
        }
        .padding(14)
      
        
    }
    
    var topAttributedstring : AttributedString{
        
        var str = AttributedString("Good Food.")
        
        if let range = str.range(of: "Food."){
            
            str[range].foregroundColor = .white
                        
            
            
        }
        return str
    }
    
    var bottomAttributedstring : AttributedString{
        
        var str = AttributedString("Good Mood.")
        
        if let range = str.range(of: "Good"){
            
            str[range].foregroundColor = .white
                        
            
            
        }
        return str
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DetailView : View{
    var animation : Namespace.ID
    var milkShake : MilkShake
    @Binding var showDetail : Bool
    
    @State var selectedOrder : String = "Active Order"
    
    @State var showContent : Bool = false
    
    @State var count : Int = 0
    var body: some View{
        
        VStack{
            
            HStack{
                
                Button {
                    
                    withAnimation(.easeInOut(duration: 0.35)){
                        
                        showContent = false
                    }
                    
                
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        
                        withAnimation(.easeInOut(duration: 0.3)){
                            
                            showDetail = false
                        }
                        
                    }
                    
                    
                    
                } label: {
                 
                     Image(systemName: "arrow.left")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.black)
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .overlay {
                Text("Details")
                    .font(.title2.weight(.semibold))
            }
            
            .opacity(showContent ? 1 : 0)
            
            
            HStack{
                
                ForEach(["Active Order","PastOrder"],id:\.self){order in
                    
                    
                    Text(order)
                        .font(.callout)
                        .fontWeight(selectedOrder == order ? .heavy : .none)
                        .foregroundColor(selectedOrder == order ? .black : .gray)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background{
                         
                            if selectedOrder == order{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color("LightGreen-1"))
                                    .matchedGeometryEffect(id: "ORDER", in: animation)
                            }
                        }
                        .onTapGesture {
                            
                            withAnimation{
                                
                                selectedOrder = order
                            }
                        }
                    
                    
                }
            }
              .frame(maxWidth: .infinity,alignment: .leading)
              .padding(.top,15)
            
            
            Image(milkShake.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(.init(degrees: -2))
                .matchedGeometryEffect(id: milkShake.id, in: animation)
                .opacity(showContent ? 1 : 0)
            
            GeometryReader{proxy in
                
                let size = proxy.size
             
                MilkShakeDetails(size : size)
                    .offset(y:showDetail ? 0 : size.height+100)
            }
            
            
        }
        .padding(13)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .transition(.asymmetric(insertion: .identity, removal: .offset(y:0.5)))
        .onAppear{
            
            withAnimation(.easeInOut(duration: 0.6)){
                
                showContent = true
            }
        }
    }
    @ViewBuilder
    func MilkShakeDetails (size : CGSize)->some View{
        
        VStack{
            VStack(alignment:.leading,spacing: 10){
                
                
                Text("#512D Code")
                    .font(.title)
                
                Text(milkShake.title)
                    .font(.title3.weight(.black))
                    .foregroundColor(.black)
                
                Text(milkShake.price)
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.gray)
                
                Text("20min delivery")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.gray)
                
                
                HStack(spacing: 13) {
                    
                    Text("Quanty:")
                    
                    
                    Button {
                        
                        if count > 0{
                            
                            count -= 1
                        }
                        
                    } label: {
                        
                        Image(systemName: "minus")
                        
                    }
                    
                    Text("\(count)")
                    
                    Button {
                      count += 1
                        
                    } label: {
                        
                        Image(systemName: "plus")
                        
                    }
                    
                    
                }
                
                
                Button {
                    
                } label: {
                    
                 
                    Text("Add to Cart")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.black)
                        .padding(12)
                        .background{
                         
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color("LightGreen-1"))
                        }
                }
                .padding(.bottom,13)
                
                
            }
              .frame(maxWidth: .infinity,alignment: .center)
              .background{
               
                  RoundedRectangle(cornerRadius: 10, style: .continuous)
                      .fill(Color("LightGreen-1"))
              }
              .padding(.horizontal,60)
              
             
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
    }
}
