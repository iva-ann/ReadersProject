//
//  BookModel.swift
//  ReadersProject
//
//  Created by Анна Иванова on 26.09.2023.
//

import Foundation
import UIKit

enum BooksListViewData {
    case initial(NavBarData, [BookData])
}

struct BookData {
    let name: String
    let author: String
    let image: UIImage?
}

extension BookData {
    static let mockData: [BookData] = [
    BookData(name: "Пир во время чумы",
             author: "Александр Пушкин",
             image: UIImage(named: "booksMock1")),
    BookData(name: "Великий Гэтсби",
             author: "Френсис Скотт Фицджеральд",
             image: UIImage(named: "booksMock2")),
    BookData(name: "Преступление и наказание",
             author: "Федор Достоевский",
             image: UIImage(named: "booksMock3")),
    BookData(name: "Маленький принц",
             author: "Антуан де Сент-Экзюпери",
             image: UIImage(named: "booksMock4"))
    ]
}
