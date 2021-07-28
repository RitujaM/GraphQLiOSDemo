//
//  CustomInterceptor.swift
//  AppoloDemo
//
//  Created by Rituja Mahajan on 7/26/21.
//

import Foundation
import Apollo

class CustomInterceptor : ApolloInterceptor {
   
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        request.addHeader(name: "Authorization", value: "Bearer \(GraphQlClientProtocol.token)")
        
            print("request :\(request)")
            print("response :\(String(describing: response))")
        
            chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
        }
    
}
