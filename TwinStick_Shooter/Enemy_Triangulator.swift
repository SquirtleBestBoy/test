//
//  Enemy_Triangulator.swift
//  TwinStick_Shooter
//
//  Created by William Leet on 10/31/20.
//  Copyright © 2020 William Leet. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class Enemy_Triangulator: Enemy{
    
    //Is given a weapon and the player's data to help it aim
    var weapon: Weapon!
    
    convenience init(scale: CGFloat, game_world: GameScene){
        self.init(sprite: "Triangulator", scale: scale, game_world: game_world, hp: 5, hitbox: 0.35)
        weapon = Tri_Blaster(game_world: game_scene, user: self, barrel_len: (self.frame.height/1.8))
    }
    
    //Runs the ship's movement and firing behaviors indefinitely.
    override func deploy(){
        let attack: SKAction = SKAction.run{
                self.weapon.fire(angle: self.zRotation)
        }
        let between_shots = SKAction.wait(forDuration: self.weapon.get_fire_rate())
        let firing_seq = SKAction.sequence([between_shots,attack])
        let salvo = SKAction.repeat(firing_seq, count: 20)
        let between_salvos = SKAction.wait(forDuration: 3.5)
        let firing_behavior = SKAction.repeatForever(SKAction.sequence([salvo,between_salvos]))
        let movement_behavior = sluggish_behavior(scene: game_scene, ship: self, opponent: opponent)
        let spinny_behavior = SKAction.repeatForever(SKAction.repeatForever(SKAction.rotate(byAngle: 1, duration: 3)))
        self.run(firing_behavior)
        self.run(movement_behavior)
        self.run(spinny_behavior)
    }
    
    
}

