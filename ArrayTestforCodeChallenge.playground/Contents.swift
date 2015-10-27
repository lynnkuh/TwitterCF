//: Playground - noun: a place where people can play

import UIKit

let initialArray = ["one", "two", "three"]
var myArray = [String]()


func reverseArray(initialArray: [String]) -> [String] {
    
    let count = initialArray.count - 1
    myArray = [String]()
    
    for var i = count; i >= 0; i-- {
        myArray.append(initialArray[i])
    }
    
    return myArray
}

let newArray = reverseArray(initialArray)