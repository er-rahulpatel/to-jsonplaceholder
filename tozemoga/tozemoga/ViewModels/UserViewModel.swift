//
//  UserViewModel.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-12.
//

import Foundation

class UserViewModel {
    private var apiController: ApiControllerProtocol
    private var user: User
    
    init(userId: Int, apiController: ApiControllerProtocol) {
        self.user = User(id: userId, name: "", username: "", email: "", address: nil, phone: "", website: "", company: nil)
        self.apiController = apiController
    }
    
    //To load posts from JSONPlaceholder API
    func loadUserInfo(completion: @escaping (Result<User, Error>) -> Void) {
        apiController.load(endpoint: .user(userId: user.id)) { [weak self] (result: Result<User, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.user = user
                completion(.success(user))
            case .failure(let error):
                // handle the error
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                break
            }
        }
    }
    
    func userInfo() -> User {
        return user
    }
}
