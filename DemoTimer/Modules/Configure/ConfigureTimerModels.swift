//
//  ConfigureTimerModels.swift
//  DemoTimer
//
//  Created by Hector Climaco on 09/07/23.
//  
//

import UIKit

public protocol ConfigurationAction {
    init()
    var id:Int { get set }
    var isEnable: Bool { get set }
    var name: String { get set }
    
}

enum ConfigureModel {
    
    public struct EnableMode {
        var id:Int
        var name: String
        var isOn:Bool
        
        init() {
            self.id = 0
            self.name = ""
            self.isOn = false
        }
        
        init(id: Int, name: String, isOn: Bool) {
            self.id = id
            self.name = name
            self.isOn = isOn
        }
    }
    
    public struct Configuration {
        var name:String
        var selection: String
        var type: TypeConfiguration
        var configurations: [ConfigurationAction]
        
        public init() {
            self.name = ""
            self.selection = ""
            self.type = .sound
            self.configurations = []
        }
        
        public init(name: String, selection: String, type: TypeConfiguration, configurations:[ConfigurationAction]) {
            self.name = name
            self.selection = selection
            self.type = type
            self.configurations = configurations
        }
    }
    
    public struct SoundAction:ConfigurationAction {
        public var id: Int
        public var isEnable: Bool
        public var name: String
        public var action: Sound
        
        init(id: Int, isEnable: Bool, name: String, action: Sound) {
            self.id = id
            self.isEnable = isEnable
            self.name = name
            self.action = action
        }
        
        init() {
            self.id = 0
            self.isEnable = false
            self.name = ""
            self.action = .sound1
        }
    }
    
    public struct VibracionAction:ConfigurationAction {
        public var id: Int
        public var isEnable: Bool
        public var name: String
        public var action: Vibration
        
        init(id: Int, isEnable: Bool, name: String, action: Vibration) {
            self.id = id
            self.isEnable = isEnable
            self.name = name
            self.action = action
        }
        
        init() {
            self.id = 0
            self.isEnable = false
            self.name = ""
            self.action = .vabration1
        }
        
        
    }
    
    public enum TypeConfiguration {
        case sound
        case vibration
    }
    
}
