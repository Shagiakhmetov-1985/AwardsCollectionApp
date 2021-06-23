//
//  HypocycloidView.swift
//  Lesson 6
//
//  Created by Alexey Efimov on 24.06.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import SwiftUI


struct HypocycloidView: View {
    @State private var bigR = 4.176737
    @State private var smallR = 1.76
    
    let width: CGFloat
    let height: CGFloat
    let showSliders: Bool
    
    private let p = 1.0
    private let color = Color.red
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Path { path in
                    let size = min(geometry.size.width, geometry.size.height)
                    let ratio = Double(size) / ((bigR - smallR) + smallR * p) / 2.0
                    
                    var angle = 0
                    let maxT = 2880
                    var curveClosed = false
                    
                    var x0 = 0.0
                    var y0 = 0.0
                    
                    while(angle < maxT && !curveClosed) {
                        let theta = Angle(degrees: Double(angle)).radians
                        let component = ((bigR + smallR) / smallR) * theta
                        let x = (bigR - smallR) * cos(theta) + smallR * p * cos(component)
                        let y = (bigR - smallR) * sin(theta) - smallR * p * sin(component)
                        let xc = x * ratio
                        let yc = y * ratio
                        
                        if angle == 0 {
                            x0 = xc
                            y0 = yc
                            path.move(to: CGPoint(x: x0, y: y0))
                        } else {
                            path.addLine(to: CGPoint(x: xc, y: yc))
                            if abs(xc - x0) < 0.25 && abs(yc - y0) < 0.25 {
                                curveClosed = true
                            }
                        }
                        angle += 1
                    }
                }
                .offset(x: geometry.size.width / 2.0, y: geometry.size.height / 2.0)
                .stroke(color, lineWidth: 2)
            }
            .frame(width: width, height: height)
            
            if showSliders {
                Slider(value: $bigR, in: 1...10)
                Slider(value: $smallR, in: 1...10)
            }
        }
        .padding()
    }
}

struct HypocycloidView_Previews: PreviewProvider {
    static var previews: some View {
        HypocycloidView(width: 200, height: 200, showSliders: true)
    }
}
