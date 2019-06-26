import SpriteKit

class GameScene: SKScene{
    
    
    var car: Vehicle!
    
    
    var tile_engine: Tile_Engine!
    
    
    
    override func didMove(to view: SKView) {
        
        car = Vehicle(gamescene: self)
        
        tile_engine = Tile_Engine(gamescene: self)
        tile_engine.set_entire_MAP_ID(to: 0)
        
            tile_engine.set_MAP_ID(at: 3, 3, to: 2)
            tile_engine.set_MAP_ID(at: 2, 2, to: 1)
            tile_engine.set_MAP_ID(at: 4, 2, to: 1)
        
        tile_engine.build_tile_map(on_Layer: 0)
        
            tile_engine.set_entire_MAP_ID(to: 2)
            tile_engine.set_MAP_ID(at: 2, 2, to: 1)
            tile_engine.set_MAP_ID(at: 3, 2, to: 1)
            tile_engine.set_MAP_ID(at: 4, 2, to: 1)
        
        tile_engine.build_tile_map(on_Layer: 1)
        
        
        
 
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            
            car.update_touch(location: location)
            
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
       
        
        tile_engine.sorting_z_position(of: car.car,in: tile_engine.MAP_LAYERS[0] as! [[SKSpriteNode]])
    }
    
    
}



class Tile_Engine{
    
    var gamescene: GameScene!
    
    let offset_x: CGFloat = 205
    let offset_y: CGFloat = 350
    
    var row   : Int    = 5
    var column: Int    = 5
    
    var tile_width          : CGFloat = 64
    var tile_half_width     : CGFloat { return tile_width/2  }
    var tile_height         : CGFloat = 32
    var tile_half_height    : CGFloat { return tile_height/2 }
    
    var MAP_LAYERS: [Any] = []      //Map_layers -> Container for all Map_objects in different layers//
    var MAP_ID: [[Int]]!            //Map_ID     -> Define ID/tile_type in the map
    //var MAP_OBJECTS: [[SKSpriteNode]]!
    //var MAP_ID      = Array(repeating: Array(repeating: 1, count: 6), count: 6)
    //var MAP_OBJECTS = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 6)
    
    enum tile_type :Int {
        case floor = 0
        case house = 1
        case blank = 2
        
    }
    
    init(gamescene: GameScene) {
        self.gamescene = gamescene
        self.set_entire_MAP_ID(to: 0)
    }
    
    func build_tile_map(on_Layer: Int) {
        
        var map_objs = Array(repeating: Array(repeating: SKSpriteNode(), count: row + 1),
                                  count: column + 1)
        
        for row in 0...5 {
            for column in 0...5 {
                
                let tile = SKSpriteNode()
                
                if let id = tile_type(rawValue: self.MAP_ID[row][column]){
                    
                    switch id {
                        case .floor :   tile.texture = SKTexture(imageNamed: "b")
                        case .house :   tile.texture = SKTexture(imageNamed: "a")
                        case .blank :   tile.texture = SKTexture(imageNamed: "a")
                                        tile.isHidden = true
                    }
                    
                    tile.name = "\(id)"
                    print(tile.name!)
                }
                
                tile.size   = tile.texture!.size()
                tile_width  = tile.size.width
                tile_height = tile.size.height/2
                set_scale(of: tile, 0.5)
                
                tile.anchorPoint  =   CGPoint(x: 0.5, y: 0.25)
                tile.position.x   =   tile_half_width  *  (CGFloat(column - row))   + offset_x
                tile.position.y   =   tile_half_height * -(CGFloat(column + row))   + offset_y
                tile.position.y  +=   tile_height * CGFloat(on_Layer)
                
                //Define initial Z Positions in TILE MAP//
                
                
                if MAP_ID[row][column] == 0 {
                    //if MAP_ID is FLOOR set z position to draw first
                    tile.zPosition = -1
                }else{
                    let z_pos = row + column
                    tile.zPosition = CGFloat(z_pos + on_Layer)
                }

                map_objs[row][column] = tile
                
                gamescene.addChild(tile)
            }
        }
        
       MAP_LAYERS.append(map_objs)
        
        
    }
    
    
    
    func sorting_z_position(of object: SKSpriteNode,in map: [[SKSpriteNode]]){
        
//        var temp_objects: [SKSpriteNode] = []
//
//        for row in 0...5 {
//            for column in 0...5 {
//                if map[row][column].name == "house"{
//                    temp_objects.append(MAP_OBJECTS[row][column])
//                }
//            }
//        }
        
//        print(temp_objects.count)
        
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
        
        
        
    }
    
    func set_entire_MAP_ID(to id: Int){
        if MAP_ID == nil{
            MAP_ID = Array(repeating: Array(repeating: id, count: 6), count: 6)
        }else{
            for row in 0...row{
                for column in 0...column{
                    MAP_ID[row][column] = id
                }
            }
        }
    }
    
    func set_MAP_ID(at row:Int, _ column:Int, to id:Int){
        MAP_ID[row][column] = id
    }
    
    func update_MAP_ID() {
        
    }
    
    func set_tile_at(row: Int, column: Int){
        
    }
    
    func get_tile_at(row: Int, column: Int) -> SKSpriteNode {
        //return MAP_OBJECTS[row][column]
        let temp_map_object = MAP_LAYERS[0] as! [[SKSpriteNode]]
        return temp_map_object[row][column]
    }
    
    func set_scale(of tile : SKSpriteNode, _ scale: CGFloat) {
        tile_width  *= scale
        tile_height *= scale
        tile.setScale(scale)
    }
    
    
    
    
}
