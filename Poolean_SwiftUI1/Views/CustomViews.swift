//
//  CustomViews.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 28.03.2022.
//

import Foundation
import SwiftUI

struct DetailView2: View {
    @Environment(\.presentationMode) var presentationMode

    

    var body: some View {
        VStack{
            Text("Burada leaderboard ListView olması gerek😭")
                .foregroundColor(.white)
                .padding()
           //Spacer()
           Button(action: {
             presentationMode.wrappedValue.dismiss()
           }, label: {
             Label("Close", systemImage: "xmark.circle")
           })
               .foregroundColor(.white)
           
           /*Image(systemName: "xmark.circle")
               .foregroundColor(.white)
               .padding()*/
               
       }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
       .background(.green)
       //.padding()
   }
}




struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}

struct Button2:View{
    
    @State var btnLabel:String
    
    var btnAction:() -> Void //escapinfg closure
    
    init(label:String,action:@escaping(()->Void)){
        btnLabel = label
        btnAction = action
    }
    
    var body: some View{
        return Button(action:{
            btnAction()
        },
                      label:{
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                Text(btnLabel)
                    .foregroundColor(.white)
            }
            .frame(height:70)
            //.background(.pink)
        })
    }
}

struct CustomBackgroundImage : View {
    @State var image:String = ""
    var body: some View{
        return Image(image)
            .resizable()
            .ignoresSafeArea()
            .blur(radius: 2)
    }
}


/*
 struct RoundedTextField1Generic<T> : View { // for numbers
     
     @State var text_in : String
     @State var binding_string:Binding<T>
     
     init(text_in:String,binding_string:Binding<T>){
         self.text_in = text_in                 // -> -> Generic struct initialization is soo fucked up. Search and laern the issue!!!
         self.binding_string = binding_string   //->variable "" used befıer being initialized!
     }
     
     var body: some View {

         TextField(text_in, value:binding_string,formatter: NumberFormatter())
             .foregroundColor(.black)
             .padding()
             .background(.gray)
             .cornerRadius(25.0)
             .padding(.horizontal)
         
     }
     
    
 }
 */

struct RoundedTextField1Generic<T> : View { // for numbers
    
    @State var text_in : String
    @State var binding_string:Binding<T>
    @State var background_color:Color
    
    var body: some View {

        TextField(text_in, value:binding_string,formatter: NumberFormatter())
            .foregroundColor(.black)
            .padding()
            .background(background_color)
            .cornerRadius(25.0)
            .padding(.horizontal)
        
    }
    
   
}


struct SettingsSegmentsView : View {
    
    
    var body:some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                //.frame(width: 300, height: 300)
                //.frame(minHeight:300)
                .foregroundColor(Color(0xf2f1f6))
            VStack{
                
            }
        }
    }
}


struct RoundedTextField1 : View {
    
    @State var text_in : String
    @State var binding_string:Binding<String>
    @State var foreground_color:Color
    @State var background_color:Color
    
    init(text_in:String,binding_string:Binding<String>){
        self.text_in = text_in
        self.binding_string = binding_string
        self.foreground_color = .black
        self.background_color = .gray
    }
    

    init(text_in:String,binding_string:Binding<String>,foreground_color:Color){ //@Binding String doesn't work. Look into it!!!
        self.text_in = text_in
        self.binding_string = binding_string
        self.foreground_color = foreground_color
        self.background_color = .gray
    }
    
    init(text_in:String,binding_string:Binding<String>,background_color:Color){ //@Binding String doesn't work. Look into it!!!
        self.text_in = text_in
        self.binding_string = binding_string
        self.foreground_color = .black
        self.background_color = background_color
    }
    
    init(text_in:String,binding_string:Binding<String>,foreground_color:Color,background_color:Color){ //@Binding String doesn't work. Look into it!!!
        self.text_in = text_in
        self.binding_string = binding_string
        self.foreground_color = foreground_color
        self.background_color = background_color
    }
    
    
    var body: some View {
        TextField(text_in, text:binding_string)
            .foregroundColor(foreground_color)
            .padding()
            .background(background_color)
            .cornerRadius(25.0)
            .padding(.horizontal)
    }
    
}


struct RoundedTextField1WithButton : View {
    
    @State var text_in : String = ""
    var btnAction:()->Void
    //@Binding var binding_string:String
    @State var binding_string:Binding<String>
    @State var background_color:Color
    @State var buttonSFName:String = "x.circle.fill"
    //Binding<String> = $String
    
    init(text:String,binding_value:Binding<String>, action:@escaping(()->Void)){
        text_in = text
        self.binding_string = binding_value
        btnAction = action
        self.background_color = .black
    }
    
    init(text:String,binding_value:Binding<String>,background_color:Color, action:@escaping(()->Void)){
        text_in = text
        self.binding_string = binding_value
        btnAction = action
        self.background_color = background_color
    }
    
    var body: some View{
        ZStack{
            TextField(text_in, text:binding_string)
                .foregroundColor(.black)
                .padding()
                .background(background_color)
                .cornerRadius(25.0)
                //.padding(.horizontal)
            HStack{
                Spacer()
                Button(action: {
                    btnAction()
                }, label: {
                    Label("",systemImage: buttonSFName)
                        .font(.largeTitle)
                    //Image(systemName: "arrowShape.turn.up.right.fill")
                        .foregroundColor(.black)
                })
            }
        }
        
    }
}




struct SecureFieldWithNavigationButton<Content:View> : View {
    
    var text_in : String = "" // text showed on SecureField
    var btnAction:()->Void //
    @State var isActiveBool = false
    //@Binding var binding_string:String
    var binding_string:Binding<String> // value that holds string typed in securefield
    var viewIn : Content // destination View that navigationLink navigates to.
    //Binding<String> = $String
    init(text_in:String,binding_string:Binding<String>, action:@escaping(()->Void) , view : Content){
        self.text_in = text_in
        self.binding_string = binding_string
        btnAction = action
        viewIn = view
    }
    
    var body: some View{
        ZStack{
            SecureField(text_in, text:binding_string) // outside a custom component, text should formatted as $SomeVar (binding)
                .foregroundColor(.black)
                .padding()
                .background(.gray)
                .cornerRadius(25.0)
                //.padding(.horizontal)
            HStack{
                Spacer()
                
                
                
                NavigationLink(destination:viewIn,label:{
                                Button(action: {
                                    btnAction()
                                    isActiveBool = true
                                }, label: {
                                    Label("",systemImage: "arrow.right.circle.fill")
                                        .font(.largeTitle)
                                    //Image(systemName: "arrowShape.turn.up.right.fill")
                                        .foregroundColor(.black)
                                })
                })
            }
        }
        
    }
}


struct SecureFieldWithNavigationLink<Content:View> : View {
    
    var text_in : String = "" // text showed on SecureField
    var btnAction:()->Void //
    @State var isActiveBool = false
    //@Binding var binding_string:String
    var binding_string:Binding<String> // value that holds string typed in securefield
    var viewIn : Content // destination View that navigationLink navigates to.
    //Binding<String> = $String
    init(text_in:String,binding_string:Binding<String>, action:@escaping(()->Void) , view : Content){
        self.text_in = text_in
        self.binding_string = binding_string
        btnAction = action
        viewIn = view
    }
    
    var body: some View{
        ZStack{
            SecureField(text_in, text:binding_string) // outside a custom component, text should formatted as $SomeVar (binding)
                .foregroundColor(.black)
                .padding()
                .background(.gray)
                .cornerRadius(25.0)
                //.padding(.horizontal)
            HStack{
                Spacer()
                
                
                
                
                NavigationLink(destination:viewIn, label: {
                        Label("",systemImage: "arrow.right.circle.fill")
                            .font(.largeTitle)
                        //Image(systemName: "arrowShape.turn.up.right.fill")
                            .foregroundColor(.red)
                                
                })
            }
        }
        
    }
}



struct SecureFieldWithButton : View {
    
    @State var text_in : String = ""
    var btnAction:()->Void
    //@Binding var binding_string:String
    @State var binding_string:Binding<String>
    //Binding<String> = $String
    init(text:String,binding_value:Binding<String>, action:(()->Void)? ){
        text_in = text
        self.binding_string = binding_value
        btnAction = action!
    }
    
    var body: some View{
        ZStack{
            SecureField(text_in, text:binding_string)
                .foregroundColor(.black)
                .padding()
                .background(.gray)
                .cornerRadius(25.0)
                //.padding(.horizontal)
            HStack{
                Spacer()
                Button(action: {
                    btnAction()
                }, label: {
                    Label("",systemImage: "arrow.right.circle.fill")
                        .font(.largeTitle)
                    //Image(systemName: "arrowShape.turn.up.right.fill")
                        .foregroundColor(.black)
                })
            }
        }
        
    }
}

