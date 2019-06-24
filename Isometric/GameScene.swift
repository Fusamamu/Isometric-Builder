import SpriteKit

class GameScene: SKScene{
    
    var Garbage_Trunk: SKSpriteNode!
    var car: Vehicle!
    
    
    let offset_x: CGFloat = 205
    let offset_y: CGFloat = 350
    
    var row: Int    = 5
    var column: Int = 5
    
    var tile_width          : CGFloat = 64
    var tile_half_width     : CGFloat { return tile_width/2  }
    var tile_height         : CGFloat = 32
    var tile_half_height    : CGFloat { return tile_height/2 }
    
    
    var map = Array(repeating: Array(repeating: 1, count: 6), count: 6)
    
    var sknode_map = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 6)
    
    enum tile_type :Int {
        case house = 0
        case road = 1
    }
    
    
    
    override func didMove(to view: SKView) {
        
        car = Vehicle(gamescene: self)
        
        map[1][0] = 0
        map[0][4] = 0
        map[5][5] = 0
        
        build_tile_map(on_Layer: 1)
        //build_tile_map(on_Layer: 2)
        
        // get_tile_at(row: 2, column: 2).position = CGPoint(x: frame.midX, y: frame.midY)
        
        Garbage_Trunk = SKSpriteNode(imageNamed: "garbage_SW")
        Garbage_Trunk.texture?.filteringMode = .nearest
        Garbage_Trunk.position = CGPoint(x: frame.midX, y: frame.midY)
        Garbage_Trunk.zPosition = 10
        addChild(Garbage_Trunk)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            
            car.update_touch(location: location)
            
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        sorting_z_position(of: car.car)
    }
    
    func build_tile_map(on_Layer: Int){
        
        for row in 0...5 {
            for column in 0...5 {
                
                let tile = SKSpriteNode()
                
                let _id = map[row][column]
                
                if let id = tile_type(rawValue: _id){
                    switch id {
                    case .house:
                        tile.texture = SKTexture(imageNamed: "a")
                    case .road:
                        tile.texture = SKTexture(imageNamed: "b")
                    }
                }
                
                
                
                tile.size   = tile.texture!.size()
                tile_width  = tile.size.width
                tile_height = tile.size.height/2
                set_scale(of: tile, 0.5)
                
                tile.position.x =   tile_half_width  *  (CGFloat(column - row))   + offset_x
                tile.position.y =   tile_half_height * -(CGFloat(column + row))   + offset_y
                tile.position.y +=  tile_height * CGFloat(on_Layer)
                
                tile.name = "tile at [\(row),\(column)]"
                print(tile.name!)
                
                
                let z_pos = row + column
                tile.zPosition = CGFloat(z_pos + on_Layer)
                
                sknode_map[row][column] = tile
                addChild(tile)
            }
        }
    }
    
    func sorting_z_position(of object: SKSpriteNode){
        
        //        var map_objs: [SKSpriteNode]!
        //
        //        for i in 0...row {
        //            map_objs.append(get_tile_at(row: i, column: 0))
        //        }
        //
        //        if object.position.y > map_objs[0].position.y {
        //            object.zPosition = map_objs[0].zPosition - 0.5
        //        }else if map_objs[0].position.y > object.position.y  && object.position.y > map_objs[1].position.y {
        //            object.zPosition = map_objs[1].zPosition - 0.5
        //        }
        
        
    }
    
    func set_tile_at(row: Int, column: Int){
        
    }
    
    func get_tile_at(row: Int, column: Int) -> SKSpriteNode {
        return sknode_map[row][column]
    }
    
    func set_scale(of tile : SKSpriteNode, _ scale: CGFloat) {
        tile_width  *= scale
        tile_height *= scale
        tile.setScale(scale)
    }
}
