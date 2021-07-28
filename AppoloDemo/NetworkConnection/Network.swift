//
//  Network.swift
//  AppoloDemo
//
//  Created by Rituja Mahajan on 7/26/21.
//

import Apollo
import Foundation

class Network {
  static let shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {
            let client = URLSessionClient()
               let cache = InMemoryNormalizedCache()
               let store = ApolloStore(cache: cache)
               let provider = NetworkInterceptorProvider(client: client, store: store)
               let url = URL(string: "https://api.github.com/graphql")!
               let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                            endpointURL: url)
               return ApolloClient(networkTransport: transport, store: store)
        }()
}


