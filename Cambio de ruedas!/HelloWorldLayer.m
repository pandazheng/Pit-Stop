//
//  HelloWorldLayer.m
//  Cambio de ruedas!
//
//  Created by iAcisclo on 19/03/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "CDAudioManager.h"
#import "CCNode+SFGestureRecognizers.h"
#import "GameOverScene.h"
#import "ABGameKitHelper.h"


int cronoStatus = 0;
int minutesElapsed = 0;
float timeElapsed = 0;

@implementation HelloWorldLayer
@synthesize time = _time;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id) init
{
	if( (self=[super init]) ) {
		
        self.isTouchEnabled = YES;
        self.winSize = [CCDirector sharedDirector].winSize;
        
        self.capa1 = [CCLayer node];
        [self addChild:self.capa1 z:0];
        self.capa2 = [CCLayer node];
        [self addChild:self.capa2 z:1];
        self.capa3 = [CCLayer node];
        [self addChild:self.capa3 z:3];
        
        
        [self construirFondo];
        [self construirRueda];
        [self contruirTaladro];
        
        [self contruirCronoGeneral];
        [self contruirCronoToques];
        
        _tiempoPulsando = 0;
        
        cambiarRueda = NO;
        ponerTuerca = NO;
        contadorFin = 0;
	}
	return self;
}

-(void)construirFondo
{
    
    
}

-(void)construirRueda
{
    
    [self.rueda stopAllActions];
    
    self.rueda = [CCSprite spriteWithFile:@"wheel.png"];
    self.rueda.position = ccp(-100,160);
    self.rueda.isTouchEnabled = YES;
    
    id move = [CCMoveTo actionWithDuration:1.5 position:ccp(240, 160)];
    id ease = [CCEaseIn actionWithAction:move rate:2.];
    id rotate = [CCRotateTo actionWithDuration:1.5 angle:800.];
    
    
    id actions = [CCSpawn actions:ease,rotate, nil];
    [self.rueda runAction:actions];
    [self.rueda setScale:2.0];
    
  
    
    [self.capa2 addChild:self.rueda z:2];
    
    
    self.tuerca = [CCSprite spriteWithFile:@"tuerca1.png"];
    _tuerca.position = ccp(-100,160);
    
    
    id move1 = [CCMoveTo actionWithDuration:1.5 position:ccp(240, 160)];
    id ease1 = [CCEaseIn actionWithAction:move1 rate:2.];
    id rotate1 = [CCRotateTo actionWithDuration:1.5 angle:800.];
    
    
    id actions1 = [CCSpawn actions:ease1,rotate1, nil];
    [_tuerca runAction:actions1];
    [_tuerca setScale:2.0];
    [self.capa2 addChild:_tuerca z:3];
    
}

-(void)contruirTaladro
{
    self.taladro = [CCSprite spriteWithFile:@"drill.png"];
    self.taladro.position = ccp(410, 100);
    [self.capa2 addChild:self.taladro z:4];
}

-(void)contruirCronoGeneral
{
    self.timeMinutes = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:30];
    self.timeMinutes.position = ccp( self.winSize.width /2 , self.winSize.height/2 +140);
    
    self.timeSeconds = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:30];
    self.timeSeconds.position = ccp( self.winSize.width /2 +100, self.winSize.height/2 +140);
    
    self.timeMilliseconds = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:30];
    self.timeMilliseconds.position = ccp( self.winSize.width /2+140 , self.winSize.height/2 +140);
    
    [self.capa3 addChild:self.timeMilliseconds];
    [self.capa3 addChild:self.timeMinutes];
    [self.capa3 addChild:self.timeSeconds];
    
    [self construirTimer];
    
    
}

-(void)construirTimer
{
    cronoStatus = 1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerController) userInfo:nil repeats:YES];
    
}

- (void)timerController
{
    time +=1;
    seconds = time % 60;
    minutes = (time - seconds) / 60;
    NSLog(@"%d:%.2d", minutes, seconds);
    self.time_to_send_through_game_center = minutes * 6000  +  ( seconds * 100  );
    
    
    if (timeElapsed < 60){
        timeElapsed += 0.01;
    } else {
        timeElapsed = 0;
        timeElapsed += 0.01;
        minutesElapsed += 1;
        if (minutesElapsed == 1){
            [_timeMinutes setString:[NSString stringWithFormat:@"%i MINUTE", minutesElapsed]];
        } else {
            [_timeMinutes setString:[NSString stringWithFormat:@"%i MINUTES", minutesElapsed]];
        }
    }
    
    int timeElapsedSeconds = (int) timeElapsed;
    int timeElapsedMilli = (timeElapsed - timeElapsedSeconds) * 100;
    
    // Populate Label
    if (timeElapsedSeconds < 10 && timeElapsedMilli < 10){
        
        [_timeSeconds setString:[NSString stringWithFormat:@"0%i", timeElapsedSeconds]];
        [_timeMilliseconds setString:[NSString stringWithFormat:@":0%i", timeElapsedMilli]];
        
    } else if (timeElapsedSeconds < 10 && timeElapsedMilli >= 10){
        
        [_timeSeconds setString:[NSString stringWithFormat:@"0%i", timeElapsedSeconds]];
        [_timeMilliseconds setString:[NSString stringWithFormat:@":%i", timeElapsedMilli]];
        
    } else if (timeElapsedSeconds >= 10 && timeElapsedMilli < 10){
        
        [_timeSeconds setString:[NSString stringWithFormat:@"%i", timeElapsedSeconds]];
        [_timeMilliseconds setString:[NSString stringWithFormat:@":0%i", timeElapsedMilli]];
        
    } else {
        
        [_timeSeconds setString:[NSString stringWithFormat:@"%i", timeElapsedSeconds]];
        [_timeMilliseconds setString:[NSString stringWithFormat:@":%i", timeElapsedMilli]];
    }
}

-(void)contruirCronoToques
{
    self.cuentaAtrasSegundos = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:25];
    self.cuentaAtrasSegundos.position = ccp(self.winSize.width /2-150 , self.winSize.height/2 +140 );
    
    self.cuentaAtrasMilisegundos = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:25];
    self.cuentaAtrasMilisegundos.position = ccp( self.winSize.width /2-150 , self.winSize.height/2 +100);
    
    [self.capa3 addChild:self.cuentaAtrasSegundos z:4];
    [self.capa3 addChild:self.cuentaAtrasMilisegundos z:5];
    
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];
    CGPoint touchLocationGl = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    CGRect myRect = self.tuerca.boundingBox;
    
    
    if(CGRectContainsPoint(myRect, touchLocationGl)) {
        
        NSLog(@"tocas la tuerca");
        
        self.tiempoDesatornillando = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(contadorTiempoDesatornillando) userInfo:nil repeats:YES];
        
        //contador cuando pulsas la tuerca
        self.cuentaAtras = 30;
        [self.cuentaAtrasMilisegundos setString:[NSString stringWithFormat:@""]];
        
        //giramos la tuerca cuando tocamos
        id rotate1 = [CCRotateTo actionWithDuration:3.5 angle:80000.];
        id action = [CCRepeatForever actionWithAction:rotate1];
        [_tuerca runAction:action];
        
        //ponemos el taladro cuando tocamos
        id moverTaladroATuerca = [CCMoveTo actionWithDuration:0.08 position:ccp(305,112)];
        [self.taladro runAction:moverTaladroATuerca];
        
        //recproducimos el sonido de desatornillar
        CDLongAudioSource* currentSound = [[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
        if ([currentSound isPlaying]) {
            [currentSound load:@"atornillar.wav"];
            currentSound.backgroundMusic = NO;
            [currentSound stop];
        }else{
            [currentSound load:@"atornillar.wav"];
            currentSound.backgroundMusic = NO;
            [currentSound play];
        }
    }
    
    //ponemos la tuerca si esta fuera
    if (ponerTuerca == YES) {
        [self.tuerca stopAllActions];
        id moveToCenter = [CCMoveTo actionWithDuration:0.2 position:ccp(self.winSize.width/2, self.winSize.height/2)];
        [self.tuerca runAction:moveToCenter];
        ponerTuerca = NO;
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
        
    UITouch * touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];
    CGPoint touchLocationGl = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    CGRect myRect = self.tuerca.boundingBox;
    
    
    if(!CGRectContainsPoint(myRect, touchLocationGl)) {
        
        NSLog( @"moviste");
        
        [self.tiempoDesatornillando invalidate];
        [self quitarTaladro];
        [self.tuerca stopAllActions];
        
        if (ponerTuerca == YES) {
            [self moverTuercaPorEquibocarse];
        }
        self.cuentaAtras = 30;
        _tiempoPulsando = 0;
        
        [self.cuentaAtrasMilisegundos setString:[NSString stringWithFormat:@"moviste"]];
        
        
        CDLongAudioSource* currentSound = [[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
        if ([currentSound isPlaying]) {
            [currentSound load:@"atornillar.wav"];
            currentSound.backgroundMusic = NO;
            [currentSound stop];
        }
        
    }
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];
    CGPoint touchLocationGl = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    CGRect myRect = self.tuerca.boundingBox;
    
    
    if(CGRectContainsPoint(myRect, touchLocationGl)) {
        
        [self.cuentaAtrasSegundos setString:[NSString stringWithFormat:@""]];
        
        if (_tiempoPulsando == 29 || _tiempoPulsando == 30 || _tiempoPulsando == 31) {
            
            NSLog(@"acertaste");
            
            self.swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(quitarRueda:)];
            [self.rueda addGestureRecognizer:self.swipeGestureRecognizer];
            self.swipeGestureRecognizer.direction =  UISwipeGestureRecognizerDirectionLeft;
            self.swipeGestureRecognizer.delegate = self;
            
            cambiarRueda = YES;
            
            CDLongAudioSource* currentSound = [[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
            
            if ([currentSound isPlaying]) {
                [currentSound load:@"atornillar.wav"];
                currentSound.backgroundMusic = NO;
                [currentSound stop];
            }
            
            [self.tiempoDesatornillando invalidate];
            [self.tuerca stopAllActions];
            
            [self quitarTuerca];
            [self quitarTaladro];
            if (contadorFin == 1) {
                NSLog(@"finalizado");
                [self.timer invalidate];
                [[ABGameKitHelper sharedClass] reportScore:self.time_to_send_through_game_center forLeaderboard:@"TiempoDeJuego"];
            
                [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOverScene sceneWithScore:0] withColor:ccWHITE]];
                
            }
            
            
        }else if (_tiempoPulsando>= 32){
            
            NSLog( @"te pasate");
            
            [self.tiempoDesatornillando invalidate];
            
            self.cuentaAtras = 30;
            
            _tiempoPulsando = 0;
            [self.cuentaAtrasMilisegundos setString:[NSString stringWithFormat:@"te pasaste"]];
            
            
            CDLongAudioSource* currentSound = [[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
            
            if ([currentSound isPlaying]) {
                [currentSound load:@"atornillar.wav"];
                currentSound.backgroundMusic = NO;
                [currentSound stop];
            }
            
            [self quitarTaladro];
            [self.tuerca stopAllActions];
            [self moverTuercaPorEquibocarse];
            
            
        }else if (_tiempoPulsando <= 28){
            
            NSLog(@"te quedaste corto");
            
            [self.tiempoDesatornillando invalidate];
            
            self.cuentaAtras = 30;
            
            _tiempoPulsando = 0;
            [self.cuentaAtrasMilisegundos setString:[NSString stringWithFormat:@"te quedaste corto"]];
            
            CDLongAudioSource* currentSound = [[CDAudioManager sharedManager] audioSourceForChannel:kASC_Right];
            
            if ([currentSound isPlaying]) {
                [currentSound load:@"atornillar.wav"];
                currentSound.backgroundMusic = NO;
                [currentSound stop];
            }
            [self quitarTaladro];
            [self.tuerca stopAllActions];
            [self moverTuercaPorEquibocarse];
            
        }
    }
    
}

-(void)contadorTiempoDesatornillando
{
    _tiempoPulsando+=1;
    NSLog(@"%d",_tiempoPulsando);
    
    self.cuentaAtras -= 1;
    [self.cuentaAtrasSegundos setString:[NSString stringWithFormat:@"Tiempo: %d",self.cuentaAtras]];
    
    
}

-(void)quitarTuerca
{
    id move1 = [CCMoveTo actionWithDuration:0.2 position:ccp(580, 0)];
    [self.tuerca runAction:move1];
    
}

-(void)moverTuercaPorEquibocarse
{
    id moverArriba = [CCMoveTo actionWithDuration:0.05 position:ccp(240, 165)];
    id moverAbajo = [CCMoveTo actionWithDuration:0.05 position:ccp(240, 155)];
    id vibrar = [CCSequence actions:moverArriba,moverAbajo,moverArriba,moverAbajo, nil];
    [self.tuerca runAction:vibrar];
}

-(void)quitarTaladro
{
    id moveTaladroFuera = [CCMoveTo actionWithDuration:0.08 position:ccp(410, 100)];
    [self.taladro runAction:moveTaladroFuera];
}

-(void) quitarRueda:(UISwipeGestureRecognizer *) sender
{
    
    
    if (cambiarRueda == YES) {
        
        [self.rueda stopAllActions];
        id move = [CCMoveTo actionWithDuration:0.5 position:ccp(-150, 160)];
        id ease = [CCEaseIn actionWithAction:move rate:2.];
        id rotate = [CCRotateTo actionWithDuration:0.5 angle:800.];
        
        id actions = [CCSpawn actions:ease,rotate, nil];
        
        id move1 = [CCMoveTo actionWithDuration:0.5 position:ccp(240, 160)];
        id rotate1 = [CCRotateTo actionWithDuration:0.5 angle:800.];
        
        id actions1 = [CCSpawn actions:move1,rotate1, nil];
        
        id sequence = [CCSequence actions:actions,actions1, nil];
        [self.rueda runAction:sequence];
        
        [self.rueda removeGestureRecognizer:self.swipeGestureRecognizer];
        cambiarRueda =NO;
        ponerTuerca = YES;
        contadorFin +=1;
    }
}


- (void) dealloc
{
	[super dealloc];
    
//    [self.tuerca release];
//    [self.rueda release];
//    [self.taladro release];
//    
//    [self.capa1 release];
//    [self.capa2 release];
//    [self.capa3 release];
//    
//    [self.timeMilliseconds release];
//    [self.timeMinutes release];
//    [self.timeSeconds release];
//    [self.timer release];
//    [self.tiempoDesatornillando release];
}
@end