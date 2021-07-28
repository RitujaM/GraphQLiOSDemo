# GraphiOSDemo

A Small iPhone Application which gets repositories based on the search string. The name of the repo, owner login name, owner Avatar and number of starts. The results are displayed with pagination. 
The application interfaces with Github V4 API. It Performs a search and displays a result.
The application follows a MVVM design pattern.

Setup Steps:
1. Installed Apollo iOS Client using Cocoa-pods.
2. Created a Personal Access Token in GitHub
3. Update the Generated token in GraphQlClientProtocol.swift
4. Run script to download the GraphQL schema and build
5. Added query in the GetRepoList.graphql file.
6. Run Script to generate the Api.swift file 
7. Created an Apollo client with Network.swift file and added authorization with the generated GitHub token, build.
8. In the viewModel file add an array for storing list of repositories.
9. Updated the array in loadRepoList() method.
10. Added paginaition using scrollviewdidscrollview() method to check the offset and get more repos if its at the bottom of the table 

Future Scope:
1. The searchString will be an input for the user
2. The user will be able to sort the repositories list by name, Login name and number of stars.
3. Go to repository detail
        1. About
        2. Readme
        3. Packages
        4. Contributors
        5. Languages
