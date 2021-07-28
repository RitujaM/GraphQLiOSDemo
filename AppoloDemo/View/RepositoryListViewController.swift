//
//  RepositoryListViewController.swift
//  AppoloDemo
//
//  Created by Rituja Mahajan on 7/26/21.
//

import UIKit
import Apollo

class RepositoryListViewController: UIViewController {

    private var isListLoading = true
    let viewModel = RepoViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        viewModel.loadMoreReposIfTheyExist{ result in
            switch result{
            case.success(_):
                if self.viewModel.repositories.count == 0{
                    self.showErrorAlert(title: "No Data Found",
                        message: "Please enter a valid search string")
                }
                else{
                    self.reloadTable()
                }

            case.failure(_):
                self.showErrorAlert(title: "Network Error",
                    message: "Unable to connect to the server")
            }
        }
    }

    func reloadTable(){
        self.tableView.reloadData()
    }
    
    func showErrorAlert(title: String, message: String) {
      let alert = UIAlertController(title: title,
                                    message: message,
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(alert, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if(offSet > contentHeight - scrollView.frame.height * 4) && !self.isListLoading {
            //call api when its at the bottom and is not loading
            viewModel.loadMoreReposIfTheyExist(){result in
                switch result{
                case.success(_):
                    self.reloadTable()

                case.failure(let error):
                    self.showErrorAlert(title: "Network Error",
                        message: "Unable to connect to the server")
                        
                }
            }
            self.isListLoading = true
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//    }

    
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.viewModel.repositories.count
        }
        else{
            if self.viewModel.currentConnection?.hasNextPage == false {
                return 0
            } else {
                return 1
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepoListTableViewCell") as! RepoListTableViewCell
            let repo = self.viewModel.repositories[indexPath.row]
            cell.lblRepoName.text = repo.name
            cell.lblLoginName.text = repo.owner.login
            cell.lblStars.text = repo.stargazers.totalCount.description
            let url = URL(string: repo.owner.avatarUrl)!
            let data = try? Data(contentsOf: url)
            cell.imgView?.image = UIImage(data: data!)
            return cell
        }
        else{
            let loadCell = tableView.dequeueReusableCell(withIdentifier: "LoadingViewTableViewCell") as! LoadingViewTableViewCell
            if self.isListLoading{
                loadCell.activityIndicator.startAnimating()
                self.isListLoading = false
            }
            else{
                loadCell.activityIndicator.stopAnimating()
            }
            return loadCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 261
    }

}
