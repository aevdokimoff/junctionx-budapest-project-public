//
//  HeatMapsView.swift
//  SwiftUIIntegrateUIKitTutorial
//
//  Created by Artem Evdokimov on 20.10.19.
//  Copyright © 2019 Arthur Knopper. All rights reserved.
//

import UIKit

class HeatMapsView: UIView {

    @IBOutlet weak var button: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let bundle = Bundle.init(for: HeatMapsView.self)
        if let viewsToAdd = bundle.loadNibNamed("HeatMapsView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight,
                                            .flexibleWidth]
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
