//
//  PiModele.swift
//  SwiftPi
//
//  Created by Josselin Abel on 28/01/2021.
//

import Foundation

struct piModele {
    private var pointTableau: [Point] = []
    private var nbPointTotal: Int = 3
    private var nbPointInCircle: Int = 0
    private var pi: Float = 0.0
    private var tableau: [String] = []

    
    var getTableau: [Point] {
        get{return pointTableau}
    }
    
    var getScoreTableau: [String] {
        get{return tableau}
    }
    
    
    var getTotal: Int {
        get{return nbPointTotal}
    }
    
    var getPointInCircle: Int {
        get{return nbPointInCircle}
    }
    

    mutating func calcPi() -> Float {
        let piValue = 4 * Float(nbPointInCircle)/Float(nbPointTotal)
        let piRounded = Float(round(1000*piValue)/1000)
        let key: String = "\(nbPointTotal)"
        
        
        let tmp: Float? = readPlist(namePlist: "highscores", key: key)
        if tmp != nil {
            var compare = abs(piRounded - Float.pi)
            var compareScore = abs(tmp! - Float.pi)
            if compareScore > compare {
                writePlist(namePlist: "highscores", key: key, data: piRounded)
            }
        }else{
            writePlist(namePlist: "highscores", key: key, data: piRounded)
        }
        return piRounded
    }
    
    mutating func fillTableau() -> [String] {
        tableau.removeAll()
        var nb = 1000
        for i in 2...20 {
            if readPlist(namePlist: "highscores", key: "\(nb)") != nil {
                tableau.append("\(nb) \(readPlist(namePlist: "highscores", key: "\(nb)")!)")
            }
            nb = nb + 1000
        }
        
        return tableau
    }

    mutating func drawPoint(nbPoint: Int, squareSide: Float) {
        nbPointTotal = nbPoint
        let limit = squareSide
        var point: Point
        nbPointInCircle = 0;
        
        if nbPointTotal > 1 {
            pointTableau.removeAll()
            for _ in 1...nbPointTotal {
                let x = Int.random(in: 0..<Int(limit))
                let y = Int.random(in: 0..<Int(limit))
                
                let d: Float = pow(Float(x) - squareSide/2, 2) + pow(Float(y) - squareSide/2, 2)
                let r: Float = pow(squareSide/2, 2)
                if d <= r {
                    point = Point(isInCircle: true, x: x, y: y)
                    nbPointInCircle = nbPointInCircle + 1
                }else{
                    point = Point(isInCircle: false, x: x, y: y)
                }
                pointTableau.append(point)
            }
        }
    }
    
    func writePlist(namePlist: String, key: String, data: Float) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent(namePlist+".plist")
        
        if let dict = NSMutableDictionary(contentsOfFile: path){
                dict.setObject(data, forKey: key as NSCopying)
                if dict.write(toFile: path, atomically: true){
                    print("plist_write")
                }else{
                    print("plist_write_error")
                }
            }else{
                if let privPath = Bundle.main.path(forResource: namePlist, ofType: "plist"){
                    if let dict = NSMutableDictionary(contentsOfFile: privPath){
                        dict.setObject(data, forKey: key as NSCopying)
                        if dict.write(toFile: path, atomically: true){
                            print("plist_write")
                        }else{
                            print("plist_write_error")
                        }
                    }else{
                        print("plist_write")
                    }
                }else{
                    print("error_find_plist")
                }
            }
    }
    
    func readPlist(namePlist: String, key: String) -> Float?{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent(namePlist+".plist")
        
        var output:Float? = 0.0 as Float
        
        if let dict = NSMutableDictionary(contentsOfFile: path) {
                output = dict.object(forKey: key) as! Float?
        }else{
            if let privPath = Bundle.main.path(forResource: namePlist, ofType: "plist"){
                if let dict = NSMutableDictionary(contentsOfFile: privPath){
                    output = dict.object(forKey: key) as! Float?
                }else{
                    output = nil
                    print("error_read")
                }
            }else{
                output = nil
                print("error_read")
            }
        }
        print("plist_read \(output)")
        return output as! Float?
    }
}
