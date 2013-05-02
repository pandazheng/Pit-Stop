//
//  GameOverScene.h
//  Proyecto_Final
//
//  Created by iAcisclo on 14/03/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"




@interface GameOverScene : CCLayer{
}

@property (nonatomic,retain)     CCLabelTTF *label1;
@property (nonatomic,retain)     CCLabelTTF *label2;


-(id)initWithScore:(int)score;

+(CCScene *) sceneWithScore:(int)score;

@end
