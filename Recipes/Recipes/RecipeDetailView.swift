//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Fábio Salata on 19/10/20.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var manager: RecipeManager
    @State var isIngredient = true
    
    var viewSpace: Namespace.ID
    
    var body: some View {
        VStack {
            ZStack {
                Color.lightBackground
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading) {
                        RecipeInteractionView(recipe: manager.selectedRecipe ?? manager.data[0],
                                              index: manager.currentRecipeIndex,
                                              count: manager.data.count,
                                              showArrow: false,
                                              manager: manager,
                                              viewSpace: viewSpace)
                            .rotationEffect(.degrees(90))
                            .offset(y: -80)
                        
                        Group {
                            Text(manager.selectedRecipe?.title ?? "")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                            
                            HStack(spacing: 32) {
                                HStack(spacing: 12) {
                                    Image(systemName: Data.summaryImageName["time"] ?? "?")
                                        .foregroundColor(.green)
                                    
                                    Text(manager.selectedRecipe?.summary["time"] ?? "?")
                                }
                                
                                HStack(spacing: 12) {
                                    Image(systemName: Data.summaryImageName["ingredientCount"] ?? "?")
                                        .foregroundColor(.green)
                                    
                                    Text(manager.selectedRecipe?.summary["ingredientCount"] ?? "?")
                                }
                            }
                            .foregroundColor(.black)
                            .padding(.vertical)
                        }
                        .padding(.horizontal)
                        
                        Toggle(isOn: $isIngredient, label: {})
                            .toggleStyle(IngredientMethodToggleStyle())
                        
                        if isIngredient {
                            IngredientListView(manager: manager)
                        } else {
                            MethodListView(methods: manager.selectedRecipe?.instructions ?? ["?"])
                        }
                    }
                }
                BackButtonview(manager: manager)
            }
        }
    }
}

struct  BackButtonview: View {
    @ObservedObject var manager: RecipeManager
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation{
                    manager.selectedRecipe = nil
                }
            }, label: {
                HStack {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .padding()
                    
                    Spacer()
                }
            })
            
            Spacer()
        }
    }
}

struct IngredientListView: View {
    @ObservedObject var manager: RecipeManager
    
    var body: some View {
        ForEach(0..<manager.getCurrentRecipe().instructions.count) { i in
            Toggle(isOn: Binding<Bool>(
                get: { manager.data[manager.currentRecipeIndex].ingredients[i].available },
                set: { manager.data[manager.currentRecipeIndex].ingredients[i].available = $0 }
            ),
            label: {
                Text(manager.getCurrentRecipe().ingredients[i].title)
                    .foregroundColor(.black)
            })
            .toggleStyle(CircularToggleStyle())
            .padding(.vertical, 8)
        }
    }
}

struct CircularToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return
            HStack(alignment: .top) {
                ZStack {
                    Circle()
                        .stroke(configuration.isOn ? Color.green : Color.gray.opacity(0.5), lineWidth: 2)
                        .frame(width: 20, height: 20)
                    
                    if configuration.isOn {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.horizontal)
                
                configuration.label
            }.onTapGesture {
                withAnimation {
                    configuration.isOn.toggle()
                }
            }
    }
}

struct MethodListView: View {
    let methods: [String]
    
    var body: some View {
        ForEach(methods, id: \.self) { value in
            Text(value)
                .padding(.horizontal)
                .padding(.vertical, 4)
        }
    }
}

struct IngredientMethodToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("INGREDIENTS")
                    .font(.system(size: 16, weight: configuration.isOn ? .bold : .regular))
                    .frame(width: 110)
                    .fixedSize()
                    .animation(nil)
                    .padding(4)
                    .padding(.leading, 12)
                    .onTapGesture {
                        withAnimation {
                            configuration.isOn = true
                        }
                    }
                
                Text("METHOD")
                    .font(.system(size: 16, weight: configuration.isOn ? .regular : .bold))
                    .animation(nil)
                    .padding(4)
                    .onTapGesture {
                        withAnimation {
                            configuration.isOn = false
                        }
                    }
            }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 3)
                
                Rectangle()
                    .fill(Color.green)
                    .frame(width: configuration.isOn ? 110 : 70, height: 3)
                    .offset(x: configuration.isOn ? 16 : 140)
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
