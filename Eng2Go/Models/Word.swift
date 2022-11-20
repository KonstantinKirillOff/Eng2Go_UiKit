//
//  Word.swift
//  Eng2Go
//
//  Created by Konstantin Kirillov on 12.10.2022.
//

import Foundation

struct Word {
    var engName: String
    var rusName: String
    var transcription: String?
    var urlImage: String?
    var type: WordType
}

enum WordType: String {
    case new = "New"
    case inProgress = "In progress"
    case done = "Learnt"
}
