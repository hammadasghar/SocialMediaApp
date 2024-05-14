//
//  AppManager.swift
//  Social Media App
//
//  Created by hammad aghar on 13/05/2024.
//

import Foundation
import UIKit

class AppManager {
    // Create Singleton
    static let shared = AppManager()
    private var user: User?

    private init() {}
    
    func setUser(user: User?) {
        self.user = user
    }
    
    func getUser() -> User? {
        return user
    }
    
}
