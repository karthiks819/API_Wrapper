//
//  APIRouter.swift
//  ProjectLightning
//
//  Created by oles on 10.10.2020.
//

import Foundation
import Alamofire
import UIKit

enum APIRouter: URLRequestConvertible {
    
    // User
    case login(email:String, password:String, deviceId: String)
    case logoutMe
    case logoutAll
    case getInfo(userId:String)
    case updateInfo(userId:String, firstName:String, lastName:String, email:String?, isSuperAdmin:String,companyName:String, phone:String)
    case changePassword(email:String, password:String, newPassword: String)
    case getTempPassword(email:String)
    // Projects
    case projects
    case updates(projectId: Int, since: Date)
    case projectInfo(projectId: Int)
    
    case projectCreate(projectName : String, companyId : Int, width : Int, height : Int)
    //Project Users
    case projectUsers(projectId: Int)
    
    //ProjectAssignUser
    case projectAssignUser(projectId: Int, email: String, role: String)
    
    //Project Delete User
    case projectRemoveUser(projectId: Int, userId: Int)
    
    //ProjectUpdate
    case projectUpdate(projectId: Int, projectName: String)
    
    //ProjectCanvasUpdate
    case projectCanvasUpdate(projectId: Int, projectName: String?, width : CGFloat, height : CGFloat)
    
    //ProjectDisableEnable
    case projectDisableEnable(projectId : Int, isSuperAdminBlocked : Int)
    
    //ProjectGetBackgroundDrawings
    case projectGetBackgroundDrawings(projectId : Int)
    
    // Activity Logs
    case activity(page: Int, projectId: Int, userId: Int?, elementId: String?, elementName: String?, elementType: String?, note: String?, dateFrom: String?, dateTo: String?)
    
    //Locks Search
    case lockSearch(projectId : Int, page: Int, includeDeleted: Int, description : String?)
    
    // Storage
    case storage(id: Int)
    
    //Create User
    case createUser(firstName : String, lastName : String, email : String, projectId : Int, role : String, isSuperAdmin : String, phone : String, companyName : String)
    
    //Get All Companies
    case getAllCompanies
    
    //Create Company
    case createCompany(name : String)
    
    //Company Update
    case updateCompany(companyId : Int, companyName : String)
    
    //Company Delete
    case deleteCompany(companyId : Int)
    
    //GET getParticulerFilesInfo API
    case getParticulerFilesInfo(fileID: Int)
    
    //background_drawing API
    case createBackgroundDrawing(fileId:Int, fileUrl : String?,x:Double,y:Double,fileName:String)
    //ProjectUpdate
    
    // @@@@@@@@@@@@ IS PINNED @@@@@@@@@@@@@@@@@@@@@@
    case didTapPinBG(ispinned:Int, fileID:Int)
    
    // @@@@@@@@@@@@ IS DELETE @@@@@@@@@@@@@@@@@@@@@@@@@@@
    case delteButton(id:Int)
    
    
    //MARK:- UPDATE X,Y coordinates on BG Draws
    case updateCoordinatesAfterMoving(x: Int, y: Int, fileID: Int)
    //MARK:- UPDATE height, width coordinates on BG Draws
    case updateHeightWidthAfterResizing(height: Float, width: Float, fileID: Int)
    //MARK:- Create Tiles API
    case createTile(name: String, x: Int, y: Int)
    //MARK:- Update Tiles API
    case updateTile(name: String, id:Int)
    //MARK:- Delete Tiles API
    case deleteATile(id: Int)
    
    //RSS Feed
    case getRSSFeedPosts(posts:Int)
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login, .logoutMe, .logoutAll, .updates, .activity, .changePassword, .createUser,.getTempPassword, .projectCreate, .createCompany, .lockSearch,.createBackgroundDrawing, .createTile:
            return .post
        case .getInfo, .projects, .projectInfo, .storage, .projectUsers, .getAllCompanies, .projectGetBackgroundDrawings(_),.getParticulerFilesInfo(_), .getRSSFeedPosts(_):
            return .get
            
        // IS PINNED , FILEID HTTP METHOD
        
        
        case .updateInfo, .projectAssignUser(_, _, _), .updateCompany(_, _), .projectUpdate(_, _), .projectCanvasUpdate, .didTapPinBG(ispinned:_, fileID:_), .updateCoordinatesAfterMoving(x:
                                                                                                                                                                                            _, y: _, fileID: _), .updateHeightWidthAfterResizing(height: _, width: _, fileID: _), .updateTile(name: _, id: _):
            return .put
        case .projectRemoveUser, .deleteCompany, .deleteATile:
            return .delete
        case .projectDisableEnable:
            return .patch
            
            
        // DELETE BUTTON
        case .delteButton(id: _):
            return.delete
        }
    }
    
    
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/user/token"
        case .logoutMe:
            return "/user/logout_me"
        case .logoutAll:
            return "/user/logout_all"
        case .changePassword:
            return "/user/password/new"
        case .getTempPassword:
            return "/user/password/temp"
        case .getInfo(let userId):
            return "/user/\(userId)"
        case .updateInfo(let userId, _, _, _, _, _, _):
            return "/user/\(userId)"
        case .projects :
            return "/projects"
        case .projectCreate :
            return "/projects"
        case .updates(let projectId, _):
            return "/updates/\(projectId)"
        case .projectInfo(let projectId):
            return "/projects/\(projectId)"
        case .projectUsers(let projectId):
            return "/projects/users/\(projectId)"
        case .projectAssignUser(_, _, _):
            return "/projects/add_user"
        case .projectRemoveUser:
            return "/projects/remove_user"
        case .projectUpdate(let projectId, _):
            return "/projects/\(projectId)"
        case .projectCanvasUpdate(let projectId, _, _, _):
            return "/projects/\(projectId)"
        case .projectDisableEnable(let projectId, _):
            return "/projects/block/\(projectId)"
        case .projectGetBackgroundDrawings(let projectId):
            return "/projects/get_background_files_info/\(projectId)"
        case .activity(_, _, _, _, _, _, _, _, _):
            return "/activity_logs/project"
        case .lockSearch(_, _, _, _):
            return "/locks/search"
        case .storage(let storageId):
            return "/storage/\(storageId))"
        case .createUser:
            return "/user"
        case .createCompany:
            return "/companies"
        case .getAllCompanies:
            return "/companies"
        case .updateCompany(let companyId, _):
            return "companies/\(companyId)"
        case .deleteCompany(let companyId):
            return "companies/\(companyId)"
        case .getParticulerFilesInfo(let fileID):
            return "/background_drawings/\(fileID)"
        case .createBackgroundDrawing(_,_,_,_,_):
            return "background_drawings"
        case .updateCoordinatesAfterMoving(x: _, y: _, fileID: let id):
            return "/background_drawings/\(id)"
        case .updateHeightWidthAfterResizing(height: _, width: _, fileID: let id):
            return "/background_drawings/\(id)"
            
            
        // PATH OF BACKGROUND SENDING FILEID
        
        case .didTapPinBG(_, let fileID):
            return "/background_drawings/\(fileID)"
            
        case .createTile(name: _, x: _, y: _):
            return "/tiles"
            
        case .updateTile(name: _, id: let id):
            return "/tiles/\(id)"
            
        case .deleteATile(id: let id):
            return "/tiles/\(id)"
        //        case .projectUpdate(let projectId, _):
        //            return "/projects/\(projectId)"
        
        // DELETE BUTTON ID
        
        case .delteButton(id: let id):
            return "/background_drawings/\(id)"
            
            
            
        case .getRSSFeedPosts(let id):
            return ""
        }
    }
    
    
    
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password, let deviceId):
            return [Constants.APIParameterKey.email: email,
                    Constants.APIParameterKey.password: password,
                    Constants.APIParameterKey.deviceId: deviceId]
        case .changePassword(let email, let password, let newPassword):
            return [Constants.APIParameterKey.email: email,
                    Constants.APIParameterKey.password: password,
                    Constants.APIParameterKey.newPassword: newPassword]
        case .getTempPassword(let email):
            return [Constants.APIParameterKey.email: email]
        case .updateInfo(_,let firstName, let lastName, let email, let isSuperAdmin, let companyName, let phone):
            var paramDict = Parameters()
            if email == nil {
                paramDict = [Constants.APIParameterKey.firstName: firstName,
                             Constants.APIParameterKey.lastName: lastName,
                             Constants.APIParameterKey.isSuperAdmin: isSuperAdmin, Constants.APIParameterKey.companyName: companyName, Constants.APIParameterKey.phone: phone]
            }
            else {
                paramDict = [Constants.APIParameterKey.firstName: firstName,
                             Constants.APIParameterKey.lastName: lastName,
                             Constants.APIParameterKey.email: email ?? "", Constants.APIParameterKey.isSuperAdmin: isSuperAdmin, Constants.APIParameterKey.companyName: companyName, Constants.APIParameterKey.phone: phone]
            }
            return paramDict
        case .logoutMe, .logoutAll, .getInfo(_), .projects, .projectInfo(_), .storage(_), .projectUsers(_), .getAllCompanies, .deleteCompany, .projectGetBackgroundDrawings(_),.getParticulerFilesInfo(_):
            return nil
        case .projectCreate(let projectName,let companyId,let width, let height):
            return [Constants.APIParameterKey.name: projectName,
                    Constants.APIParameterKey.companyId: companyId,
                    Constants.APIParameterKey.width: width, Constants.APIParameterKey.height: height]
        case .projectRemoveUser(let projectId, let userId):
            return [Constants.APIParameterKey.userId: userId,
                    Constants.APIParameterKey.projectId: projectId]
        case .projectAssignUser(let projectId, let email, let role):
            return [Constants.APIParameterKey.email: email,
                    Constants.APIParameterKey.projectId: projectId,Constants.APIParameterKey.role: role]
        case .projectDisableEnable(_, let isSuperAdminBlocked):
            return [Constants.APIParameterKey.isSuperAdminBlocked : isSuperAdminBlocked]
        case .projectCanvasUpdate(_, let projectName, let width, let height) :
            var paramDict = Parameters()
            if projectName == nil {
                paramDict = [Constants.APIParameterKey.width: width, Constants.APIParameterKey.height: height]
            }
            else {
                paramDict = [Constants.APIParameterKey.name: projectName ?? "",
                             Constants.APIParameterKey.width: width, Constants.APIParameterKey.height: height]
            }
            return paramDict
        case .updates(_, let since):
            return [Constants.APIParameterKey.lastUpdateSince: since]
        case .activity(let page, let projectId, let userId, let elementId, let elementName, let elementType, let note, let dateFrom, let dateTo):
            var params:[String:Any] = [Constants.APIParameterKey.page: page,
                                       Constants.APIParameterKey.projectId: projectId]
            if let eid = elementId {
                params[Constants.APIParameterKey.elementId] = eid
            }
            if let elType = elementType {
                params[Constants.APIParameterKey.elementType] = elType
            }
            if let uid = userId {
                params[Constants.APIParameterKey.userId] = uid
            }
            if let elName = elementName {
                params[Constants.APIParameterKey.elementName] = elName
            }
            if let activityNote = note {
                params[Constants.APIParameterKey.note] = activityNote
            }
            if let dFrom = dateFrom {
                params[Constants.APIParameterKey.dateFrom] = dFrom
            }
            if let dTo = dateTo {
                params[Constants.APIParameterKey.dateTo] = dTo
            }
            return params
        case .lockSearch(let projectId, let page, let includeDeleted, let description):
            var paramDict = Parameters()
            if description == nil {
                paramDict = [Constants.APIParameterKey.projectId: projectId,
                             Constants.APIParameterKey.page: page,
                             Constants.APIParameterKey.includeDeleted: includeDeleted]
            }
            else {
                paramDict = [Constants.APIParameterKey.projectId: projectId,
                             Constants.APIParameterKey.page: page,
                             Constants.APIParameterKey.includeDeleted: includeDeleted, Constants.APIParameterKey.description: description]
            }
            return paramDict
        case .createUser(let firstName, let lastName, let email, let projectId, let role, let isSuperAdmin, let phone, let companyName):
            return [Constants.APIParameterKey.firstName: firstName,
                    Constants.APIParameterKey.lastName: lastName,
                    Constants.APIParameterKey.email: email,Constants.APIParameterKey.projectId: projectId,Constants.APIParameterKey.isSuperAdmin: isSuperAdmin, Constants.APIParameterKey.role: role,Constants.APIParameterKey.phone: phone, Constants.APIParameterKey.companyName: companyName]
        case .createCompany(let name):
            return [Constants.APIParameterKey.name : name]
        case .updateCompany(_, let companyName):
            return [Constants.APIParameterKey.name : companyName]
        case .projectUpdate(_, let projectName):
            return [Constants.APIParameterKey.name : projectName]
            
        // PARAMETERS OF PINTAP
        
        case .didTapPinBG(let ispinned, fileID: _):
            return nil
            
            
            
        // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        
        case .updateCoordinatesAfterMoving(x: let x, y: let y, fileID: _):
            return nil
            
        case .updateHeightWidthAfterResizing(height: let height, width: let width, fileID: _):
            return nil
            
        case .createTile(name: let name, x: let x, y: let y):
            return [Constants.APIParameterKey.x : x,Constants.APIParameterKey.y : y, Constants.APIParameterKey.projectId: 7, Constants.APIParameterKey.name: name]
            
        case .updateTile(name: let name, id: _):
            return [Constants.APIParameterKey.name : name]
        case .delteButton(_):
            
            return nil
        case .deleteATile(id: _):
            return nil
        case .createBackgroundDrawing(fileId: let fileId, fileUrl: let fileUrl, x: let x, y: let y, fileName: let fileName):
            return nil
        
            
        case   .getRSSFeedPosts(posts: _):
            return nil
        }
        
    }
    
    private var auth: Bool {
        get {
            switch self {
            case .login(_, _, _), .updates, .changePassword(_, _, _), .getTempPassword(_), .getRSSFeedPosts(posts: _):
                return false
            case .logoutMe,.logoutAll,.projects, .projectInfo, .activity(_, _, _, _, _, _, _, _, _), .storage(_), .updateInfo(_, _, _, _, _, _, _), .getInfo(_), .projectUsers(_), .projectRemoveUser(_, _),.projectAssignUser(_, _, _), .createUser, .updateCompany, .projectUpdate, .projectDisableEnable, .getAllCompanies, .projectCreate(_,  _, _, _), .deleteCompany(_), .createCompany, .projectCanvasUpdate, .lockSearch(_, _, _, _), .projectGetBackgroundDrawings(_),.getParticulerFilesInfo(_), .createBackgroundDrawing(_,_,_,_,_),.didTapPinBG(ispinned: _, fileID: _), .updateCoordinatesAfterMoving(x: _, y: _, fileID: _), .updateHeightWidthAfterResizing(height: _, width: _, fileID: _), .createTile(name: _, x: _, y: _), .updateTile(name: _, id: _), .delteButton(id: _), .deleteATile:
                return true
                
            }
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url =
            try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if auth {
            let token:String? = ""
            //            if let token = Preferences.token {
            if token != nil {
                urlRequest.setValue("Bearer \(token ?? "")", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            } else {
                //throw AFError.urlRequestValidationFailed(reason: )
            }
        }
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
    // MARK: MultipartFormData
    var multipartFormData: MultipartFormData {
        let multipartFormData = MultipartFormData()
        switch self {
        case .createBackgroundDrawing(_, let fileUrl, let x, let y, let fileName):
            let bgd_xCord = Double(String(format: "%0.2f", x)) ?? 0.0
            let bgd_yCord = Double(String(format: "%0.2f", y)) ?? 0.0
            
            //Project Id
            multipartFormData.append("\(String(describing: 1))".data(using: .utf8)!, withName: Constants.APIParameterKey.projectId)
            
            //Name
            multipartFormData.append("\(String(describing: fileName))".data(using: .utf8)!, withName: Constants.APIParameterKey.name)
            
            //FileName
            multipartFormData.append("\(String(describing: fileName))".data(using: .utf8)!, withName: Constants.APIParameterKey.fileName)
            
            //isPinned
            multipartFormData.append("0".data(using: .utf8)!, withName: Constants.APIParameterKey.isPinned)
            
            //Width
            multipartFormData.append("500".data(using: .utf8)!, withName: Constants.APIParameterKey.width)
            
            //Height
            multipartFormData.append("500".data(using: .utf8)!, withName: Constants.APIParameterKey.height)
            
            //xCord
            multipartFormData.append("\(bgd_xCord)".data(using: .utf8)!, withName: Constants.APIParameterKey.xCoordinate)
            
            //yCord
            multipartFormData.append("\(bgd_yCord)".data(using: .utf8)!, withName: Constants.APIParameterKey.yCoordinate)
            
            //orientation
            multipartFormData.append("0".data(using: .utf8)!, withName: Constants.APIParameterKey.orientation)
            
            //File
            if fileUrl != nil {
                if let url = fileUrl {
                    let data = (try? Data(contentsOf: URL(string: url)!))!
                    multipartFormData.append(data, withName: "file", fileName: "bgd.pdf", mimeType: "application/pdf")
                }
            }
            
        default: ()
        }
        return multipartFormData
    }
}
