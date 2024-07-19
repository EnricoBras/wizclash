//
//  HostingController.swift
//  CodeNameWizard
//
//  Created by Enrico Brasiello on 30/06/24.
//

import Foundation
import SwiftUI
import SpriteKit

class HostingController: UIHostingController<GameView> {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
}
