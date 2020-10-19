//
//  ContentView.swift
//  Recipes
//
//  Created by Fábio Salata on 19/10/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = RecipeManager()
    
    @Namespace private var viewSpace
    
    var body: some View {
        ZStack {
            Color.lightBackground
                .ignoresSafeArea()
            
            RecipeOverview(manager: manager, viewSpace: viewSpace)
                .padding(.horizontal)
            
            if manager.selectedRecipe != nil {
                RecipeDetailView(manager: manager, viewSpace: viewSpace)
            }
        }
    }
}

struct RecipeOverview: View {
    @ObservedObject var manager: RecipeManager
    
    var viewSpace: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Spacer()
            
            TitleView(manager: manager)
            
            ZStack {
                RecipeInteractionView(recipe: manager.data[manager.currentRecipeIndex],
                                      index: manager.currentRecipeIndex,
                                      count: manager.data.count,
                                      showArrow: true,
                                      manager: manager,
                                      viewSpace: viewSpace)
                    .rotationEffect(.degrees(Double(-manager.swipeHeight)))
                    .offset(x: UIScreen.screenWidth / 2)
                
                HStack {
                    SummaryView(recipe: manager.data[manager.currentRecipeIndex])
                    Spacer()
                }
            }
            
            DescriptionView(manager: manager)
            
            Spacer()
        }
    }
}

struct TitleView: View {
    @ObservedObject var manager: RecipeManager
    
    var body: some View {
        Text("Daily Cooking Quest")
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.gray)
        
        Spacer()
        
        Text(manager.data[manager.currentRecipeIndex].title)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.black)
    }
}

struct  SummaryView: View {
    let recipe: RecipeItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(recipe.summary.sorted(by: <), id: \.key) { key, value in
                HStack(spacing: 12) {
                    Image(systemName: Data.summaryImageName[key] ?? "")
                        .foregroundColor(.green)
                    Text(value)
                }
            }
            
            HStack(spacing: 12) {
                Image(systemName: "chart.bar.doc.horizontal")
                    .foregroundColor(.green)
                Text("Healthy")
            }
        }
        .font(.system(size: 17, weight: .semibold))
    }
}

struct  DescriptionView: View {
    @ObservedObject var manager: RecipeManager
    
    var body: some View {
        HStack(spacing: 12) {
            Text(manager.data[manager.currentRecipeIndex].description)
                .font(.system(size: 14, weight: .semibold))
            
            Button(action: {
                withAnimation {
                    manager.selectedRecipe = manager.data[manager.currentRecipeIndex]
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 50, height: 50)
                        .rotationEffect(.degrees(45))
                    
                    Image(systemName: "arrow.right")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
            })
            
            Spacer()
        }
    }
}

struct RecipeInteractionView: View {
    let recipe: RecipeItem
    let index: Int
    let count: Int
    let showArrow: Bool
    @ObservedObject var manager: RecipeManager
    
    var viewSpace: Namespace.ID
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color.lightBackground, Color.green]),
                                   startPoint: .leading,
                                   endPoint: .trailing),
                    lineWidth: 4
                )
                .scaleEffect(1.15)
                .matchedGeometryEffect(id: "borderId", in: viewSpace, isSource: true)
            
            if showArrow {
                ArrowShape(reachedTop: index == 0, reachedBottom: index == count - 1)
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                    .frame(width: UIScreen.screenWidth - 32, height: UIScreen.screenWidth - 32)
                    .scaleEffect(1.15)
                    .matchedGeometryEffect(id: "arrowId", in: viewSpace, isSource: true)
            }
            
            Image(recipe.imageName)
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(id: "imageId", in: viewSpace, isSource: true)
            
            Circle()
                .fill(Color.black.opacity(0.001))
                .scaleEffect(1.2)
                .gesture(
                    DragGesture(minimumDistance: 10)
                        .onChanged({ value in
                            withAnimation {
                                manager.changeSwipeValue(value: value.translation.height)
                            }
                        })
                        .onEnded({ value in
                            withAnimation {
                                manager.swipeEnded(value: value.translation.height)
                            }
                        })
                )
        }
    }
}

struct ArrowShape: Shape {
    let reachedTop: Bool
    let reachedBottom: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let startAngle: CGFloat = 160
        let endAngle: CGFloat = 200
        
        let radius = rect.width / 2
        
        let startAngleRadians = startAngle * CGFloat.pi / 180
        let endAngleRadians = endAngle * CGFloat.pi / 180
        
        let startPoint1 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius, angle: startAngleRadians)
        let endPoint1 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius, angle: endAngleRadians)
        
        path.addArc(center: CGPoint(x: radius, y: radius),
                    radius: radius,
                    startAngle: .degrees(Double(startAngle)),
                    endAngle: .degrees(Double(endAngle)),
                    clockwise: false)
        
        if !reachedTop {
            let startAngleRadians2 = (startAngle + 4) * CGFloat.pi / 180
            let startPoint2 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius + 8, angle: startAngleRadians2)
            let startPoint3 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius - 8, angle: startAngleRadians2)
            
            path.move(to: startPoint1)
            path.addLine(to: startPoint2)
            path.move(to: startPoint1)
            path.addLine(to: startPoint3)
        }
        
        if !reachedBottom {
            let endAngleRadians2 = (endAngle - 4) * CGFloat.pi / 180
            let endPoint2 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius + 8, angle: endAngleRadians2)
            let endPoint3 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius - 8, angle: endAngleRadians2)
            
            path.move(to: endPoint1)
            path.addLine(to: endPoint2)
            path.move(to: endPoint1)
            path.addLine(to: endPoint3)
        }
        
        return path
    }
}

extension CGPoint {
    static func pointOnCircle(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
}

extension Color {
    static let lightBackground = Color(red: 243/255, green: 243/255, blue: 243/255)
    static let darkBackground = Color(red: 34/255, green: 51/255, blue: 68/255)
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
