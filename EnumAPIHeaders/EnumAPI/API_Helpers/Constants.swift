//
//  Constants.swift
//  ProjectLightning
//
//  Created by oles on 10.10.2020.
//

import Foundation
import UIKit

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json"//"https://api.energylockapi.site/api"
        static let agreeementURL = "https://energylockapp.com/software-services-agreement/"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let newPassword = "new_password"
        static let email = "email"
        static let deviceId = "device_name"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let lastUpdateSince = "last_updates_since"
        static let page = "page"
        static let userId = "user_id"
        static let projectId = "project_id"
        static let elementId = "element_id"
        static let elementName = "element_name"
        static let elementType = "element_type"
        static let isSuperAdmin = "is_super_admin"
        static let role = "role"
        static let phone = "phone"
        static let companyName = "company_name"
        static let companyId = "company_id"
        static let name = "name"
        static let fileName = "file_name"
        static let isSuperAdminBlocked = "is_superadmin_blocked"
        static let width = "width"
        static let height = "height"
        static let note = "note"
        static let dateFrom = "date_from"
        static let dateTo = "date_to"
        static let description = "description"
        static let includeDeleted = "include_deleted"
        static let file = "file"
        static let fileId = "file_id"
        static let isPinned = "is_pinned"
        static let xCoordinate = "x_coordinate"
        static var yCoordinate = "y_coordinate"
        static let x = "x"
        static var y = "y"
        static var orientation = "orientation"
        static let tileId = "tile_id"
    }
    
    static let MainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    static let loader = MyLoader()
    
    static var DefaultProjectWidth = 2000
    static var DefaultProjectHeight = 1000
    
    static var MIN_CHARS_TO_SEARCH = 2
    static var ThrottlingInterval = 1.0
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
}

struct Message {
    static var BlankFirstNameMsg = "Please enter first name"
    static var BlankLastNameMsg = "Please enter last name"
    static var BlankEmailMsg = "Please enter email"
    static var BlankCompanyMsg = "Please enter company name"
    static var BlankProjectMsg = "Please enter project name"
    static var BlankPhoneMsg = "Please enter phone number"

    static var BlankProjectIdMsg = "Please select project"
    static var BlankRoleMsg = "Please select role"
    static var BlankComanyMsg = "Please select company"
    
    static var BlankFromDateMsg = "Please enter from Date"
    static var BlankToDateMsg = "Please enter to Date"

    static var BlankNoteMsg = "Please enter note"
    static var BlankUserMsg = "Please select user"
    static var BlankElementTypeMsg = "Please select element type"
    static var BlankElementNameMsg = "Please enter elementName"

    static var BlankOldPasswordMsg = "Please enter old password"
    static var BlankNewPasswordMsg = "Please enter new password"
    static var BlankConfirmPasswordMsg = "Please enter confirm password"
    static var PasswordNotMatchMsg = "Password and Confirm password are not matching."
    static var CPasswordNotMatchMsg = "New Password and Confirm password should be same."

    static var ValidEmailMsg = "Please enter valid email"

    static var NoNetworkMsg = "Please check your internet connection"
    static var NoInfoMsg = "No Information found"
}
