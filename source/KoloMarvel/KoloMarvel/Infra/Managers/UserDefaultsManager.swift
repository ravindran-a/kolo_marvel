//
//  UserDefaultsManager.swift
//  KoloMarvel
//
//  Created by Ravindran on 04/05/22.
//

import Foundation

class UserDefaultsManager {
    
    enum UserDefaultsKeys: String {
        case searchHistory = "in.personal.KoloMarvel.weatherInfo"
        
        static let allValues: [UserDefaultsKeys] = {
            return [.searchHistory]
        }()
    }
    
    static func setValue(_ value: Any?, forKey key: UserDefaultsKeys, synchronize: Bool = true) {
        
        guard let confirmedValue = value else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.setValue(confirmedValue, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    static func setInt(_ int: Int?, forKey key: UserDefaultsKeys, synchronize: Bool = true) {
        
        guard let confirmedInt = int else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedInt, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    static func setString(_ string: String?, forKey key: UserDefaultsKeys, synchronize: Bool = true) {
        
        guard let confirmedString = string else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedString, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    static func setObject(_ object: Any?, forKey key: UserDefaultsKeys, synchronize: Bool = true) {
        
        guard let confirmedObject = object else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedObject, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
    }
    
    static func setBool(_ bool: Bool?, forKey key: UserDefaultsKeys, synchronize: Bool = true) {
        
        guard let confirmedBool = bool else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedBool, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    static func removeValueForKey(_ key: UserDefaultsKeys, synchronize: Bool = true) {
        
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    static func removeAllUserDefaultValues() {
        for item in UserDefaultsKeys.allValues {
            UserDefaultsManager.removeValueForKey(item)
        }
    }
    
    static func stringForKey(_ key: UserDefaultsKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    static func integerForKey(_ key: UserDefaultsKeys) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    static func objectForKey(_ key: UserDefaultsKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue) as Any?
    }
    
    static func boolForKey(_ key: UserDefaultsKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    static func valueForKey(_ key: UserDefaultsKeys) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
}
