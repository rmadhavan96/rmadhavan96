//
//  NetworkManager.swift
//  Inzodiac_iOS
//
//  Created by Rohin Madhavan on 20/05/2022.
//

import Foundation

protocol NetworkManagerDelegate {
    func didUpdateWithData(createAccountArray: [String]?, type: FetchType)
    func didFailWithError(error: Error)
}

enum FetchType: String {
    case orientation = "v2/fetch_orientation"
    case gender = "v2/fetch_gender"
    case lookingFor = "v2/looking_relationship_type_fetch"
    case interestedIn = "v2/fetch_interested_in"
    
    static let allValues = [orientation, gender, lookingFor, interestedIn]
}

struct NetworkManager {
    
    let constants = Constants()
    var delegate: NetworkManagerDelegate?
    
    func fetchCreateAccountData(type: FetchType) {
        let urlString = "\(constants.baseURL)\(type.rawValue)"
        print(urlString)
        performRequest(with: urlString, type: type)
    }
    
    func performRequest(with urlString: String, type: FetchType) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    print(safeData)
                    if let _data = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWithData(createAccountArray: _data, type: type)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ createAccountData: Data) -> [String]? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CreateAccountData.self, from: createAccountData)
            let _data = decodedData.data
            print(_data)
            var createAccountArray: [String]?
            for item in _data {
                for _item in item {
                    if createAccountArray != nil {
                        createAccountArray?.append(_item.value)
                    } else {
                        createAccountArray = [_item.value]
                    }
                }
            }
            return createAccountArray
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func postRegistrationDetails(registrationResponseModel: CreateAccountResponseModel) {
        let url = URL(string: "\(constants.baseURL)v2/user_reg")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let jsonData = try encoder.encode(registrationResponseModel)
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
