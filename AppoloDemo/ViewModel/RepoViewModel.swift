//
//  ViewModel.swift
//  AppoloDemo
//
//  Created by Rituja Mahajan on 7/28/21.
//

import Foundation
import UIKit

class RepoViewModel {
    
    var repositories = [GetRepositoriesQuery.Data.Search.Edge.Node.AsRepository]() //Array used to store the result repositories
    var currentConnection : GetRepositoriesQuery.Data.Search.PageInfo? // used to store the current Page information. Used in pagination.
    
    func loadRepoList(from cursor: String?, completion: ((Result<Bool, Error>) -> Void)? = nil) {
        Network.shared.apollo
        .fetch(query: GetRepositoriesQuery(page: cursor)) { [weak self] result in

          guard let self = self else {
            return
          }

          switch result {
          case .success(let graphQLResult):
            
            if let repoConnection = graphQLResult.data?.search.edges {
                self.currentConnection = graphQLResult.data?.search.pageInfo
                //Append result respositories to array.
                repoConnection.forEach { edge in
                    guard let repository = edge?.node?.asRepository else { return }
                    self.repositories.append(repository)
                }
                completion!(Result.success(true))
            }
            
            if let errors = graphQLResult.errors {
                completion!(Result.failure(errors as! Error))
            }

          case .failure(let error):
            completion!(Result.failure(error))
          }
      }
    }
    
    func loadMoreReposIfTheyExist(completion: ((Result<Bool, Error>) -> Void)? = nil) {
        
       guard let connection = self.currentConnection else {
        //when you call the api first time
        self.repositories.removeAll()
        self.loadRepoList(from: nil){ result in
            switch result {
            case .failure(let error):
                completion!(Result.failure(error))

            case .success(_):
                completion!(Result.success(true))
            }
        }
        return
      }
        guard connection.hasNextPage else {
        return
      }
        self.loadRepoList(from: connection.endCursor){result in
            //when loading the next page
            switch result {
            case .failure(let error):
                completion!(Result.failure(error))

            case .success(_):
                completion!(Result.success(true))
            }
        }
    }
}
