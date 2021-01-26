//
//  String.swift
//  Game
//
//  Created by Pranav Simha on 2/16/20.
//  Copyright © 2020 Pranav Simha. All rights reserved.
//

import Foundation
extension String
{
    static func randomNumber(length: Int) -> String
    {
        var result = ""
        for _ in 0..<length
        {
            let digit = Int.random(in: 0...9)
            result += "\(digit)"
        }
        return result
    }
    
    func integer(at n: Int) -> Int
    {
        let index = self.index(self.startIndex, offsetBy: n)
        
        return self[index].wholeNumberValue ?? 0
    }
}
