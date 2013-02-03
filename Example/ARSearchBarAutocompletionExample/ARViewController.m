//
//  ARViewController.m
//  ARSearchBarAutocompletionExample
//
//  Created by alexruperez on 03/02/13.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import "ARViewController.h"
#import "ARAutocompleteManager.h"

@interface ARViewController ()

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set a default data source for all instances.  Otherwise, you can specify the data source on individual search bars via the autocompleteDataSource property
    [ARAutocompleteSearchBar setDefaultAutocompleteDataSource:[ARAutocompleteManager sharedManager]];
    
    self.lastSearchBar.autocompleteType = ARAutocompleteTypeLast;
    self.lastSearchBar.textField.delegate = self;
    
    self.emailSearchBar.autocompleteType = ARAutocompleteTypeEmail;
    self.emailSearchBar.textField.delegate = self;
    
    self.favoriteColorSearchBar.autocompleteType = ARAutocompleteTypeColor;
    self.favoriteColorSearchBar.ignoreCase = NO;
    self.favoriteColorSearchBar.textField.delegate = self;
    
    // Dismiss the keyboard when the user taps outside of a search bar
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewDidUnload
{
    [self setLastSearchBar:nil];
    [self setEmailSearchBar:nil];
    [self setFavoriteColorSearchBar:nil];
    
    [super viewDidUnload];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self textFieldShouldReturn:self.lastSearchBar.textField];
    [self textFieldShouldReturn:self.emailSearchBar.textField];
    [self textFieldShouldReturn:self.favoriteColorSearchBar.textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.lastSearchBar.textField) && ([textField.text length] > 0))
        [[[ARAutocompleteManager sharedManager] lastAutocompleteArray] addObject:textField.text];
    [textField resignFirstResponder];
    return YES;
}

@end
