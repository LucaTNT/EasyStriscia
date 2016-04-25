//
//  ViewController.h
//  EasyStriscia
//
//  Created by Luca Zorzi on 25/04/16.
//  Copyright © 2016 Luca Zorzi. Released under the WTFPL.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain, readwrite) NSTimer *touchTimer;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *screenshot;
@property (weak, nonatomic) IBOutlet UIView *screenshotArea;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *explainationLabel;



@end

