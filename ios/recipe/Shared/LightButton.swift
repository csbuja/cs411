//
//  ProfileLightButton.swift
//  recipe
//
//  Created by Mochammad Dikra Prasetya on 2021/04/03.
//

import UIKit

public class LightButton: UIButton {

  public override init(frame: CGRect) {
    super.init(frame: frame)

    setTitleColor(.black, for: .normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 16)
    backgroundColor = .white
    layer.borderColor = UIColor.black.cgColor
    layer.borderWidth = 2
    addTarget(self, action: #selector(highlightButton(_:)), for: .touchDown)
    addTarget(self, action: #selector(unhighlightButton(_:)), for: .touchUpInside)
    addTarget(self, action: #selector(unhighlightButton(_:)), for: .touchUpOutside)
    addTarget(self, action: #selector(unhighlightButton(_:)), for: .touchCancel)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc func highlightButton(_ sender: Any?) {
    self.backgroundColor = UIColor(white: 0.9, alpha: 1)
  }

  @objc func unhighlightButton(_ sender: Any?) {
    self.backgroundColor = .white
  }
}
