//
//  ARAutocompleteSearchBar.h
//  alexruperez
//
//  Created by Alejandro Rupérez on 03/02/13.
//  Inspired by HTAutocompleteTextField by HotelTonight.
//
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ARAutocompleteSearchBar;

@protocol ARAutocompleteDataSource <NSObject>

- (NSString*)searchBar:(ARAutocompleteSearchBar*)searchBar
   completionForPrefix:(NSString*)prefix
            ignoreCase:(BOOL)ignoreCase;

@end

@interface ARAutocompleteSearchBar : UISearchBar

/*
 * Designated programmatic initializer (also compatible with Interface Builder)
 */
- (id)initWithFrame:(CGRect)frame;

/*
 * Autocomplete behavior
 */
@property (nonatomic, assign) NSUInteger autocompleteType; // Can be used by the dataSource to provide different types of autocomplete behavior
@property (nonatomic, assign) BOOL autocompleteDisabled;
@property (nonatomic, assign) BOOL ignoreCase;

/*
 * Configure text field appearance
 */
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *autocompleteLabel;
- (void)setFont:(UIFont *)font;
@property (nonatomic, assign) CGPoint autocompleteTextOffset;

/*
 * Specify a data source responsible for determining autocomplete text.
 */
@property (nonatomic, assign) id<ARAutocompleteDataSource> autocompleteDataSource;
+ (void)setDefaultAutocompleteDataSource:(id<ARAutocompleteDataSource>)dataSource;

/*
 * Subclassing: override this method to alter the position of the autocomplete text
 */
- (CGRect)autocompleteRectForBounds:(CGRect)bounds;

/*
 * Refresh the autocomplete text manually (useful if you want the text to change while the user isn't editing the text)
 */
- (void)forceRefreshAutocompleteText;

@end
