import Foundation
import SpriteKit


class Cartesian_Tile_Engine {
    
    var gamescene: GameScene!
    
    let origin_x: CGFloat = 120
    let origin_y: CGFloat = 500
    var origin: CGPoint { return CGPoint(x: origin_x, y: origin_y) }
    
    var row   : Int    = 5
    var column: Int    = 5
    
    var tile_width          : CGFloat = 32
    var tile_half_width     : CGFloat { return tile_width/2  }
    var tile_height         : CGFloat = 32
    var tile_half_height    : CGFloat { return tile_height/2 }
    
    var MAP_OBJECTs: [[SKSpriteNode]]!
    var MAP_LAYERs: [Any] = []      //Map_layers -> Container for all Map_objects in different layers//
    var MAP_ID: [[Int]]!            //Map_ID     -> Define ID/tile_type in the map

    init(gamescene: GameScene) {
        self.gamescene = gamescene
        MAP_OBJECTs = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 6)
    }
    
    func add_wall_collision(){
        
        let wall = SKShapeNode(rect: get_map_rect())
        wall.fillColor = .red
        wall.alpha = 0.25
        wall.zPosition = 100
        wall.position = MAP_OBJECTs[0][0].position
        
        print("wall \(wall.position)")
        print("origin \(origin)")
        print("mapobject0,0 \(MAP_OBJECTs[0][0].position)")
        get_description()
        
        wall.physicsBody = SKPhysicsBody.init(edgeLoopFrom: get_map_rect())
        wall.physicsBody?.restitution = 1
        wall.physicsBody?.collisionBitMask = 0b0010
        wall.physicsBody?.categoryBitMask = 0b0010
        gamescene.addChild(wall)
    }

    func build_2Dtile_map(){
        for row in 0...5{
            for column in 0...5{
                let tile = SKSpriteNode(imageNamed: "tile")
                
                tile.size           = tile.texture!.size()
                print("tile.size = \(tile.size)")
                tile_width          = tile.size.width
                tile_height         = tile.size.height
                tile.anchorPoint    = CGPoint(x: 0, y: 0)
                set_scale(of: tile, 0.5)
                print("tile.size = \(tile.size)")
                
                tile.position.x     = (CGFloat(row)      * tile_width )    + origin_x
                tile.position.y     = (CGFloat(column)   * tile_height)    + origin_y
                tile.zPosition      = 5
                tile.name           = "\(row),\(column)"
                
                MAP_OBJECTs[row][column] = tile
                gamescene.addChild(tile)
            }
        }
    }
    
    func set_scale(of tile : SKSpriteNode, _ scale: CGFloat) {
        tile_width  *= scale
        tile_height *= scale
        print("tile_width_setscale = \(tile_width)")
        tile.setScale(scale)
    }
    
    func build_MAP_OBJECTs() -> [[SKSpriteNode]] {
        let temp_OBJECTs:[[SKSpriteNode]] = []
        return temp_OBJECTs
    }

    func get_map_width() -> CGFloat {
        var map_width: CGFloat = 0
        for _ in 0...row{
            map_width += tile_width
        }
        return map_width
    }
    
    func get_map_height() -> CGFloat {
        var map_height: CGFloat = 0
        for _ in 0...column{
            map_height += tile_height
        }
        return map_height
    }
    
    func get_map_size() -> CGSize {
        let map_size = CGSize(width: get_map_width(), height: get_map_height())
        return map_size
    }
    
    func get_map_rect() -> CGRect{
        let map_rect = CGRect(origin: CGPoint.zero, size: get_map_size())
        return map_rect
    }
    
    func get_description(){
        print("tile_width   = \(tile_width)")
        print("tile_height  = \(tile_height)")
        print("map_height   = \(get_map_height())")
        print("map_width    = \(get_map_width())")
    }
}
