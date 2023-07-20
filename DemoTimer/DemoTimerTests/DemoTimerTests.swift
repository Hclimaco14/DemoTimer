//
//  DemoTimerTests.swift
//  DemoTimerTests
//
//  Created by Hector Climaco on 07/07/23.
//

import XCTest
@testable import DemoTimer

final class DemoTimerTests: XCTestCase {
    
    let configWorker = ConfigureTimerWorker()
    
    override func setUpWithError() throws {
        let _ = DefaultManager.shared.saveConfigurations(arrayList: configWorker.loadActions())
        let _ = DefaultManager.shared.saveModes(arrayList: configWorker.loadModes())
    }

    func testModes() {
        let modes = DefaultManager.shared.getModes()
        
        print(modes.map({ "\($0.id)) \($0.name): \($0.isOn)" }))
        
        XCTAssert(!modes.isEmpty)
    }
    
    func testConfigurations() {
        
        let config = DefaultManager.shared.getConfigurations()
        for conf in config {
            let str = conf.configureActions.map{ $0.description }
            print(str)
        }
        
        XCTAssert(!config.isEmpty)
    }

}
