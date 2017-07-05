////
////  WebService.swift
////  Vitrinova
////
////  Created by Mehmet Salih Aslan on 19/10/2016.
////  Copyright © 2016 Mobillium. All rights reserved.
////
//
//import Alamofire
//
//private var baseUrl = URL_BASE
//
//class WebService {
//    
//    class func request<T: Mappable>(uri: String, method: HTTPMethod, parameters: [String: Any]?, success: @escaping (T) -> Void, failure: @escaping (ResponseError) -> Void) {
//        
//        let url = "\(baseUrl)\(uri)"
//        
//        // Original URL request
//        let path = URL(string: url)!.path
//        Print.write("Path: \(path)")
//        Print.write("Parameters: \(parameters)")
//        
//        
//        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: generateHeaders())
//            .validate()
//            .responseJSON { response in
//                
////                let request = response.request!
////                let path = request.url?.path
////                let params = request.url?.query
//                
//                // Success
//                if response.result.isSuccess {
//                    Print.write("\nResponse Data: \(response.result.value!)")
//                    
//                    // JSON Data
//                    if let object = Mapper<T>().map(JSON: response.result.value as! [String: Any]) {
//                        success(object)
//                        return
//                    }
//                    Print.write("\nBuraya girmemeli")
//                }
//                
//                // Failure
//                if response.result.isFailure {
//                    if let value = response.data {
//                        let responseData = String.init(data: value, encoding: String.Encoding.utf8)
//                        
//                        Print.write("\nResponse Data: \(responseData)")
//                        if let error = Mapper<ResponseError>().map(JSONString: responseData!) {
//                            handleError(statusCode: response.response?.statusCode, error: error, failure: failure)
//                            return
//                        }
//                        
//                    }
//                    
//                    if let error = response.result.error {
//                        handleError(statusCode: response.response?.statusCode, error: ResponseError(error: error.localizedDescription, code: "unknown.error"), failure: failure)
//                        return
//                    }
//                    
//                    Print.write("\nBuraya girmemeli")
//                }
//        }
//    }
//    
//    class func request<T: Mappable>(uri: String, method: HTTPMethod, parameters: [String: Any]?, success: @escaping ([T]) -> Void, failure: @escaping (ResponseError) -> Void) {
//        
//        let url = "\(baseUrl)\(uri)"
//        
//        // Original URL request
//        Print.write("\nRequest URL: \(url)")
//        Print.write("\nParameters: \(parameters)")
//        
//        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: generateHeaders())
//            .validate()
//            .responseJSON { response in
//                
//                // Success
//                if response.result.isSuccess {
//                    Print.write("\nResponse Data: \(response.result.value!)")
//                    
//                    // JSON Data
//                    if let object = Mapper<T>().mapArray(JSONArray: response.result.value as! [[String : Any]]) {
//                        success(object)
//                        return
//                    }
//                    Print.write("\nBuraya girmemeli")
//                }
//                
//                // Failure
//                if response.result.isFailure {
//                    if let value = response.data {
//                        let responseData = String.init(data: value, encoding: String.Encoding.utf8)
//                        
//                        Print.write("\nResponse Data: \(responseData)")
//                        if let error = Mapper<ResponseError>().map(JSONString: responseData!) {
//                            handleError(statusCode: response.response?.statusCode, error: error, failure: failure)
//                            return
//                        }
//                        
//                    }
//                    
//                    if let error = response.result.error{
//                        handleError(statusCode: response.response?.statusCode, error: ResponseError(error: error.localizedDescription, code: "unknown.error"), failure: failure)
//                        return
//                    }
//                    
//                    Print.write("\nBuraya girmemeli")
//                }
//        }
//    }
//    
//    class func upload<T: Mappable>(uri: String, method: HTTPMethod, multiPartData: MultipartFormData, success: @escaping (T) -> Void, failure: @escaping (ResponseError) -> Void) {
//        
//        let url = "\(baseUrl)\(uri)"
//        
//        // Original URL request
//        Print.write("\nRequest URL: \(url)")
//
//        Alamofire.upload(multipartFormData: { (multiPartData) in
//            
//        }, usingThreshold: UInt64(), to: url, method: method, headers: generateHeaders(), encodingCompletion: { (result) in
//            switch result {
//            case .success(let request, _, _):
//                request.validate().responseJSON(completionHandler: { (response) in
//                    // Success
//                    if response.result.isSuccess {
//                        Print.write("\nResponse Data: \(response.result.value!)")
//                        
//                        // JSON Data
//                        if let object = Mapper<T>().map(JSON: response.result.value as! [String: Any]) {
//                            success(object)
//                            return
//                        }
//                        Print.write("\nBuraya girmemeli")
//                    }
//                    
//                    // Failure
//                    if response.result.isFailure {
//                        if let value = response.data {
//                            let responseData = String.init(data: value, encoding: String.Encoding.utf8)
//                            
//                            Print.write("\nResponse Data: \(responseData)")
//                            if let error = Mapper<ResponseError>().map(JSONString: responseData!) {
//                                handleError(statusCode: response.response?.statusCode, error: error, failure: failure)
//                                return
//                            }
//                            
//                        }
//                        
//                        if let error = response.result.error {
//                            handleError(statusCode: response.response?.statusCode, error: ResponseError(error: error.localizedDescription, code: "unknown.error"), failure: failure)
//                            return
//                        }
//                        
//                        Print.write("\nBuraya girmemeli")
//                    }
//                })
//                return
//            case .failure(let error):
//                handleError(statusCode: 0, error: ResponseError(error: error.localizedDescription, code: "unknown.error"), failure: failure)
//                return
//            }
//
//        })
//        
//    }
//    
//    class func upload<T: Mappable>(uri: String, method: HTTPMethod, parameters: [String: Any], success: @escaping (T) -> Void, failure: @escaping (ResponseError) -> Void) {
//        
//        let url = "\(baseUrl)\(uri)"
//        
//        var currentMethod = method
//        
//        switch method {
//        case .put:
//            currentMethod = .post
//            break
//        default:
//            break
//        }
//        
//        // Original URL request
//        Print.write("\nRequest URL: \(url)")
//        
//        Alamofire.upload(multipartFormData: { (data) in
//            if method == .put {
//                data.append("put".data(using: String.Encoding.utf8)!, withName: "_method")
//            }
//            for (key, value) in parameters {
//                if let value = value as? String {
//                    data.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                }
//                else if let value = value as? Data {
//                    data.append(value, withName: key, fileName: "\(key).jpg", mimeType: "image/jpeg")
//                }
//                else {
//                    assertionFailure("Beklenmedik bir değer geldi.")
//                }
//            }
//        }, usingThreshold: UInt64(), to: url, method: currentMethod, headers: generateHeaders(), encodingCompletion: { (result) in
//            switch result {
//            case .success(let request, _, _):
//                request.validate().responseJSON(completionHandler: { (response) in
//                    // Success
//                    if response.result.isSuccess {
//                        Print.write("\nResponse Data: \(response.result.value!)")
//                        
//                        // JSON Data
//                        if let object = Mapper<T>().map(JSON: response.result.value as! [String: Any]) {
//                            success(object)
//                            return
//                        }
//                        Print.write("\nBuraya girmemeli")
//                    }
//                    
//                    // Failure
//                    if response.result.isFailure {
//                        if let value = response.data {
//                            let responseData = String.init(data: value, encoding: String.Encoding.utf8)
//                            
//                            Print.write("\nResponse Data: \(responseData)")
//                            if let error = Mapper<ResponseError>().map(JSONString: responseData!) {
//                                handleError(statusCode: response.response?.statusCode, error: error, failure: failure)
//                                return
//                            }
//                            
//                        }
//                        
//                        if let error = response.result.error {
//                            handleError(statusCode: response.response?.statusCode, error: ResponseError(error: error.localizedDescription, code: "unknown.error"), failure: failure)
//                            return
//                        }
//                        
//                        Print.write("\nBuraya girmemeli")
//                    }
//                })
//                return
//            case .failure(let error):
//                handleError(statusCode: 0, error: ResponseError(error: error.localizedDescription, code: "unknown.error"), failure: failure)
//                return
//            }
//            
//        })
//        
//        
//    }
//    
//    class func handleError(statusCode: Int?, error: ResponseError, failure: @escaping (ResponseError) -> Void) {
//        if statusCode != nil && statusCode == 403 {
//            Auth.logOut()
//        }
//        failure(error)
//    }
//    
//    class func generateHeaders() -> [String:String]? {
//        if let auth = Auth.current() {
//            return ["X-Mobillium-Token": auth.token!]
//        }
//        return nil
//    }
//    
//}
//
