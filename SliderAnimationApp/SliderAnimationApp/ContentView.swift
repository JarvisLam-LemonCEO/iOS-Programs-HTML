//
//  ContentView.swift
//  SliderAnimationApp
//
//  Created by Jarvis Lam on 12/28/21.
//

import SwiftUI

struct ContentView: View {
    @State var yOffset: CGFloat = 40
    let range:  ClosedRange<CGFloat> = -120 ... 140
    
    var percentage: Double {
        var percentage = (yOffset + abs(range.lowerBound)) / (range.upperBound + abs(range.lowerBound))
        percentage = percentage * 2 - 1
        print(percentage)
        
        return Double(percentage)
        
    }
    
    var body: some View {
        ZStack {
            
            Color.yellow
            
            Color.green
                .opacity(percentage)
            
            Color.red
                .opacity(-percentage)
            VStack {
                Text("How was your day?")
                    .font(.system(size: 34, weight: .bold))
               
                Smiley(yOffset: yOffset)
                    .stroke(Color.black, lineWidth: 5)
                    .frame(height: 500)
                    //.background(Color.green)
                
                Slider(value: $yOffset, in: range)
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea()
    }
}

struct Smiley: Shape {
    
    let yOffset: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let spacing: CGFloat = 180
        
        // left eye
        path.addPath(getEye(_path: path, rect: rect))
        path = path.applying(.init(scaleX: -1, y: 1))
        path = path.applying(.init(translationX: rect.maxX - spacing, y: 0))
        
        // right eye
        path.addPath(getEye(_path: path, rect: rect))
        path = path.applying(.init(translationX: spacing / 2, y: 0))
        
        // move eyes up
        // this adds more movement to the eyes
        path = path.applying(.init(translationX: 0, y: -150 + yOffset / 4))
        
        // mouth
        path.addPath(getMouth(_path: path, rect: rect))
        
        return path
    }
    
    func getMouth(_path: Path, rect: CGRect) -> Path {
        var path = _path
        
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let controlPtn1 = CGPoint(x: startPoint.x + 10, y: rect.midY + yOffset)
        let controlPtn2 = CGPoint(x: endPoint.x + 10, y: rect.midY + yOffset)
        
        path.move(to: startPoint)
        //path.addLine(to: endPoint)
        path.addCurve(to: endPoint, control1: controlPtn1, control2: controlPtn2)
        
        return path
    }
    
    func getEye(_path: Path, rect: CGRect) -> Path {
        var path = _path
        
        let startPoint = CGPoint(x: rect.midX - 50, y: rect.midY)
        let bottomPoint = CGPoint(x: startPoint.x + 50, y: startPoint.y + 50)
        
        let controlPtn1 = CGPoint(x: startPoint.x, y: bottomPoint.y)
        let rightPtn = CGPoint(x: startPoint.x + 100, y: startPoint.y - 30)
        let controlPtn2 = CGPoint(x: rightPtn.x, y: bottomPoint.y)
        
        
        
        path.move(to: startPoint)
        path.addQuadCurve(to: bottomPoint, control: controlPtn1)
        path.addQuadCurve(to: rightPtn, control: controlPtn2)
        
        let offset: CGFloat = yOffset / 5
        let controlPtn3 = CGPoint(x: rightPtn.x - 5, y: rightPtn.y - offset)
        let controlPtn4 = CGPoint(x: startPoint.x + 5, y: rightPtn.y - offset)
    
        path.addCurve(to: startPoint, control1: controlPtn3, control2: controlPtn4)
        
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
