import SpriteKit
import GameplayKit

class Level3: SKScene {
    
    var player: SKSpriteNode!
    var xPos: Int = 0
    var blocks = [SKShapeNode]()
    var lava = SKShapeNode(rectOf: CGSize(width: 311, height: 125))
    var livesLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var jumpPad = SKShapeNode(rectOf: CGSize(width: 100, height: 15))
    
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
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 288, y: 381)
        player.scale(to: CGSize(width: 60, height: 60))
        addChild(player)
        
        livesLabel.position = CGPoint(x: -475, y: 340)
        livesLabel.horizontalAlignmentMode = .left
        addChild(livesLabel)
        
        scoreLabel.position = CGPoint(x: -475, y: 300)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.restitution = 0.5
        player.physicsBody?.mass = 0.085
        
        lava.fillColor = (SKColor(red: 1, green: 0, blue: 0, alpha: 1.0))
        lava.strokeColor = (SKColor(red: 0, green: 0, blue: 0, alpha: 1.0))
        lava.position = CGPoint(x: 356, y: -359)
        lava.zPosition = 10
        addChild(lava)
        
        jumpPad.fillColor = (SKColor(red: 0.2196, green: 0.2196, blue: 0.2196, alpha: 1.0))
        jumpPad.strokeColor = (SKColor(red: 0, green: 0, blue: 0, alpha: 1.0))
        jumpPad.position = CGPoint(x: -75, y: -290)
        addChild(jumpPad)
        
        func createShape(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
            let shape = Shape(x: x, y: y, width: width, height: height)
            shapes.append(shape)
        }
        
        createShape(x: 0, y: -359, width: 1024, height: 126)      //Floor
        createShape(x: 288.5, y: 130.5, width: 230, height: 25)   //
        createShape(x: 424.5, y: 39, width: 230, height: 25)
        createShape(x: 153.5, y: -50, width: 186, height: 25)
        createShape(x: 359.5, y: -175, width: 129, height: 25)
        createShape(x: 185, y: 240, width: 25, height: 192)
        createShape(x: 73, y: 59, width: 25, height: 192)
        createShape(x: -150, y: -195, width: 25, height: 200)
        
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
    
    override func keyDown(with event: NSEvent) {
        
        if event.keyCode == 49 && player.intersects(jumpPad) { // Space bar keycode
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 75))
        } else if event.keyCode == 49 {
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
        }
        
        if event.keyCode == 123 {
            xPos = -1
        }
        
        if event.keyCode == 124 {
            xPos = 1
        }
    }
    
    override func keyUp(with event: NSEvent) {
        if event.keyCode == 123 || event.keyCode == 124 {
            xPos = 0
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        livesLabel.text = ("Lives: \(lives)")
        scoreLabel.text = ("Score: \(score)")

        if player.frame.intersects(CGRect(x: 167.5, y: -421.5, width: 311, height: 126)) {
            lives -= 1
            player.position = CGPoint(x: 288, y: 381)
            print(player.position)
        }

        if player.position.x < -520 {
            let level4 = SKScene(fileNamed: "Level4")
            level4?.scaleMode = .aspectFill
            scene?.view?.presentScene(level4)
        }

        if player.position.x > 520 {
            player.position.x = -520
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
