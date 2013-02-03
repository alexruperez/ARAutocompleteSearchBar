//
//  ARViewController.h
//  ARSearchBarAutocompletionExample
//
//  Created by alexruperez on 03/02/13.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARAutocompleteSearchBar.h"

@interface ARViewController : UIViewController <UITextFieldDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet ARAutocompleteSearchBar *emailSearchBar;
@property (unsafe_unretained, nonatomic) IBOutlet ARAutocompleteSearchBar *favoriteColorSearchBar;

@end
