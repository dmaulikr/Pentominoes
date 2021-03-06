//: Playground - noun: a place where people can play
import UIKit
import XCPlayground

public class PentominoViewController: UIViewController {
    
    private let gridSize: CGFloat = 30
    var boardView: BoardView!
    var tileViews: [TileView]!
    public var board: Board! {
        didSet {
            boardView = BoardView(board: board, gridSize: gridSize)
        }
    }
    public var tiles = [Tile]() {
        didSet {
            tileViews = tiles.map { TileView(tile: $0, color: randomColor(), gridSize: gridSize) }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        print(view)
        view.addSubview(boardView)
        tileViews.forEach { view.addSubview($0) }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        boardView.center = view.center
        for (index, tileView) in tileViews.enumerate() {
            if tileView.superview != view {
                continue
            }
            switch index {
            case 0...4 :
               tileView.center.x = (view.bounds.width / 6 * CGFloat(index + 1))
                tileView.center.y = tileView.bounds.height
            case 5:
                tileView.center.x = view.bounds.width / 6
                tileView.center.y = view.bounds.midY
            case 6:
                tileView.center.x = view.bounds.width * 0.833333
                tileView.center.y = view.bounds.midY
            default:
                tileView.center.x = (view.bounds.width / 6 * CGFloat(index - 6))
                tileView.center.y = view.bounds.height - tileView.bounds.height
            }
            
            
        }
    }
}

let controller = PentominoViewController()
let board = Board(size: .SixByTen)
let tiles = (0..<12).map { Tile(shape: Shape(rawValue: $0)!) }
controller.board = board
controller.tiles = tiles
XCPlaygroundPage.currentPage.liveView = controller
controller.view.frame = CGRect(x: 0, y: 0, width: 1000, height: 700)
controller.viewDidLayoutSubviews()
controller.view


