//
//  Extension.swift
//  FollowTheOrder
//
//  Created by Ann Yesip on 11.01.2022.
//

import SpriteKit

extension SKAction {
    
    class func increaseAndDecreaseAnimation(withTimeInternal: Int) -> SKAction {
        // Создаем Delay для каждой ноды в зависимости от индекса
        let delayAction = SKAction.wait(forDuration: TimeInterval(withTimeInternal) * 2)
        
        // Анимация увеличения, а затем уменьшения
        let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
        let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
        
        // Формируем Sequence (последовательность) для SKAction
        let scaleActionSequence = SKAction.sequence([scaleUpAction, scaleDownAction])
        
        // Создаем Action для повторения нашей последовательности 1 раз
        let repeatAction = SKAction.repeat(scaleActionSequence,
                                           count: 1)
        
        // Комбинируем 2 SKAction: Delay и Repeat
        return SKAction.sequence([delayAction, repeatAction])
    }
}
