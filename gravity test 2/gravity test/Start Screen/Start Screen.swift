import SpriteKit
import GameplayKit

class StartScreen: SKScene {
    
    var player: SKSpriteNode!
    var xPos: Int = 0
    var blocks = [SKShapeNode]()
    var startButton: SKSpriteNode!
    var start: SKSpriteNode!
    var title: SKSpriteNode!
    
    class Shape {
        var x: CGFloat
        var y: CGFloat
        var width: CGFloat
        var height: CGFloat
        
        init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
            self.x = x
            self.y = y
            self.width = width
            self.height = height
        }
    }
    
    var shapes = [Shape]()
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -10)
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: -443.3, y: -269.5)
        player.scale(to: CGSize(width: 60, height: 60))
        addChild(player)
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.restitution = 0.5
        player.physicsBody?.mass = 0.085
        
//        title = SKSpriteNode(fileNamed: "Title")
//        title?.position = CGPoint(x: 0, y: 158)
//        addChild(title)
        if let title = SKSpriteNode(fileNamed: "Title") {
            title.position = CGPoint(x: 0, y: 158)
            addChild(title)
        } else {
            print("FUUUUUCK")
        }
        
//        startButton = SKSpriteNode(fileNamed: "Start Button")
//        startButton.position = CGPoint(x: 0, y: 0)
        
        start = SKSpriteNode(fileNamed: "Start")
        
        func createShape(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
            let shape = Shape(x: x, y: y, width: width, height: height)
            shapes.append(shape)
        }
        
        createShape(x: 0, y: -359, width: 1024, height: 126)        // Floor
        
        for shape in shapes {
            let shapeNode = SKShapeNode(rectOf: CGSize(width: shape.width, height: shape.height))
            shapeNode.position = CGPoint(x: shape.x, y: shape.y)
            shapeNode.fillColor = SKColor(red: 112, green: 112, blue: 112, alpha: 1.0)
            shapeNode.strokeColor = SKColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            addChild(shapeNode)
            let width = shape.width
            let height = shape.height
            
            shapeNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
            shapeNode.physicsBody?.isDynamic = false
            shapeNode.physicsBody?.affectedByGravity = false
            shapeNode.physicsBody?.friction = 10.0
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        

        
        if player.position.x < -520 {
            player.position.x = 520
        }
        
        if player.position.x > 520 {
            let level2 = SKScene(fileNamed: "Level2")
            level2?.scaleMode = .aspectFill
            scene?.view?.presentScene(level2!)
        }
        
        if player.position.y >= 380 {
            player.position.y = 380
            player.physicsBody?.velocity.dy -= (player.physicsBody?.velocity.dy)!
        }
        if xPos == -1 {
            player.physicsBody?.applyImpulse(CGVector(dx: -1, dy: 0))
        }
        if xPos == 1 {
            player.physicsBody?.applyImpulse(CGVector(dx: 1, dy: 0))
        }
        
        
    }
}

