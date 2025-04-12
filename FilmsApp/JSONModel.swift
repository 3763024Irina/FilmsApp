//
//  JSONModel.swift
//  FilmsApp
//
//  Created by Irina on 7/4/25.
//

import Foundation
import AVKit

class JSONModel: Codable {
    var original_title: String?
    var poster_path: String?
    var release_date: String?
    var overview: String?
    var vote_average: Double?
    var backdrop_path: String?
}
class TestModel {
    var testPic: String?
    var testTitle: String?
    var testYeah: String?
    var testRating: String?
    
    init(testPic: String?, testTitle: String?, testYeah: String?, testRating: String) {
        self.testPic = testPic
        self.testTitle = testTitle
        self.testYeah = testYeah
        self.testRating = testRating
    }
}

