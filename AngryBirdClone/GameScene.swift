//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Yemlihan Sapan on 11.09.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode() //Objeyi oluşturduk
    var box1 : SKSpriteNode! //Objeyi oluşturduk
    var box2 : SKSpriteNode! //Objeyi oluşturduk
    var box3 : SKSpriteNode! //Objeyi oluşturduk
    var box4 : SKSpriteNode! //Objeyi oluşturduk
    var box5 : SKSpriteNode! //Objeyi oluşturduk
    
    var boxArr :[SKSpriteNode] = [SKSpriteNode]()
    
    var gameStarted = false
    var originalPosition : CGPoint?
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType : UInt32 { //toplamı sonraki rakamı vermemeli 1+2 =3 bu yüzden 4 veya 2+4+1= 7 bu yüzden 8 gibi
        case bird = 1
        case box = 2
        case Ground = 4
        case Tree = 8
    }
    
    override func didMove(to view: SKView) {
        /*let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: 0, y: 0)
        bird2.size = CGSize(width: self.frame.width / 15, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)*/
        
        bird = childNode(withName: "bird") as! SKSpriteNode //ekrandaki objenin name alanındaki gibi ve bu tanımlama zorunlu objeyi seçiyoruz
        box1 = childNode(withName: "box1") as? SKSpriteNode //ekrandaki objenin name alanındaki gibi ve bu tanımlama zorunlu objeyi seçiyoruz
        box2 = childNode(withName: "box2") as? SKSpriteNode //ekrandaki objenin name alanındaki gibi ve bu tanımlama zorunlu objeyi seçiyoruz
        box3 = childNode(withName: "box3") as? SKSpriteNode //ekrandaki objenin name alanındaki gibi ve bu tanımlama zorunlu objeyi seçiyoruz
        box4 = childNode(withName: "box4") as? SKSpriteNode //ekrandaki objenin name alanındaki gibi ve bu tanımlama zorunlu objeyi seçiyoruz
        box5 = childNode(withName: "box5") as? SKSpriteNode //ekrandaki objenin name alanındaki gibi ve bu tanımlama zorunlu objeyi seçiyoruz
        
        
        let birdTexture = SKTexture(imageNamed: "bird") //ekrandaki objenin texture alanındaki isim
        let boxTexture = SKTexture(imageNamed: "brick") //ekrandaki objenin texture alanındaki isim
        let size = CGSize(width: boxTexture.size().width / 6 , height: boxTexture.size().height / 6) // boyutlandırdık
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 11) //objeyi ekrana koyduk ama etki alanını bu veriyor
        bird.physicsBody?.affectedByGravity = false // yerçekimi olayını baslangicta kapalı tıklayınca asagı acıyoruz
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15 //kütlesini veriyoruz gravitye karsı
        originalPosition = bird.position//baslangıc pozisyonu
        
        bird.physicsBody?.contactTestBitMask = ColliderType.bird.rawValue //çakışma yani diğer nesnelere temas ettiğinde
        bird.physicsBody?.categoryBitMask = ColliderType.bird.rawValue //cakısma kategorisi
        bird.physicsBody?.collisionBitMask = ColliderType.box.rawValue // asıl carpısma
        
        boxArr.append(box1)
        boxArr.append(box2)
        boxArr.append(box3)
        boxArr.append(box4)
        boxArr.append(box5)
        
        for box in boxArr {
            box.physicsBody = SKPhysicsBody(rectangleOf: size)
            box.physicsBody?.affectedByGravity = false
            box.physicsBody?.isDynamic = true
            box.physicsBody?.allowsRotation = true
            box.physicsBody?.mass = 0.4
            
            box.physicsBody?.collisionBitMask = ColliderType.bird.rawValue //çarpışacağı obje
        }
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // sınırlar koyuyor obje düşmüyor ekrandan asagı gibi
        self.scene?.scaleMode = .aspectFit //sınırları düzenliyoruz
        self.physicsWorld.contactDelegate = self // contakları algılama olayı yarattık inherit olarak SKPhysicCntact cagırılmalı
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 50
        scoreLabel.color = UIColor(named: "black")
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 3)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        
    }
    
    //olusturdugumuz categorylerinden biri birbirine degerse yani contact olursa
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.bird.rawValue {
            
            box1.physicsBody?.affectedByGravity = true
            box2.physicsBody?.affectedByGravity = true
            box3.physicsBody?.affectedByGravity = true
            box4.physicsBody?.affectedByGravity = true
            box5.physicsBody?.affectedByGravity = true
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // dokunmaya baslandıgında
        //bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200)) //mevcut konumundan yukarı 200 dedik
        //bird.physicsBody?.affectedByGravity = true // yerçekimi olayını tetikletiyor
        self.setLocation(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // dokunmaya devam ettikce
        self.setLocation(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {//oyun basladı mı
            if let touch = touches.first {//tıklananda bir obje vs var ise değişkene ata
                let touchLocation = touch.location(in: self) //tıklanının konumunu al
                let touchNodes = nodes(at: touchLocation) //dokunulan tochlocation ı ver diyorum
                
                if touchNodes.isEmpty == false { //tıklanan bos degilse diye tekrar kontrol ettik
                    for node in touchNodes { // tıklanları dönüyoruz
                        if let sprite = node as? SKSpriteNode{//tıklananı skspritenode haline getir
                            if sprite == bird { //ikiside skspritenode oldugundan kontrol edebiliyoruz
                                let dx = -(touchLocation.x - originalPosition!.x) //eksi yaptık cunku tersine gitmesi gerekiyor
                                let dy = -(touchLocation.y - originalPosition!.y) //eksi yaptık cunku tersine gitmesi gerekiyor
                                
                                let impulse = CGVector(dx: dx, dy: dy) //impulse vector ile konumu güncelliyor aslında
                                
                                bird.physicsBody?.applyImpulse(impulse) //burda impulse kuşun konumları aktardık
                                bird.physicsBody?.affectedByGravity = true // gravity uyguladık
                                gameStarted = true // oyunu bitirdik aslında kuşa tekrar tıklanması diye
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if let birdPsysicsBody = bird.physicsBody{
            if birdPsysicsBody.velocity.dx <= 0.1 && birdPsysicsBody.velocity.dy <= 0.1 && birdPsysicsBody.angularVelocity <= 0.1 && gameStarted == true { //hız ve açısal hız vs kontrol edildi ve oyunda basladıysa
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                score = 0
                scoreLabel.text = String(score)
                gameStarted = false
            }
        }
    }
    
    func setLocation(touches : Set<UITouch>){
        if gameStarted == false {//oyun basladı mı
            if let touch = touches.first {//tıklananda bir obje vs var ise değişkene ata
                let touchLocation = touch.location(in: self) //tıklanının konumunu al
                let touchNodes = nodes(at: touchLocation) //dokunulan tochlocation ı ver diyorum
                
                if touchNodes.isEmpty == false { //tıklanan bos degilse diye tekrar kontrol ettik
                    for node in touchNodes { // tıklanları dönüyoruz
                        if let sprite = node as? SKSpriteNode{//tıklananı skspritenode haline getir
                            if sprite == bird { //ikiside skspritenode oldugundan kontrol edebiliyoruz
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
}
