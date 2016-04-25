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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)moveImage:(NSTimer*)userData
{
    self.icon.hidden = NO;
    self.shareButton.enabled = YES;

    UITouch *touched = [userData userInfo];
    CGPoint location = [touched locationInView:touched.view];
    
    // Move the image
    self.icon.center = location;
}

- (IBAction)shareImage:(id)sender
{
    NSMutableArray *sharingItems = [NSMutableArray new];

    [sharingItems addObject:self.screenshot.image];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    
    // Ugly hack to position popover
    UIView *popoverView = [[UIView alloc]initWithFrame:CGRectMake(self.shareButton.imageView.bounds.origin.x*3, self.shareButton.imageView.bounds.origin.y + self.shareButton.imageView.bounds.size.height*1.2, 1, 1)];
    [self.shareButton.imageView addSubview:popoverView];
    
    activityController.popoverPresentationController.sourceView = popoverView;
    
    [self presentViewController:activityController animated:YES completion:nil];
}

-(void)handleTouchEvent:(UIEvent *)event
{
    [self captureScreen];
    UITouch *touched = [[event allTouches] anyObject];
    
    if (!self.touchTimer.isValid)
    {
        self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.0167 target:self selector:@selector(moveImage:) userInfo:touched repeats:YES];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleTouchEvent:event];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleTouchEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.touchTimer invalidate];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.touchTimer invalidate];
}

-(IBAction)emptyScreenshot
{
    self.screenshot.image = [UIImage imageNamed:@"Transparent.png"];
    self.icon.hidden = YES;
    self.shareButton.enabled = NO;
}


-(void)captureScreen
{
    UIGraphicsBeginImageContextWithOptions(self.screenshotArea.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self.screenshotArea drawViewHierarchyInRect:self.screenshotArea.bounds afterScreenUpdates:NO];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.screenshot.image = img;
}

- (IBAction)changeImage:(UIButton *)sender
{
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
