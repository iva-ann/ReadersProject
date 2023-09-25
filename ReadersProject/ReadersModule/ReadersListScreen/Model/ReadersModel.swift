//
//  ReadersModel.swift
//  ReadersProject
//
//  Created by Анна Иванова on 24.09.2023.
//

import Foundation
import UIKit

enum ReadListViewData {
    case initial(NavBarData, [ReaderData])
    case updateTable(String, [ReaderData])
}

struct ReaderData {
    let readerName: String
    let dateOfBirth: String
    var state: ReaderState
}

enum ReaderState: Int {
    case overdueBook
    case getBook
    case noBooks
    
    var titleText: String {
        switch self {
        case .overdueBook:      return "Просроченные книги"
        case .getBook:          return "Взял книги"
        case .noBooks:          return "Нет книг"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .overdueBook:       return UIColor(hexString: "D61717")
        case .getBook:           return UIColor(hexString: "D65C15")
        case .noBooks:           return UIColor(hexString: "14913E")
        }
    }
    
    var bgColor: UIColor {
        switch self {
        case .overdueBook:       return UIColor(hexString: "FFE8E8")
        case .getBook:           return UIColor(hexString: "FFF0D2")
        case .noBooks:           return UIColor(hexString: "C7F9D5")
        }
    }
}

extension ReaderData {
    static let mockReaders: [ReaderData] = [
    ReaderData(readerName: "Черкасов Артур Всеволодович-Черкасов",
               dateOfBirth: "15.05.2001",
               state: .overdueBook),
    ReaderData(readerName: "Виноградова Ника Ярославовна",
               dateOfBirth: "15.05.2001",
               state: .getBook),
    ReaderData(readerName: "Колесников Михаил Евгеньевич",
               dateOfBirth: "15.05.2001",
               state: .noBooks),
    ReaderData(readerName: "Широкова Вера Артёмовна",
               dateOfBirth: "15.05.2001",
               state: .noBooks),
    ReaderData(readerName: "Сидоров Петр Иванович",
               dateOfBirth: "15.05.2001",
               state: .getBook),
    ReaderData(readerName: "Воркутова Авдотья Калымовна",
               dateOfBirth: "15.05.2001",
               state: .overdueBook)
    ]
}

enum ReaderFilteringType {
    case firstOverdue
    case alphabetically
    
    var titleText: String {
        switch self {
        case .firstOverdue:         return "Сначала просроченные книги"
        case .alphabetically:       return "По алфавиту"
        }
    }
}
