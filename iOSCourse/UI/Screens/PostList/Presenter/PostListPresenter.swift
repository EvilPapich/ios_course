//

import Foundation

class PostListPresenter {
    private let postListTableData: TableDataProvider<PostCardViewPresenter>
    private let interactor: PostListInteractorInput
    
    private var presenters: [PostCardViewPresenter] = []
    private var title = "Публикации"
    
    weak var viewController: PostListViewControllerInput?
    
    init(
        postListTableData: TableDataProvider<PostCardViewPresenter>,
        interactor: PostListInteractorInput
    ) {
        self.postListTableData = postListTableData
        self.interactor = interactor
        
        interactor.requestPosts()
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
    
    func handleError(_ error: Error) {
        
    }
}

extension PostListPresenter: PostListViewControllerOutput {
    func viewIsReady() {
        updatePostListCellPresenters()
        updateTitle()
    }
    
    func didSelectCell(with indexPath: IndexPath) {
        guard presenters.indices.contains(indexPath.row) else {
            return
        }
        
        let presenter = presenters[indexPath.row]
        
        print(presenter.post)
        
        //presenter.doSomething()
        
        //interactor.updatePost(presenter.post)
    }
}