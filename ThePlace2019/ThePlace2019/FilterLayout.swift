//
//  FilterLayout.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import FloatingPanel

class FilterLayout: FloatingPanelLayout {
    
    public var supportedPositions: Set<FloatingPanelPosition> {
        return [.half]
    }
    
    public var initialPosition: FloatingPanelPosition {
        return .half
    }
    
    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 0.0
        case .half: return 200.0
        default: return 0
        }
    }
}
