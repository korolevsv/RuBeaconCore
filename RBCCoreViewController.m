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
//Stick-N-Find UUID:
static NSString * const defaultUUID = @"9F4916B1-0864-49BC-8F09-1445F9FABDEF";

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
//    self.beacon = [[RBCBeacon alloc] init];
    self.beacon = [[RBCBeacon alloc] initWithRegion:defaultUUID];
}

- (IBAction)startButton:(id)sender {
    [self.beacon startRanging];
}

- (IBAction)stopButton:(id)sender {
    [self.beacon stopRanging];
}
@end
