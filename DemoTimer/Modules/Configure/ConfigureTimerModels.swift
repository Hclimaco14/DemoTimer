//
//  ConfigureTimerModels.swift
//  DemoTimer
//
//  Created by Hector Climaco on 09/07/23.
//  
//

import UIKit

enum ConfigureModel {
    
    public enum TypeConfiguration: Codable {
        case sound
        case vibration
        
        var name: String {
            switch self {
            case .sound:
                return "Sonidos"
            case .vibration:
                return "Vibraciones"
            }
        }
    }
    
    public enum Mode:Int, Codable {
        case undefined = 0
        case soundAndVibration = 1
        case onlySound = 2
        case onlyVibration = 3
        
        var name: String {
            switch self {
            case .undefined:
                return "Sin Seleccionar"
            case .soundAndVibration:
                return "Sonido y Vibracion"
            case .onlySound:
                return "Solo Sonido"
            case .onlyVibration:
                return "Solo Vibracion"
            }
        }
    }
    
    
    public struct EnableMode: Codable {
        var id:Int {
            return mode.rawValue
        }
        var name: String {
            return mode.name
        }
        var mode: Mode
        var isOn:Bool
        
        init() {
            self.isOn = false
            self.mode = .undefined
        }
        
        init(mode: Mode,isOn: Bool) {
            self.mode = mode
            self.isOn = isOn
        }
    }
    
    public struct Configuration:Codable {
        
        var name:String {
            return type.name
        }
        
        var selection: String {
            return configureActions.first(where: { $0.isEnable })?.name ?? "Seleccionar"
        }
        
        var type: TypeConfiguration
        var configureActions: [ConfigurationAction]
        
        public init() {
            self.type = .sound
            self.configureActions = []
        }
        
        public init(type: TypeConfiguration, configurations:[ConfigurationAction]) {
            self.type = type
            self.configureActions = configurations
        }
        
    }
    

    public struct UserPreference: Codable {
        var mode: EnableMode
        var sound: SoundAction
        var vibration: VibracionAction
        var comment: String
        
        init() {
            mode = EnableMode()
            sound = SoundAction()
            vibration = VibracionAction()
            comment = ""
        }
        
        init(mode: ConfigureModel.EnableMode, sound: SoundAction, vibration: VibracionAction,  comment: String) {
            self.mode = mode
            self.sound = sound
            self.vibration = vibration
            self.comment = comment
        }
    }
    
}


class ConfigurationAction: Codable {
    
    public var id: Int
    public var isEnable: Bool
    public var name: String
    
    var description: String {
        return "id: \(self.id) \nisEnable: \(self.isEnable) \nname: \(self.name)"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case isEnable
        case name
    }
    
    init() {
        self.id = 0
        self.isEnable = false
        self.name = ""
    }
    
    internal init(id: Int, isEnable: Bool, name: String) {
        self.id = id
        self.isEnable = isEnable
        self.name = name
    }
    
    required convenience init(from decoder: Decoder) {
        self.init()
        
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? values?.decode(Int.self, forKey: .id) {
            self.id = id
        }
        
        if let isEnable = try? values?.decode(Bool.self, forKey: .isEnable) {
            self.isEnable = isEnable
        }
        
        if let name = try? values?.decode(String.self, forKey: .name) {
            self.name = name
        }
    
    }
    
    public func encode(to encoder: Encoder) {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encode(id, forKey: .id)
        try? container.encode(isEnable, forKey: .isEnable)
        try? container.encode(name, forKey: .name)
        
    }
}

class VibracionAction: ConfigurationAction {

    var action: Vibration
    
    override var description: String {
        return "id: \(super.id) " + super.description
    }
    
    enum CodingKeys: String, CodingKey {
        case action
    }
    
    convenience init?(action: ConfigurationAction) {
        guard let vibration = Vibration(rawValue: action.id) else {
            return nil
        }
        self.init(action: vibration, isEnable: action.isEnable)
    }
    
    
    convenience init?(id: Int, isEnable: Bool) {
        guard let vibration = Vibration(rawValue: id) else {
            return nil
        }
        self.init(action: vibration, isEnable: isEnable)
    }
    
    override init() {
        self.action = .vabration1
        super.init()
    }

    init(action: Vibration, isEnable: Bool) {
        self.action = action
        super.init(id: action.rawValue, isEnable: isEnable, name: action.name)
    }
    
    init(id: Int, isEnable: Bool, name: String, action: Vibration) {
        self.action = action
        super.init(id: id, isEnable: isEnable, name: name)
    }
    
    
    required convenience init(from decoder: Decoder) {
        self.init()
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        if let action = try? values?.decode(Vibration.self, forKey: .action) {
            self.action = action
        }
    }
    
    override func encode(to encoder: Encoder) {
        var container = encoder.container(keyedBy: CodingKeys.self)
        super.encode(to: encoder)
        try? container.encode(action, forKey: .action)
        
    }
}


class SoundAction: ConfigurationAction {
    var action: Sound
    
    override var description: String {
        return "id: \(super.id) " + super.description
    }
    
    enum CodingKeys: String, CodingKey {
        case action
    }
    override init() {
        self.action = .sound1
        super.init()
    }
    
    
    convenience init?(action: ConfigurationAction) {
        guard let sound = Sound(rawValue: action.id) else {
            return nil
        }
        self.init(action: sound, isEnable: action.isEnable)
    }
    
    convenience init?(id: Int, isEnable: Bool) {
        guard let sound = Sound(rawValue: id) else {
            return nil
        }
        self.init(action: sound, isEnable: isEnable)
    }
    
    init(action: Sound, isEnable: Bool) {
        self.action = action
        super.init(id: action.rawValue, isEnable: isEnable, name: action.value)
    }
    init(id: Int, isEnable: Bool, name: String, action: Sound) {
        self.action = action
        super.init(id: id, isEnable: isEnable, name: name)
    }
    
    required convenience init(from decoder: Decoder) {
        self.init()
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        if let action = try? values?.decode(Sound.self, forKey: .action) {
            self.action = action
        }
    }
    
    override func encode(to encoder: Encoder) {
        var container = encoder.container(keyedBy: CodingKeys.self)
        super.encode(to: encoder)
        try? container.encode(action, forKey: .action)
        
    }
}

