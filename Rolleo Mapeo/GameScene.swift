//
//  GameScene.swift
//  Rolleo Mapeo
//
//  Created by Mathias I Nielsen on 11/10/2018.
//  Copyright © 2018 Mathias I Nielsen. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    var endNode = SKSpriteNode()
    var startNode = SKSpriteNode()
    var deathNode = SKSpriteNode()
    var level = 1
   
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "rolleo") as! SKSpriteNode
        endNode = self.childNode(withName: "endNode") as! SKSpriteNode
        startNode = self.childNode(withName: "startNode") as! SKSpriteNode
        deathNode = self.childNode(withName: "deathNode") as! SKSpriteNode
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 10, dy: CGFloat((data?.acceleration.y)!) * 10)
        }
        
        player.physicsBody!.restitution = 0.8
        player.physicsBody!.linearDamping = 0
        player.physicsBody!.friction = 0.3
        player.physicsBody?.isDynamic = true
        player.physicsBody!.mass = 0.5
        
    
        
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    func notify (){
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node as! SKSpriteNode
        let bodyB = contact.bodyB.node as! SKSpriteNode
    
        if bodyA.name == "rolleo" && bodyB.name == "startNode" || bodyA.name == "startNode" && bodyB.name == "rolleo"{
            
            HighScore.hs.start()
        }
        
        else if bodyA.name == "endNode" && bodyB.name == "rolleo" || bodyA.name == "rolleo" && bodyB.name == "endNode" {
            HighScore.hs.stop(level: level)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stop"), object: nil, userInfo: ["level":level])
        }
        
        else if bodyA.name == "deathNode" && bodyB.name == "rolleo" || bodyA.name == "rolleo" && bodyB.name == "deathNode" {
            playerDies()
        }
    }
    
    
    func playerDies(){
        
        player.removeFromParent()
        endNode.removeFromParent()
        startNode.removeFromParent()
        deathNode.removeFromParent()
        
        self.removeAllChildren()
        self.removeAllActions()
        self.scene?.removeFromParent()
        
        self.view?.window?.rootViewController?.dismiss(animated: true
            , completion: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "death"), object: nil)
     
    }
        
    
        
        
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    enum entities {
        case rolleo
        case endNode
        case startNode
        case walls
    }
}
