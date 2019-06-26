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
        map[3][2] = 0
        
        build_tile_map(map_ID: map, on_Layer: 0, zPos: -1)
        
        //map[3][2] = 1
        
        //build_tile_map(map_ID: map, on_Layer: 1, zPos: -2)
        
        // get_tile_at(row: 2, column: 2).position = CGPoint(x: frame.midX, y: frame.midY)
        
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            
            car.update_touch(location: location)
            
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
       // sorting_z_position(of: car.car)
        sorting_z_position(of: car.car, to_objects_in: sknode_map)
    }
    
    func build_tile_map(map_ID: [[Int]], on_Layer: Int, zPos: Double?){
        
        for row in 0...5 {
            for column in 0...5 {
                
                let tile = SKSpriteNode()
                
                let _id = map_ID[row][column]
                
                if let id = tile_type(rawValue: _id){
                    switch id {
                    case .house:
                        tile.texture = SKTexture(imageNamed: "a")
                    case .road:
                        tile.texture = SKTexture(imageNamed: "b")
                    }
                    
                    tile.name = "\(id)"
                }
                
                
                
                tile.size   = tile.texture!.size()
                tile_width  = tile.size.width
                tile_height = tile.size.height/2
                set_scale(of: tile, 0.5)
                
                tile.position.x =   tile_half_width  *  (CGFloat(column - row))   + offset_x
                tile.position.y =   tile_half_height * -(CGFloat(column + row))   + offset_y
                tile.position.y +=  tile_height * CGFloat(on_Layer)
                
                
                print(tile.name!)
                
                if zPos == nil || map[row][column] == 0 {
                    
                    let z_pos = row + column
                    tile.zPosition = CGFloat(z_pos + on_Layer)
                    
                    
                }else{
                    
                    tile.zPosition = CGFloat(zPos!)
                    
                }
                
                tile.anchorPoint = CGPoint(x: 0.5, y: 0.25)
                
                
                sknode_map[row][column] = tile
                addChild(tile)
            }
        }
    }
    
    func sorting_z_position(of object: SKSpriteNode){
        
                var map_objs: [SKSpriteNode] = []
        
                for i in 0...row {
                    map_objs.append(get_tile_at(row: i, column: 0))
                }
        
                //map_objs.append(get_tile_at(row: 0, column: 0))
        
//                if object.position.y > map_objs[0].position.y {
//                    object.zPosition = map_objs[0].zPosition - 0.5
//                }else if object.position.y < map_objs[0].position.y
//                    && object.position.y > map_objs[1].position.y {
//                    object.zPosition = map_objs[1].zPosition - 0.5
//                }else if object.position.y < map_objs[1].position.y
//                    && object.position.y > map_objs[2].position.y{
//                    object.zPosition = map_objs[2].zPosition - 0.5
//                }else if object.position.y < map_objs[2].position.y
//                    && object.position.y > map_objs[3].position.y{
//                    object.zPosition = map_objs[3].zPosition - 0.5
//                }else if object.position.y < map_objs[3].position.y
//                    && object.position.y > map_objs[4].position.y{
//                    object.zPosition = map_objs[4].zPosition - 0.5
//                }else if object.position.y < map_objs[4].position.y
//                    && object.position.y > map_objs[5].position.y{
//                    object.zPosition = map_objs[5].zPosition - 0.5
//                }else if object.position.y < map_objs[5].position.y
//                    {
//                    object.zPosition = map_objs[5].zPosition + 0.5
//                }
        
        
    }
    
    
    func sorting_z_position(of object: SKSpriteNode, to_objects_in map: [[SKSpriteNode]]){
        
        var temp_objects: [SKSpriteNode] = []
        
        for row in 0...5 {
            for column in 0...5 {
                if map[row][column].name == "house"{
                temp_objects.append(sknode_map[row][column])
                }
            }
        }
        
        print(temp_objects.count)
        
        //create level of Y position start from the top of tile map//
        
        let top_refference = map[0][0].position.y
        //let top_refference = CGFloat(382)
        let level_height   = tile_height/2
        print(top_refference)
       
        let level_1 = top_refference - level_height
        let level_2 = level_1 - level_height
        let level_3 = level_2 - level_height
        let level_4 = level_3 - level_height
        let level_5 = level_4 - level_height
        let level_6 = level_5 - level_height
        let level_7 = level_6 - level_height
        let level_8 = level_7 - level_height
        let level_9 = level_8 - level_height
        let level_10 = level_9 - level_height
        let level_11 = level_10 - level_height
        let level_12 = level_11 - level_height
        
        if object.position.y > top_refference{
            object.zPosition = 0.5
        }else if object.position.y < top_refference && object.position.y > level_1 {
            object.zPosition = 0.5
        }else if object.position.y < level_1 && object.position.y > level_2 {
            object.zPosition = 1.5
        }else if object.position.y < level_2 && object.position.y > level_3 {
            object.zPosition = 2.5
        }else if object.position.y < level_3 && object.position.y > level_4 {
            object.zPosition = 3.5
        }else if object.position.y < level_4 && object.position.y > level_5 {
            object.zPosition = 4.5
        }else if object.position.y < level_5 && object.position.y > level_6 {
            object.zPosition = 5.5
        }else if object.position.y < level_6 && object.position.y > level_7 {
            object.zPosition = 6.5
        }else if object.position.y < level_7 && object.position.y > level_8 {
            object.zPosition = 7.5
        }else if object.position.y < level_8 && object.position.y > level_9 {
            object.zPosition = 8.5
        }else if object.position.y < level_9 && object.position.y > level_10 {
            object.zPosition = 9.5
        }else if object.position.y < level_10 && object.position.y > level_11 {
            object.zPosition = 10.5
        }else if object.position.y < level_11 && object.position.y > level_12 {
            object.zPosition = 11.5
        }else if object.position.y < level_12   {
            object.zPosition = 12.5
        }
        
        print(level_height)
        
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
