//
//  ProfileEditView.swift
//  recipe
//
//  Created by Mochammad Dikra Prasetya on 2021/04/03.
//

import UIKit

public protocol ProfileEditViewDelegate: UIPickerViewDataSource,
                                         UIPickerViewDelegate,
                                         UITextFieldDelegate {
  func profileImageChangeDidTap()
}

public class ProfileEditView: UIView {

  let scrollView = UIScrollView()
  let containerView = UIView()

  let profileImageView = UIImageView(image: UIImage(named: "avatar_placeholder"))
  let profileImageSubtitle = UIButton()

  let nameLabel = UILabel()
  let nameTextField = UITextField()
  let usernameLabel = UILabel()
  let usernameTextField = UITextField()
  let countryLabel = UILabel()
  let countryPicker = UIPickerView()
  let emailLabel = UILabel()
  let emailTextField = UITextField()
  let birthdateLabel = UILabel()
  let birthdateDatePicker = UIDatePicker()

  let changePasswordLabel = UILabel()
  let currentPasswordLabel = UILabel()
  let currentPasswordTextField = UITextField()
  let newPasswordLabel = UILabel()
  let newPasswordTextField = UITextField()
  let reenterNewPasswordLabel = UILabel()
  let reenterNewPasswordTextField = UITextField()

  public weak var delegate: ProfileEditViewDelegate? {
    didSet {
      nameTextField.delegate = delegate
      usernameTextField.delegate = delegate
      emailTextField.delegate = delegate
      currentPasswordTextField.delegate = delegate
      newPasswordTextField.delegate = delegate
      reenterNewPasswordTextField.delegate = delegate
    }
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .white

    // Scroll view

    addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
    ])

    // Contanier view
    scrollView.addSubview(containerView)

    // Profile Image

    containerView.addSubview(profileImageView)
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
      profileImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      profileImageView.widthAnchor.constraint(equalToConstant: 128),
      profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
    ])
    profileImageView.clipsToBounds = true
    profileImageView.addGestureRecognizer(
      UITapGestureRecognizer(target: self, action: #selector(profileImageChangeDidTap(_:)))
    )

    // Profile Image label

    profileImageSubtitle.setTitle("Change Profile Photo", for: .normal)
    profileImageSubtitle.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    profileImageSubtitle.setTitleColor(.systemBlue, for: .normal)
    profileImageSubtitle.backgroundColor = nil
    containerView.addSubview(profileImageSubtitle)
    profileImageSubtitle.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      profileImageSubtitle.topAnchor.constraint(
        equalTo: profileImageView.bottomAnchor,
        constant: 12
      ),
      profileImageSubtitle.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
    ])
    profileImageSubtitle.addTarget(
      self,
      action: #selector(profileImageChangeDidTap(_:)),
      for: .touchUpInside
    )

    // Separator

    let profileSeparatorView = UIView()
    containerView.addSubview(profileSeparatorView)
    profileSeparatorView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    profileSeparatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      profileSeparatorView.topAnchor.constraint(
        equalTo: profileImageSubtitle.bottomAnchor,
        constant: 12
      ),
      profileSeparatorView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
      profileSeparatorView.heightAnchor.constraint(equalToConstant: 1),
    ])

    // Name

    nameLabel.text = "Name"
    containerView.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: profileSeparatorView.bottomAnchor, constant: 12),
      nameLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 24
      ),
      nameLabel.widthAnchor.constraint(equalToConstant: 80),
    ])

    nameTextField.text = "Sam Adams"
    nameTextField.placeholder = "Name"
    nameTextField.textContentType = .name
    nameTextField.delegate = delegate
    containerView.addSubview(nameTextField)
    nameTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
      nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 24),
      nameTextField.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor,
        constant: -24
      ),
    ])
    addUnderlineForView(nameTextField)

    // Username

    usernameLabel.text = "Username"
    containerView.addSubview(usernameLabel)
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
      usernameLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 24
      ),
      usernameLabel.widthAnchor.constraint(equalToConstant: 80),
    ])

    usernameTextField.text = "samadams84"
    usernameTextField.placeholder = "Username"
    usernameTextField.textContentType = .username
    usernameTextField.delegate = delegate
    containerView.addSubview(usernameTextField)
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: usernameLabel.topAnchor),
      usernameTextField.bottomAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
      usernameTextField.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 24),
      usernameTextField.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor,
        constant: -24
      ),
    ])
    addUnderlineForView(usernameTextField)

    // Country

    countryLabel.text = "Country"
    containerView.addSubview(countryLabel)
    countryLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      countryLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 24),
      countryLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 24
      ),
      countryLabel.widthAnchor.constraint(equalToConstant: 80),
      countryLabel.heightAnchor.constraint(equalToConstant: 80),
    ])

    countryPicker.dataSource = delegate
    countryPicker.delegate = delegate
    containerView.addSubview(countryPicker)
    countryPicker.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      countryPicker.topAnchor.constraint(equalTo: countryLabel.topAnchor),
      countryPicker.bottomAnchor.constraint(equalTo: countryLabel.bottomAnchor),
      countryPicker.leadingAnchor.constraint(equalTo: countryLabel.trailingAnchor, constant: 24),
      countryPicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
    ])
    addUnderlineForView(countryPicker)

    // Email

    emailLabel.text = "Email"
    containerView.addSubview(emailLabel)
    emailLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 24),
      emailLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 24
      ),
      emailLabel.widthAnchor.constraint(equalToConstant: 80),
    ])

    emailTextField.text = "samadams@fridaynight.com"
    emailTextField.placeholder = "Email"
    emailTextField.textContentType = .emailAddress
    emailTextField.delegate = delegate
    containerView.addSubview(emailTextField)
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailTextField.topAnchor.constraint(equalTo: emailLabel.topAnchor),
      emailTextField.bottomAnchor.constraint(equalTo: emailLabel.bottomAnchor),
      emailTextField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 24),
      emailTextField.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor,
        constant: -24
      ),
    ])
    addUnderlineForView(emailTextField)

    // Birthdate

    birthdateLabel.text = "Birthday"
    containerView.addSubview(birthdateLabel)
    birthdateLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      birthdateLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 24),
      birthdateLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 24
      ),
      birthdateLabel.widthAnchor.constraint(equalToConstant: 80),
    ])

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    birthdateDatePicker.setDate(dateFormatter.date(from: "1984-09-27")!, animated: false)
    birthdateDatePicker.datePickerMode = .date
    containerView.addSubview(birthdateDatePicker)
    birthdateDatePicker.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      birthdateDatePicker.topAnchor.constraint(equalTo: birthdateLabel.topAnchor),
      birthdateDatePicker.bottomAnchor.constraint(equalTo: birthdateLabel.bottomAnchor),
      birthdateDatePicker.leadingAnchor.constraint(equalTo: birthdateLabel.trailingAnchor, constant: 24),
      birthdateDatePicker.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor,
        constant: -24
      ),
    ])

    // Separator

    let detailsSeparatorView = UIView()
    containerView.addSubview(detailsSeparatorView)
    detailsSeparatorView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    detailsSeparatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      detailsSeparatorView.topAnchor.constraint(
        equalTo: birthdateLabel.bottomAnchor,
        constant: 24
      ),
      detailsSeparatorView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
      detailsSeparatorView.heightAnchor.constraint(equalToConstant: 1),
    ])

    // Change password

    changePasswordLabel.text = "Change Password (Optional)"
    changePasswordLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    containerView.addSubview(changePasswordLabel)
    changePasswordLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      changePasswordLabel.topAnchor.constraint(equalTo: detailsSeparatorView.bottomAnchor, constant: 24),
      changePasswordLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 24
      ),
    ])

    // Current password

    currentPasswordLabel.text = "Current"
    containerView.addSubview(currentPasswordLabel)
    currentPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      currentPasswordLabel.topAnchor.constraint(equalTo: changePasswordLabel.bottomAnchor, constant: 12),
      currentPasswordLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 24
      ),
      currentPasswordLabel.widthAnchor.constraint(equalToConstant: 80),
    ])

    currentPasswordTextField.text = nil
    currentPasswordTextField.placeholder = "Current Password"
    currentPasswordTextField.isSecureTextEntry = true
    currentPasswordTextField.textContentType = .password
    currentPasswordTextField.delegate = delegate
    containerView.addSubview(currentPasswordTextField)
    currentPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      currentPasswordTextField.topAnchor.constraint(equalTo: currentPasswordLabel.topAnchor),
      currentPasswordTextField.bottomAnchor.constraint(equalTo: currentPasswordLabel.bottomAnchor),
      currentPasswordTextField.leadingAnchor.constraint(equalTo: currentPasswordLabel.trailingAnchor, constant: 24),
      currentPasswordTextField.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor,
        constant: -24
      ),
    ])
    addUnderlineForView(currentPasswordTextField)

    // New password

    newPasswordLabel.text = "New"
    containerView.addSubview(newPasswordLabel)
    newPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      newPasswordLabel.topAnchor.constraint(equalTo: currentPasswordLabel.bottomAnchor, constant: 24),
      newPasswordLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 24
      ),
      newPasswordLabel.widthAnchor.constraint(equalToConstant: 80),
    ])

    newPasswordTextField.text = nil
    newPasswordTextField.placeholder = "New Password"
    newPasswordTextField.isSecureTextEntry = true
    newPasswordTextField.textContentType = .newPassword
    newPasswordTextField.delegate = delegate
    containerView.addSubview(newPasswordTextField)
    newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      newPasswordTextField.topAnchor.constraint(equalTo: newPasswordLabel.topAnchor),
      newPasswordTextField.bottomAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor),
      newPasswordTextField.leadingAnchor.constraint(equalTo: newPasswordLabel.trailingAnchor, constant: 24),
      newPasswordTextField.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor,
        constant: -24
      ),
    ])
    addUnderlineForView(newPasswordTextField)

    // Re-enter password

    reenterNewPasswordLabel.text = "Re-enter"
    containerView.addSubview(reenterNewPasswordLabel)
    reenterNewPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      reenterNewPasswordLabel.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor, constant: 24),
      reenterNewPasswordLabel.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 24
      ),
      reenterNewPasswordLabel.widthAnchor.constraint(equalToConstant: 80),
    ])

    reenterNewPasswordTextField.text = nil
    reenterNewPasswordTextField.placeholder = "Re-enter New Password"
    reenterNewPasswordTextField.isSecureTextEntry = true
    reenterNewPasswordTextField.textContentType = .newPassword
    reenterNewPasswordTextField.delegate = delegate
    containerView.addSubview(reenterNewPasswordTextField)
    reenterNewPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      reenterNewPasswordTextField.topAnchor.constraint(equalTo: reenterNewPasswordLabel.topAnchor),
      reenterNewPasswordTextField.bottomAnchor.constraint(equalTo: reenterNewPasswordLabel.bottomAnchor),
      reenterNewPasswordTextField.leadingAnchor.constraint(equalTo: reenterNewPasswordLabel.trailingAnchor, constant: 24),
      reenterNewPasswordTextField.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor,
        constant: -24
      ),
    ])
    addUnderlineForView(reenterNewPasswordTextField)
    
    // Register KVO

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow(notification:)),
      name:UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide(notification:)),
      name:UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    profileImageView.layer.cornerRadius = profileImageView.bounds.width * 0.5
    containerView.frame = CGRect(
      x: 0,
      y: 0,
      width: scrollView.safeAreaLayoutGuide.layoutFrame.width,
      height: reenterNewPasswordTextField.frame.maxY + 24
    )
    scrollView.contentSize = containerView.frame.size
  }

  // MARK: - Target Actions

  @objc public func profileImageChangeDidTap(_ sender: Any?) {
    delegate?.profileImageChangeDidTap()
  }

  // MARK: - KVO

  @objc func keyboardWillShow(notification:NSNotification){
    let userInfo = notification.userInfo!
    let keyboardFrame = convert(
      (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue,
      from: nil
    )

    var contentInset = scrollView.contentInset
    contentInset.bottom = keyboardFrame.height
    scrollView.contentInset = contentInset

    let contentOffset = CGPoint(
      x: 0,
      y: max(0, scrollView.contentSize.height - scrollView.bounds.height + keyboardFrame.height)
    )
    scrollView.setContentOffset(contentOffset, animated: true)
  }

  @objc func keyboardWillHide(notification:NSNotification){
    var contentInset = scrollView.contentInset
    contentInset.bottom = 0
    scrollView.contentInset = contentInset

    let contentOffset = CGPoint(
      x: 0,
      y: max(0, scrollView.contentSize.height - scrollView.bounds.height)
    )
    scrollView.setContentOffset(contentOffset, animated: true)
  }

  // MARK: - Helper

  func addUnderlineForView(_ targetView: UIView) {
    let underlineView = UIView()
    underlineView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    containerView.addSubview(underlineView)
    underlineView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      underlineView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 8),
      underlineView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor),
      underlineView.widthAnchor.constraint(equalTo: targetView.widthAnchor),
      underlineView.heightAnchor.constraint(equalToConstant: 1),
    ])
  }
}
