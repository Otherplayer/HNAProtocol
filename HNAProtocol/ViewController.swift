//
//  ViewController.swift
//  HNAProtocol
//
//  Created by __无邪_ on 2017/8/29.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

import UIKit


// 在方法中改变方法所属的实例,如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。
protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable { //注意此处是枚举
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

// 协议作为类型,尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用。协议可以像其他普通类型一样使用，使用场景如下：

// 1.作为函数、方法或构造器中的参数类型或返回值类型
// 2.作为常量、变量或属性的类型
// 3.作为数组、字典或其他容器中的元素类型

protocol RandomNumberGenerator {
    func random() -> Double
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
        print(lightSwitch)
        
        let generator = LinearCongruentialGenerator()
        let d6 = Dice(sides: 6, generator: generator)
        for _ in 1...50 {
            print("Random dice roll is \(d6.roll())")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    
    
    
    
    
    
    
    

}


