//
//  TouchIDAuthentication.swift
//  TouchMeIn
//
//  Created by Abdullah Alhassan on 10/3/17.
//  Copyright © 2017 iT Guy Technologies. All rights reserved.
//

import Foundation
import LocalAuthentication

open class TouchIDAuthentication {
    
    fileprivate let context = LAContext()
    fileprivate var policy : LAPolicy
    
    init() {
        
        if #available(iOS 9.0, *) {
            policy = .deviceOwnerAuthentication
        } else {
            context.localizedFallbackTitle = "Use Passcode"
            policy = .deviceOwnerAuthenticationWithBiometrics
        }
    }
    
    // This funciton returns true if the devices used has
    // touchId functionality
    open func canEvaluateTouchID() -> Bool {
        return context.canEvaluatePolicy(policy, error: nil)
    }
    
    // This function is called when you want to authenticate the current
    // user of the app is the owner of the device
    func authenticateUser(with numOfAttempt: Int = 1, completion: @escaping (String?) -> ()) {
        // STEP 1 check touch ID availability
        
        guard canEvaluateTouchID() && numOfAttempt > 0 else {
            completion("Touch ID not available")
            return
        }
        print(context.touchIDAuthenticationAllowableReuseDuration)
        context.evaluatePolicy(policy, localizedReason: "Loggin with Touch ID") { (success, error) in
            if success {
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else {
                
                let message : String!
                // These are some error cases, but there are much more
                switch error {
                case LAError.authenticationFailed?:
                    message = "There was a problem verifying your identity."
                case LAError.userCancel?:
                    message = "You pressed cancel."
                case LAError.userFallback?:
                    message = "You pressed password."
                default:
                    message = "Touch ID may not be configured"
                }
                DispatchQueue.main.async {
                    completion(message)
                }
            }
        }
        
    }
    
}
