import SpriteKit

class GameScene: SKScene{
    
    
    let offset_x: CGFloat = 200
    let offset_y: CGFloat = 600
    
    let tile_width          : CGFloat = 64
    let tile_half_width     : CGFloat = 32
    let tile_height         : CGFloat = 32
    let tile_half_height    : CGFloat = 19
    
    var map: [[Int]] = []
    
    override func didMove(to view: SKView) {
        
        
        
        
        for row in 0...5 {
            for column in 0...5 {
                
                let house_unit = SKSpriteNode(imageNamed: "h01_s128_iso_0001")
                house_unit.size = CGSize(width: 64, height: 64)
                house_unit.position.x = tile_half_width  *  (CGFloat(column - row))   + offset_x
                house_unit.position.y = tile_half_height * -(CGFloat(column + row))   + offset_y
                addChild(house_unit)
                
                map[row][column] = 0
                
            }
        }
        
        
    }
}
