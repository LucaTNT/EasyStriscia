//
//  ViewController.m
//  EasyStriscia
//
//  Created by Luca Zorzi on 25/04/16.
//  Copyright © 2016 Luca Zorzi. Released under the WTFPL.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageHasChanged = NO;
    self.currentImage = @"Luca.png";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)moveImage:(NSTimer*)userData
{
    self.icon.hidden = NO;
    self.shareButton.enabled = YES;
    
    [self fadeLabelToAlpha:0.0];

    UITouch *touched = [userData userInfo];
    CGPoint location = [touched locationInView:touched.view];
    
    if (self.imageHasChanged)
    {
        self.icon.image = [UIImage imageNamed:self.currentImage];
        self.imageHasChanged = NO;
    }
    
    // Move the image
    self.icon.center = location;
    
}

-(void)fadeLabelToAlpha:(float)alpha
{
    if (self.explainationLabel.alpha != alpha)
    {
        [UILabel beginAnimations:NULL context:nil];
        [UILabel setAnimationDuration:0.2];
        [self.explainationLabel setAlpha:alpha];
        [UILabel commitAnimations];
    }
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
    [self fadeLabelToAlpha:0.5];
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
    switch (sender.tag)
    {
        case 1:
            self.currentImage = @"Luca.png";
            self.imageHasChanged = YES;
            break;
            
        case 2:
            self.currentImage = @"Fede.png";
            self.imageHasChanged = YES;
            break;
            
        default:
            break;
    }
}
@end
