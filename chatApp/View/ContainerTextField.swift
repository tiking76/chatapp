//
// Created by 舘佳紀 on 2020/07/13.
// Copyright (c) 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit

class CustomTextField : UITextField {
    init(placeholder : String) {
        super.init(frame: .zero)

        borderStyle = .none

        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
