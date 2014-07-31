//
//  RBCBeacon.h
//  RuBeaconTest
//
//  Created by Sergey Korolev on 30.07.14.
//  Copyright (c) 2014 RuBeacon. All rights reserved.
//

@import Foundation;
@import CoreLocation;
//@import CoreBluetooth;


// Later we'll use CBPeripheralManager
//@interface RBCBeacon : NSObject<CLLocationManagerDelegate, CBPeripheralManagerDelegate>
@interface RBCBeacon : NSObject<CLLocationManagerDelegate>
- (id)initWithRegion:(NSString *)proximityUUID;
- (void) startRanging;
- (void) stopRanging;

@end
