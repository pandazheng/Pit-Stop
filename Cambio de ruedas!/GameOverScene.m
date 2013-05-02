//
//  GameOverScene.m
//  Proyecto_Final
//
//  Created by iAcisclo on 14/03/13.
//
//

#import "GameOverScene.h"
#import "HelloWorldLayer.h"
#import "ABGameKitHelper.h"


@implementation GameOverScene

+(CCScene *) sceneWithScore:(int)score
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOverScene *layer = [GameOverScene node];
    [layer initWithScore:(int)score];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
    
	
	// return the scene
	return scene;
}

-(id)initWithScore:(int)score{
    
    if( (self=[super init]) ) {
        // create and initialize a Label
        
        NSString *str = [NSString stringWithFormat:@"Tiempo: %d",score];
		CCLabelTTF *label = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:30];
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Marker Felt" fontSize:64];

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp(size.width /2 , size.height/2 );
        label2.position = ccp(size.width /2 , size.height/2 +50);
		
		// add the label as a child to this Layer
		[self addChild: label];
		[self addChild: label2];
        
        
        CCMenuItem *botonPlay = [CCMenuItemFont itemWithString:@"Jugar de nuevo" block:^(id sender) {
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] withColor:ccWHITE]];
                  }];
        //botonPlay.position = ccp(size.width /2 , size.height/2 +30);
        
        CCMenu *menu = [CCMenu menuWithItems:botonPlay, nil];
        menu.position = ccp(size.width /2 , size.height/2 -40);
        [self addChild:menu];
        
        [self scheduleOnce:@selector(mostrarGameCenter) delay:2];

    }
    return self;
    
}
-(void)mostrarGameCenter
{
    [[ABGameKitHelper sharedClass] showLeaderboard:@"TiempoDeJuego"];
    

}

@end
