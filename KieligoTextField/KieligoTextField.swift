//
//  KieligoTextFieldView.swift
//  Kieligo
//
//  Created by Etienne Jézéquel on 16/09/2019.
//  Copyright © 2019 Etienne Jezequel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class KieligoTextField: UIView {

    // MARK: - Privates
    
    // MARK: - IBInspectable

    @IBInspectable private var textColor: UIColor = .black {
        didSet { textField.textColor = textColor }
    }
    @IBInspectable private var textTintColor: UIColor = .black {
        didSet { textField.tintColor = tintColor }
    }
    @IBInspectable private var placeHolderColor: UIColor = .black {
        didSet { lblPlaceholder.textColor = placeHolderColor }
    }
    @IBInspectable private var lineColor: UIColor = .black {
        didSet { viewBottom.backgroundColor = lineColor }
    }
    
    private let disposeBag = DisposeBag()
    
    // MARK: - IBOutlet
    
    @IBOutlet fileprivate weak var textField: UITextField!
    @IBOutlet fileprivate weak var lblPlaceholder: UILabel!
    @IBOutlet fileprivate weak var viewBottom: UIView!
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

// MARK: - KieligoTextField

extension KieligoTextField {
    
    fileprivate func setup() {
        // Load xib
        guard let nibView = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: KieligoTextField.self)).instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Cannot fetch \(String(describing: type(of: self)))")
        }
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        nibView.frame = bounds
        addSubview(nibView)

        // Content view
        animateView(0)

        textField.rx.controlEvent([.editingDidBegin, .editingDidEnd]).asObservable().subscribe { _ in
            self.animateView()
        }.disposed(by: disposeBag)
    }
    
    fileprivate func animateView(_ duration: Double = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            let state = (self.textField.text?.isEmpty ?? true) && !self.textField.isEditing
            let translationY = (self.textField.frame.origin.y + self.textField.frame.height) / 2
            self.lblPlaceholder.transform = CGAffineTransform(translationX: 0, y: state ? translationY : 0)
            self.viewBottom.alpha = state ? 0.2 : 1
        })
    }
}

public extension KieligoTextField {

    func setup(placeholder: String, contentType: UITextContentType? = nil, keyboardType: UIKeyboardType, isSecure: Bool = false) {
        textField.isSecureTextEntry = isSecure
        lblPlaceholder.text = placeholder
        textField.keyboardType = keyboardType
        if let contentType = contentType {
            textField.textContentType = contentType
        }
    }
    
    func getTextField() -> UITextField {
        return textField
    }
    
    func getRxTextField() -> ControlProperty<String?> {
        return textField.rx.text
    }
    
    func setTextFieldFont(_ font: UIFont) {
        textField.font = font
    }
    
    func setPlaceHolderFont(_ font: UIFont) {
        lblPlaceholder.font = font
    }
}
