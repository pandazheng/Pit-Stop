//
//  HelloWorldLayer.h
//  Cambio de ruedas!
//
//  Created by iAcisclo on 19/03/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//
#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface HelloWorldLayer : CCLayer<CCTargetedTouchDelegate,UIGestureRecognizerDelegate>
{
    
    BOOL tuercaFuera;
    BOOL ponerTuerca;
    
}

+(CCScene *) scene;

@property (nonatomic) CGSize winSize;
@property (nonatomic) float time;

//Capas
@property (nonatomic,retain) CCLayer *capa1;
@property (nonatomic,retain) CCLayer *capa2;
@property (nonatomic,retain) CCLayer *capa3;

//Sprites
@property (nonatomic,retain) CCSprite *rueda;
@property (nonatomic,retain) CCSprite *tuerca;
@property (nonatomic,retain) CCSprite *taladro;

//Timer general
@property (retain, nonatomic)  CCLabelTTF *timeMinutes;
@property (retain, nonatomic)  CCLabelTTF *timeSeconds;
@property (retain, nonatomic)  CCLabelTTF *timeMilliseconds;
@property (strong, nonatomic)  NSTimer *timer;

//Desatornillar
@property (nonatomic,retain) NSTimer *tiempoDesatornillando;
@property int tiempoPulsando;
@property (retain,nonatomic) CCLabelTTF *cuentaAtrasSegundos;
@property (retain,nonatomic) CCLabelTTF *cuentaAtrasMilisegundos;
@property int cuentaAtras;



@end
