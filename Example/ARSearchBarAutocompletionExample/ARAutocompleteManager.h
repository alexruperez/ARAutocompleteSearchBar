//
//  ARAutocompleteManager.h
//  alexruperez
//
//  Created by Alejandro Rupérez on 03/02/13.
//  Inspired by HTAutocompleteManager by HotelTonight.
//
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARAutocompleteSearchBar.h"

typedef enum {
    ARAutocompleteTypeLast,
    ARAutocompleteTypeEmail, // Default
    ARAutocompleteTypeColor,
} ARAutocompleteType;

@interface ARAutocompleteManager : NSObject <ARAutocompleteDataSource>

@property (strong, nonatomic) NSMutableArray *lastAutocompleteArray;

+ (ARAutocompleteManager *)sharedManager;

@end
