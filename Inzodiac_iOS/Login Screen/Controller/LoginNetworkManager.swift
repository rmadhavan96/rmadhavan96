//
//  LoginNetworkManager.swift
//  Inzodiac_iOS
//
//  Created by Rohin Madhavan on 24/05/2022.
//

import Foundation

struct LoginNetworkManager {
    let constants = Constants()
    
    func postLoginDetails(loginResponseModel: LoginResponseModel) {
        let url = URL(string: "\(constants.baseURL)v2/user_email_login")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let jsonData = try encoder.encode(loginResponseModel)
            print(String(data: jsonData, encoding: .utf8)!)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {return}
                do{
                    let response =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(response)
                }catch {
                    print(error)
                }
                
            }
            
            task.resume()
        } catch {
            //handle error
            print(error)
        }
        
    }
}
