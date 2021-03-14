import SpriteKit

class GameScene: SKScene,  SKPhysicsContactDelegate{

    var tile_engine: ISO_Tile_Engine!
    var cart_tiles: Cartesian_Tile_Engine!
    
    var car         : Vehicle!
    
    var dot_in_2D   : SKShapeNode!
    var dot_in_ISO  : SKShapeNode!
    
    override func didMove(to view: SKView) {
        
        car = Vehicle(gamescene: self)
        
        dot_in_2D = SKShapeNode(circleOfRadius: 6)
        dot_in_2D.fillColor = .red
        dot_in_2D.zPosition = 10

        dot_in_ISO = SKShapeNode(circleOfRadius: 6)
        dot_in_ISO.fillColor = .blue
        dot_in_ISO.zPosition = 10
        
        addChild(dot_in_2D)
        addChild(dot_in_ISO)
        
        cart_tiles = Cartesian_Tile_Engine(gamescene: self)
        cart_tiles.build_2Dtile_map()
        cart_tiles.add_wall_collision()
        dot_in_2D.position = cart_tiles.MAP_OBJECTs[3][3].position

        dot_in_2D.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        dot_in_2D.physicsBody?.collisionBitMask = 0b0010
        dot_in_2D.physicsBody?.categoryBitMask = 0b0010
        
        tile_engine = ISO_Tile_Engine(gamescene: self)
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
        
        dot_in_ISO.position = tile_engine.get_ISO_POS(from: dot_in_2D.position)
        dot_in_ISO.position.x += 10
        dot_in_ISO.position.y += 10
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}






