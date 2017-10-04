//
//  TouchIDAuthentication.swift
//  TouchMeIn
//
//  Created by Abdullah Alhassan on 10/3/17.
//  Copyright © 2017 iT Guy Technologies. All rights reserved.
//

import Foundation
import LocalAuthentication


class TouchIDAuthentication {
    let context = LAContext()
    
    func canEvaluate() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func authenticateUser(completion: @escaping (String?) -> ()) {
        guard canEvaluate() else {
            completion("Touch ID not available")
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Loggin with Touch ID") { (success, error) in
            if success {
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else {
                let message : String!
                
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
                completion(message)
            }
        }
        
    }
    
}
