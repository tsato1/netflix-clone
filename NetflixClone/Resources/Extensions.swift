//
//  Extensions.swift
//  NetflixClone
//
//  Created by Takahide Sato on 10/24/22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
