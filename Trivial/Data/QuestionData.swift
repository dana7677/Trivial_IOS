//
//  QuestionData.swift
//  Trivial
//
//  Created by Tardes on 27/1/25.
//
import Foundation

enum CategoryQuestionEnum:Codable {
    case Geografia
    case ArtAndLiterature
    case History
    case Entertainment
    case Science
    case Sports
}

struct QuestionData:Codable {
    
    let results: [DataQuestion]
}

struct DataQuestion:Codable{
    
    let id: Int
    let CategoryQuestion: CategoryQuestionEnum
    let QuestionText: String
    let Answers:Array<DataAnswer>
    let CorrectAnswerTxt:String
    let FailAnswerTxt:String
}

struct DataAnswer:Codable{
    
    let AnswerText:String
    let ItsCorrect:Bool
}
