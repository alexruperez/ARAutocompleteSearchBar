//
//  ARAutocompleteSearchBar.m
//  alexruperez
//
//  Created by Alejandro Rupérez on 03/02/13.
//  Inspired by HTAutocompleteTextField by HotelTonight.
//
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import "ARAutocompleteSearchBar.h"

static NSObject<ARAutocompleteDataSource> *DefaultAutocompleteDataSource = nil;

@interface ARAutocompleteSearchBar ()

@property (nonatomic, strong) NSString *autocompleteString;

@end

@implementation ARAutocompleteSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupAutocompleteSearchBar];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupAutocompleteSearchBar];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:self.textField];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)setupAutocompleteSearchBar
{
    for (UIView *searchSubview in self.subviews) {
        if ([searchSubview isKindOfClass:[UITextField class]]) {
            self.textField = (UITextField*)searchSubview;
            break;
        }
    }
    
    self.autocompleteLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.autocompleteLabel.font = self.textField.font;
    self.autocompleteLabel.backgroundColor = [UIColor clearColor];
    self.autocompleteLabel.textColor = [UIColor lightGrayColor];
    self.autocompleteLabel.lineBreakMode = NSLineBreakByClipping;
    self.autocompleteLabel.hidden = YES;
    [self.textField setClearButtonMode:UITextFieldViewModeNever]; // Not working yet...
    [self.textField addSubview:self.autocompleteLabel];
    [self.textField bringSubviewToFront:self.autocompleteLabel];
    
    self.autocompleteString = @"";
    
    self.ignoreCase = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeFirstResponder) name:UITextFieldTextDidBeginEditingNotification object:self.textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ar_textDidChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

#pragma mark - Configuration

+ (void)setDefaultAutocompleteDataSource:(id)dataSource
{
    DefaultAutocompleteDataSource = dataSource;
}

- (void)setFont:(UIFont *)font
{
    [self.textField setFont:font];
    [self.autocompleteLabel setFont:font];
}

#pragma mark - UIResponder

- (BOOL)becomeFirstResponder
{
    if (!self.autocompleteDisabled)
    {
        if ([self.textField clearsOnBeginEditing])
        {
            self.autocompleteLabel.text = @"";
        }
        
        self.autocompleteLabel.hidden = NO;
    }
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    if ((self.isFirstResponder) && (!self.autocompleteDisabled))
    {
        self.autocompleteLabel.hidden = YES;
        
        [self commitAutocompleteText];
        
        // This is necessary because committing the autocomplete text changes the text field's text, but for some reason UITextField doesn't post the UITextFieldTextDidChangeNotification notification on its own
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textField];
    }
    
    return [super resignFirstResponder];
}

#pragma mark - Autocomplete Logic

- (CGRect)autocompleteRectForBounds:(CGRect)bounds
{
    CGRect returnRect = CGRectZero;
    CGRect textRect = [self.textField textRectForBounds:self.textField.bounds];
    
    CGSize prefixTextSize = [self.text sizeWithFont:self.textField.font constrainedToSize:textRect.size lineBreakMode:NSLineBreakByCharWrapping];
    
    CGSize autocompleteTextSize = [self.autocompleteString sizeWithFont:self.textField.font constrainedToSize:CGSizeMake(textRect.size.width-prefixTextSize.width, textRect.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    
    returnRect = CGRectMake(textRect.origin.x + prefixTextSize.width + self.autocompleteTextOffset.x, self.autocompleteTextOffset.y, autocompleteTextSize.width, textRect.size.height);
    
    return returnRect;
}

- (void)ar_textDidChange:(NSNotification*)notification
{
    [self refreshAutocompleteText];
}

- (void)updateAutocompleteLabel
{
    [self.autocompleteLabel setText:self.autocompleteString];
    [self.autocompleteLabel sizeToFit];
    [self.autocompleteLabel setFrame: [self autocompleteRectForBounds:self.textField.bounds]];
}

- (void)refreshAutocompleteText
{
    if (!self.autocompleteDisabled)
    {
        id <ARAutocompleteDataSource> dataSource = nil;
        
        if ([self.autocompleteDataSource respondsToSelector:@selector(searchBar:completionForPrefix:ignoreCase:)])
        {
            dataSource = (id <ARAutocompleteDataSource>)self.autocompleteDataSource;
        }
        else if ([DefaultAutocompleteDataSource respondsToSelector:@selector(searchBar:completionForPrefix:ignoreCase:)])
        {
            dataSource = DefaultAutocompleteDataSource;
        }
        
        if (dataSource)
        {
            self.autocompleteString = [dataSource searchBar:self completionForPrefix:self.text ignoreCase:self.ignoreCase];
            
            [self updateAutocompleteLabel];
        }
    }
}

- (void)commitAutocompleteText
{
    if ([self.autocompleteString isEqualToString:@""] == NO
        && self.autocompleteDisabled == NO)
    {
        self.text = [NSString stringWithFormat:@"%@%@", self.text, self.autocompleteString];
        
        self.autocompleteString = @"";
        [self updateAutocompleteLabel];
    }
}

- (void)forceRefreshAutocompleteText
{
    [self refreshAutocompleteText];
}

@end
