//

import Foundation

class PostListPresenter {
    private let postListTableData: TableDataProtocol
    private let interactor: PostListInteractorInput
    
    private var presenters: [PostCardViewPresenter] = []
    private var title = "Публикации"
    
    weak var viewController: PostListViewControllerInput?
    
    init(
        postListTableData: TableDataProtocol,
        interactor: PostListInteractorInput
    ) {
        self.postListTableData = postListTableData
        self.interactor = interactor
    }
}

private extension PostListPresenter {
    func updateTitle() {
        viewController?.updateTitle(title)
    }
    
    func updatePostListCellPresenters() {
        postListTableData.updateCellPresenters(presenters)
        viewController?.reloadTable()
    }
}

extension PostListPresenter: PostListInteractorOutput {
    func updatePostListCellPresenters(_ presenters: [PostCardViewPresenter]) {
        self.presenters = presenters
        
        updatePostListCellPresenters()
    }
    
    func updateUserInfo(_ name: String, _ email: String) {
        viewController?.updateUserInfo(name, email)
    }
    
    func handleError(_ error: Error) {
        
    }
}

extension PostListPresenter: PostListViewControllerOutput {
    func viewIsReady() {
        updatePostListCellPresenters()
        updateTitle()
        
        interactor.requestPosts()
        interactor.requestUser()
    }
    
    func didSelectCell(with indexPath: IndexPath) {
        guard presenters.indices.contains(indexPath.row) else {
            return
        }
        
        let presenter = presenters[indexPath.row]
        
        print("Post:", presenter.post.title)
        
        //presenter.doSomething()
        
        //interactor.updatePost(presenter.post)
    }
}
