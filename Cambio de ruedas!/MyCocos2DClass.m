//
//  MyCocos2DClass.m
//  Proyecto_Final
//
//  Created by iAcisclo on 28/03/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MyCocos2DClass.h"
#import "HelloWorldLayer.h"
#import "ABGameKitHelper.h"


@implementation MyCocos2DClass

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MyCocos2DClass *layer = [MyCocos2DClass node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Pit-Stop" fontName:@"Marker Felt" fontSize:64];
        [label setColor:ccRED];
        
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *spriteFondo = [CCSprite spriteWithFile:@"fondoLogo1@2x.png"];
        spriteFondo.position = ccp(size.width/2,size.height/2);
        
		label.position =  ccp( size.width /2 , size.height/2+50);
		
		//[self addChild:spriteFondo];
        [self addChild: label];
        

		[CCMenuItemFont setFontSize:28];
		
		// Achievement Menu Item using blocks
		CCMenuItem *botonPlay = [CCMenuItemFont itemWithString:@"Jugar" block:^(id sender) {
           
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] withColor:ccWHITE]];
                   }];
        
        
        CCMenu *menu = [CCMenu menuWithItems:botonPlay, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		// Add the menu to the layer
		[self addChild:menu];
        
        [[ABGameKitHelper sharedClass]authenticatePlayer];

        
	}
	return self;
}



@end
