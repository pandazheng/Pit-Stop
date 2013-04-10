//
//  HelloWorldLayer.h
//  Cambio de ruedas!
//
//  Created by iAcisclo on 19/03/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@property (nonatomic) CGSize winSize;
@property (nonatomic) float time;


@property (nonatomic,retain) CCLayer *capa1;
@property (nonatomic,retain) CCLayer *capa2;
@property (nonatomic,retain) CCLayer *capa3;

@property (nonatomic,retain) CCSprite *rueda;
@property (nonatomic,retain) CCSprite *tuerca;
@property (nonatomic,retain) CCSprite *taladro;

//tiempo
//@property (nonatomic,retain) CCProgressTimer *chronometerBlanco;
//@property (nonatomic,retain) CCProgressTimer *chronometerRojo;
@property (retain, nonatomic)  CCLabelTTF *timeMinutes;
@property (retain, nonatomic)  CCLabelTTF *timeSeconds;
@property (retain, nonatomic)  CCLabelTTF *timeMilliseconds;
@property (strong, nonatomic)  NSTimer *timer;


@property (nonatomic,retain) NSTimer *tiempoDesatornillando;
@property int tiempoPulsando;


@end
