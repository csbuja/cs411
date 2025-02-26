//
//  UserServices.swift
//  recipe
//
//  Created by Mochammad Dikra Prasetya on 2021/05/12.
//

import Foundation
import UIKit

public class UserServices {

  static let sharedInstance = UserServices()
  static let endpoint = "http://44.192.111.170"

  var userModelCache: [Int:UserModel] = [:]
  var profileImageCache: [Int:UIImage] = [:]

  public func getUserID(
    forUsername username: String,
    password: String,
    completion: @escaping (Int?) -> Void
  ) {
    RESTAPIHelper.requestGet(
      withUrl: URL(string: "\(Self.endpoint)/login")!,
      params: ["username" : username, "password" : password]
    ) { result in

      var userID: Int? = nil

      if let dict = result?["result"] as? [String:Any?] {
        userID = dict["uid"] as? Int
      }

      DispatchQueue.main.async {
        completion(userID)
      }
    }
  }

  public func registerNewUser(
    withUsername username: String,
    firstName: String,
    lastName: String,
    email: String,
    country: String,
    birthdate: Date,
    password: String,
    completion: @escaping (String?) -> Void
  ) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let birthdateString = dateFormatter.string(from: birthdate)

    RESTAPIHelper.requestPut(
      withUrl: URL(string: "\(Self.endpoint)/register")!,
      params: [
        "user_name" : username,
        "first_name" : firstName,
        "last_name" : lastName,
        "email" : email,
        "country" : country,
        "birth_date" : birthdateString,
        "password" : password,
      ]
    ) { result in
      let errorMessage = result?["result"] as? String
      DispatchQueue.main.async {
        completion(errorMessage)
      }
    }
  }

  public func getUserProfile(
    forUserID userID: Int,
    completion: @escaping (UserModel?) -> Void
  ) {
    if let userModel = userModelCache[userID] {
      completion(userModel)
      return
    }
    
    RESTAPIHelper.requestGet(
      withUrl: URL(string: "\(Self.endpoint)/user")!,
      params: ["user_id" : userID]
    ) { result in
      var userModel: UserModel?

      if let userModelDictList = result?["result"] as? [[String:Any?]] {
        userModelDictList.forEach { userModelDict in
          if let username = userModelDict["user_name"] as? String,
             let firstName = userModelDict["first_name"] as? String,
             let lastName = userModelDict["last_name"] as? String,
             let email = userModelDict["email"] as? String,
             let country = userModelDict["country"] as? String,
             let birthdateString = userModelDict["birth_date"] as? String {

            var profileImage: URL? = nil

            if let profileImageString = userModelDict["profile_image"] as? String {
              profileImage = URL(string: profileImageString)
            }

            let birthdateComponents = birthdateString.components(separatedBy: " ")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.locale = Locale(identifier: "en")
            let birthdate = dateFormatter.date(
              from:
                birthdateComponents[1] + " " + birthdateComponents[2] + " " + birthdateComponents[3]
            )

            userModel = UserModel(
              userID: userID,
              username: username,
              firstName: firstName,
              lastName: lastName,
              email: email,
              country: country,
              birthdate: birthdate!,
              profileImage: profileImage
            )

            self.userModelCache[userID] = userModel
          }
        }
      }

      DispatchQueue.main.async {
        completion(userModel)
      }
    }
  }

  public func searchUsername(
    withQuery query: String,
    completion: @escaping ([SearchUsernameModel]) -> Void
  ) {
    RESTAPIHelper.requestGet(
      withUrl: URL(string: "\(Self.endpoint)/search/user")!,
      params: ["partial_user_name" : query]
    ) { result in
      var searchUsernameModels: [SearchUsernameModel] = []

      if let searchUsernameModelDictList = result?["result"] as? [[String:Any]] {
        searchUsernameModelDictList.forEach { searchUsernameModelDict in
          if let userID = searchUsernameModelDict["uid"] as? Int,
             userID != AccountManager.sharedInstance.currentUserID,
             let username = searchUsernameModelDict["user_name"] as? String {
            searchUsernameModels.append(SearchUsernameModel(userID: userID, username: username))
          }
        }
      }

      DispatchQueue.main.async {
        completion(searchUsernameModels)
      }
    }
  }

  public func loadImage(
    forUserID userID: Int,
    url: URL,
    completion: @escaping (UIImage?) -> Void
  ) {
    if let image = profileImageCache[userID] {
      completion(image)
      return
    }

    DispatchQueue.global().async {
      let image = try? UIImage(data: Data(contentsOf: url))

      DispatchQueue.main.async {
      self.profileImageCache[userID] = image
        completion(image)
      }
    }
  }
}
