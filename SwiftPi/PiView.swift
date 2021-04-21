//
//  PiView.swift
//  SwiftPi
//
//  Created by Josselin Abel on 04/01/2021.
//

import UIKit

@IBDesignable
class PiView: UIView {
    @IBInspectable var scale: CGFloat = 0.9
    @IBInspectable var circleRadius: CGFloat {return min(bounds.size.width, bounds.size.height) / 2 * scale}
    @IBInspectable var circleCenter: CGPoint {return CGPoint(x: bounds.midX, y: bounds.midY  - 100)}
    @IBInspectable var squareSide: Float {return Float(circleRadius)*2}
    @IBInspectable var lineWidth: CGFloat = 3.0
    @IBInspectable var lineColor: UIColor = UIColor.blue
    private var modele = piModele()
    var pointTableau: [Point] = []
    var nbPointTotal: Int = 0
    var nbPointInCircle: Int = 0
    var startX: CGFloat = 0
    var startY: CGFloat = 0
    

    
    func pathForSquare() -> UIBezierPath {
        let path = UIBezierPath()
        startX = circleCenter.x - circleRadius
        startY = circleCenter.y - circleRadius

        path.move(to: CGPoint(x: startX, y: startY))

        path.addLine(to: path.currentPoint)
        path.addLine(to: CGPoint(x: startX + circleRadius*2, y: startY))
        path.addLine(to: path.currentPoint)
        path.addLine(to: CGPoint(x: startX + circleRadius*2, y: startY + circleRadius*2))
        path.addLine(to: path.currentPoint)
        path.addLine(to: CGPoint(x: startX, y: startY + circleRadius*2))
        path.addLine(to: path.currentPoint)
        path.lineWidth = lineWidth
        path.close()
        return path
    }
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        lineColor.set()
        pathForSquare().stroke()
        print(nbPointTotal)
        if nbPointTotal > 1 {
            for dot in pointTableau {
                if (dot.isInCircle) {
                    UIColor.green.set()
                }else{
                    UIColor.red.set()
                }
                var pathForPoint: UIBezierPath {
                    let x = dot.x  + Int(circleCenter.x - circleRadius)
                    let y = dot.y  + Int(circleCenter.y - circleRadius)
                    let pointCenter = CGPoint(x: x, y: y)
                    let path = UIBezierPath(arcCenter: pointCenter, radius: 1, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
                    path.lineWidth = lineWidth
                    return path
                }
                pathForPoint.stroke()
            }
        }
    }
    
    
}
