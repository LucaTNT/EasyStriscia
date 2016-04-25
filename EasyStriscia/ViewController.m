//
//  ViewController.m
//  EasyStriscia
//
//  Created by Luca Zorzi on 25/04/16.
//  Copyright © 2016 Luca Zorzi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"LOADED");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)moveImage:(NSTimer*)userData
{
    self.icon.hidden = NO;

    UITouch *touched = [userData userInfo];
    CGPoint location = [touched locationInView:touched.view];
    NSLog(@"Boosting x=%.2f y=%.2f", location.x, location.y);
    self.icon.center = location;
    
}


-(void)handleTouchEvent:(UIEvent *)event
{
    [self captureScreen];
    //NSLog(@"moved");
    // First we need to trigger a boost in case the screen was just touched.
    UITouch *touched = [[event allTouches] anyObject];
    
    
    
    //set a timer to keep boosting if the touch continues.
    //Also check there isn't already a timer running for this.
    if (!self.touchTimer.isValid) {
        self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.0167 target:self selector:@selector(moveImage:) userInfo:touched repeats:YES];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleTouchEvent:event];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouchEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"edned");
    [self.touchTimer invalidate];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"cancelled");
    [self.touchTimer invalidate];
}


- (UIImage *) captureScreen
{
    /*
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();*/
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.screenshot.image = img;
    
    return img;
}

- (IBAction)changeImage:(UIButton *)sender {
    self.icon.hidden = YES;
    switch (sender.tag)
    {
        case 1:
            NSLog(@"Changed to Luca");
            self.icon.image = [UIImage imageNamed:@"Luca.png"];
            break;
            
        case 2:
            NSLog(@"Changed to Fede");
            self.icon.image = [UIImage imageNamed:@"Fede.png"];
            break;
            
        default:
            break;
    }
}
@end
