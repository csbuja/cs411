//
//  ProfileView.swift
//  recipe
//
//  Created by Mochammad Dikra Prasetya on 2021/04/03.
//

import UIKit

public protocol ProfileViewDelegate: class {
  func editProfileButtonDidTap()
  func logoutButtonDidTap()
}

public class ProfileView: UIView {

  public weak var delegate: ProfileViewDelegate?

  lazy var countryNameToCodeDict: [String:String] = {
    var dict: [String:String] = [:]
    if let path = Bundle.main.path(forResource: "Countries", ofType: "plist") {
      let countriesList = NSArray(contentsOfFile: path) as? [[String:String]]
      countriesList?.forEach({ countryDict in
        dict[countryDict["name"]!] = countryDict["code"]!
      })
    }
    return dict
  }()

  let userModel: UserModel

  let profileImageView = UIImageView(image: UIImage(named: "avatar_placeholder"))
  let nameLabel = UILabel()
  let locationLabel = UILabel()
  let emailLabel = UILabel()
  let birthdayLabel = UILabel()

  let editProfileButton = LightButton()
  let logoutButton = DarkButton()

  required init(forUserModel userModel: UserModel) {
    self.userModel = userModel
    super.init(frame: .zero)

    backgroundColor = .white

    // Profile Image

    if let profileImage = userModel.profileImage {
      UserServices.sharedInstance.loadImage(
        forUserID: userModel.userID,
        url: profileImage
      ) { image in
        self.profileImageView.image = image
      }
    }

    addSubview(profileImageView)
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      profileImageView.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor,
        constant: 92
      ),
      profileImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      profileImageView.widthAnchor.constraint(
        equalTo: safeAreaLayoutGuide.widthAnchor,
        multiplier: 0.6
      ),
      profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
    ])
    profileImageView.clipsToBounds = true

    // Name

    nameLabel.text =  userModel.firstName + " " + userModel.lastName
    nameLabel.font = UIFont.systemFont(ofSize: 36)
    nameLabel.adjustsFontSizeToFitWidth = true
    nameLabel.numberOfLines = 1
    addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 48),
      nameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      nameLabel.widthAnchor.constraint(
        lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor,
        multiplier: 0.6
      ),
    ])

    // Location

    locationLabel.text = userModel.username + " " + countryFlag(fromCountryName: userModel.country)
    locationLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
    locationLabel.adjustsFontSizeToFitWidth = true
    locationLabel.numberOfLines = 1
    addSubview(locationLabel)
    locationLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
      locationLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      locationLabel.widthAnchor.constraint(
        lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor,
        multiplier: 0.6
      ),
    ])

    // Email

    emailLabel.text = userModel.email
    emailLabel.font = UIFont.systemFont(ofSize: 16)
    emailLabel.adjustsFontSizeToFitWidth = true
    emailLabel.numberOfLines = 1
    addSubview(emailLabel)
    emailLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
      emailLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      emailLabel.widthAnchor.constraint(
        lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor,
        multiplier: 0.6
      ),
    ])


    // Birthday

    birthdayLabel.text = "Birthday: " + userModel.birthdateString + " 🎉"
    birthdayLabel.font = UIFont.systemFont(ofSize: 16)
    birthdayLabel.adjustsFontSizeToFitWidth = true
    birthdayLabel.numberOfLines = 1
    addSubview(birthdayLabel)
    birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      birthdayLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
      birthdayLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      birthdayLabel.widthAnchor.constraint(
        lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor,
        multiplier: 0.6
      ),
    ])

    // Log out button

    logoutButton.setTitle("Log out", for: .normal)
    addSubview(logoutButton)
    logoutButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      logoutButton.bottomAnchor.constraint(
        equalTo: safeAreaLayoutGuide.bottomAnchor,
        constant: -16
      ),
      logoutButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      logoutButton.heightAnchor.constraint(equalToConstant: 44),
      logoutButton.widthAnchor.constraint(
        equalTo: safeAreaLayoutGuide.widthAnchor,
        multiplier: 0.9
      ),
    ])
    logoutButton.addTarget(self, action: #selector(logoutButtonDidTap(_:)), for: .touchUpInside)

    // Edit profile button

    editProfileButton.alpha = 0.2
    editProfileButton.isEnabled = false
    editProfileButton.setTitle("Edit Profile", for: .normal)
    addSubview(editProfileButton)
    editProfileButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      editProfileButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -8),
      editProfileButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      editProfileButton.heightAnchor.constraint(equalToConstant: 44),
      editProfileButton.widthAnchor.constraint(
        equalTo: safeAreaLayoutGuide.widthAnchor,
        multiplier: 0.9),
    ])
    editProfileButton.addTarget(
      self,
      action: #selector(editProfileButtonDidTap(_:)),
      for: .touchUpInside
    )
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    profileImageView.layer.cornerRadius = profileImageView.bounds.width * 0.5
  }

  // MARK: - Target Actions

  @objc func editProfileButtonDidTap(_ sender: Any?) {
    delegate?.editProfileButtonDidTap()
  }

  @objc func logoutButtonDidTap(_ sender: Any?) {
    delegate?.logoutButtonDidTap()
  }

  // MARK: - Helper

  func countryName(from countryCode: String) -> String {
    if let name = Locale.current.localizedString(forRegionCode: countryCode) {
      return name // Country name was found
    } else {
      return countryCode  // Country name cannot be found
    }
  }

  func countryFlag(fromCountryName countryName: String) -> String {
    let countryCode = countryNameToCodeDict[countryName] ?? "US"
    return countryFlag(fromCountryCode: countryCode)
  }

  func countryFlag(fromCountryCode countryCode: String) -> String {
      let base : UInt32 = 127397
      var s = ""
      for v in countryCode.uppercased().unicodeScalars {
          s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
      }
      return s
  }
}
