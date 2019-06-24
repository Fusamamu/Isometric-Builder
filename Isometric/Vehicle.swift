import SpriteKit
import Foundation

class Vehicle {
    
    var gamescene: GameScene!
    var car: SKSpriteNode!
    
    enum direction {
        case NE
        case NW
        case SE
        case SW
    }
    
    var car_direction = direction.SE
    
    var current_action: SKAction!
    var move_NE: SKAction!
    var move_NW: SKAction!
    var move_SE: SKAction!
    var move_SW: SKAction!
    
    init(gamescene: GameScene) {
        self.gamescene = gamescene
        
        car = SKSpriteNode(imageNamed: "garbage_SW")
        car.position = CGPoint(x: self.gamescene.frame.midX, y: self.gamescene.frame.midY)
        
        car.zPosition = 10
        
        self.gamescene.addChild(car)
        
        let sin30 = sin(35.0 * Double.pi / 180)
        let cos30 = sin(35.0 * Double.pi / 180)
        
        let duration = 0.008
        move_NE = SKAction.repeatForever(SKAction.move(by: CGVector(dx: cos30, dy: sin30), duration: duration))
        move_NW = SKAction.repeatForever(SKAction.move(by: CGVector(dx: -cos30, dy: sin30), duration: duration))
        move_SE = SKAction.repeatForever(SKAction.move(by: CGVector(dx: cos30, dy: -sin30), duration: duration))
        move_SW = SKAction.repeatForever(SKAction.move(by: CGVector(dx: -cos30, dy: -sin30), duration: duration))
        
        car.run(move_SE)
        
    }
    
    
    func update_touch(location: CGPoint){
        
        if gamescene.contains(location)
        {
            switch car_direction{
                
            case .SE:
                car.removeAllActions()
                car.run(move_SW)
                car.texture = SKTexture(imageNamed: "garbage_SW")
                car_direction = .SW
            case .SW:
                car.removeAllActions()
                car.run(move_NW)
                car.texture = SKTexture(imageNamed: "garbage_NW")
                car_direction = .NW
                
            case .NW:
                car.removeAllActions()
                car.run(move_NE)
                car.texture = SKTexture(imageNamed: "garbage_NE")
                car_direction = .NE
            case .NE:
                car.removeAllActions()
                car.run(move_SE)
                car.texture = SKTexture(imageNamed: "garbage_SE")
                car_direction = .SE
            }
        }
    }
}

