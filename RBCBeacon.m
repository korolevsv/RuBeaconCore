//
//  RBCBeacon.m
//  RuBeaconTest
//
//  Created by Sergey Korolev on 30.07.14.
//  Copyright (c) 2014 RuBeacon. All rights reserved.
//

#import "RBCBeacon.h"

//Stick-N-Find UUID:
static NSString * const kUUID = @"9F4916B1-0864-49BC-8F09-1445F9FABDEF";
static NSString * const kIdentifier = @"SomeIdentifier";


@interface RBCBeacon ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
//@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) NSArray *detectedBeacons;
/*@property (nonatomic, weak) UISwitch *monitoringSwitch;
@property (nonatomic, weak) UISwitch *advertisingSwitch;
@property (nonatomic, weak) UISwitch *rangingSwitch;
@property (nonatomic, unsafe_unretained) void *operationContext;
*/
- (void)reportMajors:(NSArray *)beacons;

@end


@implementation RBCBeacon

- (id)init {
    self = [super init];
    [self createLocationManager];
    [self createBeaconRegion];
    NSLog(@"LocationManager initialized");
    return self;
}

- (void) start {
//    [self startRangingForBeacons];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    NSLog(@"Ranging turned on for region: %@.", self.beaconRegion);
}
- (void) stop {
    [self stopRangingForBeacons];
}

- (void)createBeaconRegion
{
    if (self.beaconRegion)
        return;
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:kUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:kIdentifier];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
}

- (void)createLocationManager
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
}

#pragma mark - Beacon ranging
- (void)changeRangingState:sender
{
    UISwitch *theSwitch = (UISwitch *)sender;
    if (theSwitch.on) {
        [self startRangingForBeacons];
    } else {
        [self stopRangingForBeacons];
    }
}

- (void)startRangingForBeacons
{
//    self.operationContext = kRangingOperationContext;
// Create (if did not creae with Init)
    [self createLocationManager];
    
    [self startRangingForBeacons];
    
    self.detectedBeacons = [NSArray array];
    [self turnOnRanging];
}

- (void)turnOnRanging
{
    NSLog(@"Turning on ranging...");
    
    if (![CLLocationManager isRangingAvailable]) {
        NSLog(@"Couldn't turn on ranging: Ranging is not available.");
        return;
    }
    
    if (self.locationManager.rangedRegions.count > 0) {
        NSLog(@"Didn't turn on ranging: Ranging already on.");
        return;
    }
    
    [self createBeaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    
    NSLog(@"Ranging turned on for region: %@.", self.beaconRegion);
}

- (void)stopRangingForBeacons
{
    if (self.locationManager.rangedRegions.count == 0) {
        NSLog(@"Didn't turn off ranging: Ranging already off.");
        return;
    }
    
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    NSLog(@"Turned off ranging.");
}


- (NSArray *)filteredBeacons:(NSArray *)beacons
{
    // Filters duplicate beacons out; this may happen temporarily if the originating device changes its Bluetooth id
    NSMutableArray *mutableBeacons = [beacons mutableCopy];
    
    NSMutableSet *lookup = [[NSMutableSet alloc] init];
    for (int index = 0; index < [beacons count]; index++) {
        CLBeacon *curr = [beacons objectAtIndex:index];
        NSString *identifier = [NSString stringWithFormat:@"%@/%@", curr.major, curr.minor];
        
        // this is very fast constant time lookup in a hash table
        if ([lookup containsObject:identifier]) {
            [mutableBeacons removeObjectAtIndex:index];
        } else {
            [lookup addObject:identifier];
        }
    }
    
    return [mutableBeacons copy];
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    NSArray *filteredBeacons = [self filteredBeacons:beacons];
    
    if (filteredBeacons.count == 0) {
        NSLog(@"No beacons found nearby.");
    } else {
        NSLog(@"Found %lu %@.", (unsigned long)[filteredBeacons count],
              [filteredBeacons count] > 1 ? @"beacons" : @"beacon");
    }
    self.detectedBeacons = filteredBeacons;
    [self reportMajors:self.detectedBeacons];
}

- (void)reportMajors:(NSArray *)beacons {
    NSLog(@"Reporting majors");
    for (NSUInteger number = 0; number < beacons.count; number++) {
        CLBeacon *currBeacon = [beacons objectAtIndex:number];
        NSString *identifier = [NSString stringWithFormat:@"%@ ", currBeacon.major];
        NSLog(identifier);
    }
}

@end
