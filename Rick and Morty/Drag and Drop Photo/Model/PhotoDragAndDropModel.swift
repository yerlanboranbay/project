import UIKit

struct PhotoDragAndDropModel: Hashable {
    let id = UUID()
    var image: UIImage
    var isCanDelete: Bool = false
}
