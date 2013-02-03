# ARAutocompleteSearchBar

## Overview

ARAutocompleteSearchBar is a subclass of UISearchBar that automatically displays text suggestions in real-time.  This is perfect for automatically suggesting the domain as a user types an email address.

Inspired by [HotelTonight](https://github.com/hoteltonight)/[HTAutocompleteTextField](https://github.com/hoteltonight/HTAutocompleteTextField). You can see it in action in the animated gif below or on [Youtube](http://youtu.be/lzqB4MXluvY):

<img src="https://raw.github.com/hoteltonight/HTAutocompleteTextField/master/demo.gif" alt="HotelTonight" title="HTAutocompleteTextField in action" style="display:block; margin: 10px auto 30px auto; align:center">

# Usage

## Installation

### Add the following files to your project:
* `ARAutocompleteSearchBar.m`
* `ARAutocompleteSearchBar.h`
* `ARAutocompleteManager.m` and `ARAutocompleteManager.h`

## Quickstart Guide

Create an `ARAutocompleteSearchBar` instance exactly as as you would `UISearchBar`.  You can do eith either programmitcally or in Interface Builder.  Programmatically, this looks like:

    ARAutocompleteSearchBar *searchBar = [[ARAutocompleteSearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)];

The data source is the brains of the autocomplete logic.  If you just want to autocomplete email addresses, use `ARAutocompleteManager` from the example project as follows:

    searchBar.autocompleteDataSource = [ARAutocompleteManager sharedManager];
    searchBar.autocompleteType = ARAutocompleteTypeEmail;

## Customization

### Autocompletion Data Source

`ARAutocompleteManager` (included in the example project) provides email address autocompletion out of the box.  It comes with a list of the top email domains.  You may want to tailor this list of email domains to match your own customers, or you may want to write autocomplete logic for a different type of search bar (in the demo, names of colors are autocompleted).
You can also autocomplete the keywords of the latest queries in the search bar, search something in the demo search bar, clear it and search again the same keywords.

Alternatively, you may wish to create your own data source class and user the `autocompleteType` property to differentiate between fields with different data types.  A `ARAutocompleteSearchBar`'s data source must implement the following method, as part of the `ARAutocompleteDataSource` protocol.

    - (NSString*)searchBar:(ARAutocompleteSearchBar*)searchBar completionForPrefix:(NSString*)prefix ignoreCase:(BOOL)ignoreCase

You may also set a default `dataSource` for all instances of `ARAutocompleteSearchBar`.  In the example project, we use a `ARAutocompleteManager` singleton:

     [autocompleteTextOffset setDefaultAutocompleteDataSource:[ARAutocompleteManager sharedManager]];

### Positioning and Formatting

To adjust the position of the autocomplete label by a fixed amount, set `autocompleteTextOffset`:

    searchBar.autocompleteTextOffset = CGPointMake(10.0, 10.0);

For more dynamic positioning of the autocomplete label, subclass `ARAutocompleteSearchBar` and override `- (CGRect)autocompleteRectForBounds:(CGRect)bounds`.

To adjust the properties (i.e. `font`, `textColor`) of the autocomplete label, do so via the `[ARAutocompleteSearchBar autocompleteLabel] property.

    searchBar.autocompleteLabel.textColor = [UIColor grayColor];
    
# Etc.

* Use this in your apps whenever you can, particularly email addresses -- your users will appreciate it!
* Contributions are very welcome.
* Known Issues: Clear button not working yet...
* Attribution is appreciated (let's spread the word!), but not mandatory.
