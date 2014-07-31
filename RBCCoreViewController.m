//
//  RBCCoreViewController.m
//  RuBeaconCore
//
//  Created by Sergey Korolev on 30.07.14.
//  Copyright (c) 2014 RuBeacon. All rights reserved.
//

#import "RBCCoreViewController.h"
#import "RBCBeacon.h"

@interface RBCCoreViewController ()
@property RBCBeacon *beacon;

@end

@implementation RBCCoreViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)initButton:(id)sender {
    self.beacon = [[RBCBeacon alloc] init];
    
}

- (IBAction)startButton:(id)sender {
    [self.beacon start];
    


}

- (IBAction)stopButton:(id)sender {
    [self.beacon stop];
}
@end
