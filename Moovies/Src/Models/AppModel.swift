//
//  AppModel.swift
//  Moovies
//
//  Created by Thant Sin Htun on 11/06/2023.
//

import Foundation
class AppModel {
    static let shared = AppModel()
    
    func fetchData() -> [User]{
        var users = [User]()
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        URLSession.shared.dataTask(with: url){ data,response,error in
            guard let data = data else {return}
            do{
                let decodedData = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    users = decodedData
                    
                    print("count in model",users.count)
                }
            }catch{
                print(error)
            }
        }
        .resume()
        return users
    }
}
struct User: Codable, Identifiable {
    let id: Int
    let name: String
}
