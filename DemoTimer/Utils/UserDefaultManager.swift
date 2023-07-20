//
//  UserDefaultManager.swift
//  DemoTimer
//
//  Created by Hector Climaco on 19/07/23.
//

import Foundation

///Class to manage userdefaults
class DefaultManager {
    
    private var Usdefaults: UserDefaults?
    private let suiteName = "TimerDefault"

    
    enum keys:String {
        case userPreferences = "userPreferences"
        case configuration = "configurations"
        case modes = "modes"
    }
    
    public static let shared = DefaultManager()
    
    init() {
        self.Usdefaults = UserDefaults(suiteName: suiteName)
    }
    
    
    /// Function to clear all data saved
    func clear() {
        guard let defaults = self.Usdefaults else { return }
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    
    /// Function to save UserPreference in UserDefaults
    func saveUserPreferences(object: ConfigureModel.UserPreference ) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            guard Usdefaults != nil else { return }
            Usdefaults?.set(encoded, forKey: keys.userPreferences.rawValue)
        }
    }
    
    /// Function to get object from UserDefaults
    /// - Returns: (optional) object saved
    func getUserPreference() -> ConfigureModel.UserPreference? {
        guard Usdefaults != nil else { return nil }
        if let objectData = Usdefaults?.object(forKey: keys.userPreferences.rawValue ) as? Data {
            let decoder = JSONDecoder()
            if let oject = try? decoder.decode( ConfigureModel.UserPreference.self, from: objectData) {
                return oject
            }
            return nil
        }
        return nil
    }
    
    /// function to save array object in UserDefaults
    /// - Parameter arrayList: array anyObject
    /// - Returns: bool to indicated if object as saved
    func saveConfigurations(arrayList:[ConfigureModel.Configuration]) -> Bool {
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(arrayList) {
            guard Usdefaults != nil else { return false }
            Usdefaults?.set(data, forKey: keys.configuration.rawValue )
            return true
        }
        return false
    }
    
    /// Function to get  array objects from UserDefaults
    /// - Returns: array with object if failure return array void
    func getConfigurations() -> [ConfigureModel.Configuration] {
        guard Usdefaults != nil else { return [] }
        if let arrayData = Usdefaults?.object(forKey: keys.configuration.rawValue) as? Data {
            let decoder = PropertyListDecoder()
            if let arrayObjects = try? decoder.decode([ConfigureModel.Configuration].self, from: arrayData) {
                return arrayObjects
            }
            return []
        }
        return []
    }
    
    /// function to save array object in UserDefaults
    /// - Parameter arrayList: array anyObject
    /// - Returns: bool to indicated if object as saved
    func saveModes(arrayList:[ConfigureModel.EnableMode]) -> Bool {
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(arrayList) {
            guard Usdefaults != nil else { return false }
            Usdefaults?.set(data, forKey: keys.modes.rawValue )
            return true
        }
        return false
    }
    
    /// Function to get  array objects from UserDefaults
    /// - Returns: array with object if failure return array void
    func getModes() -> [ConfigureModel.EnableMode] {
        guard Usdefaults != nil else { return [] }
        if let arrayData = Usdefaults?.object(forKey: keys.modes.rawValue) as? Data {
            let decoder = PropertyListDecoder()
            if let arrayObjects = try? decoder.decode([ConfigureModel.EnableMode].self, from: arrayData) {
                return arrayObjects
            }
            return []
        }
        return []
    }

}
