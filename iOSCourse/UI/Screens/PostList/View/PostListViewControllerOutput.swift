//

import Foundation

protocol PostListViewControllerOutput: AnyObject, ViewOutput {
    func didSelectCell(with indexPath: IndexPath)
}