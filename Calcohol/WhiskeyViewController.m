//
//  WhiskeyViewController.m
//  Calcohol
//
//  Created by Andrew Carvajal on 11/27/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UILabel *beerCountLabel;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation WhiskeyViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Whiskey", nil);
    }
    return self;
}

- (void)loadView {
    // Allocate and initialize the all-encompassing view.
    self.view = [[UIView alloc] init];
    
    // Allocate and initialize each of our views and the gesture recognizer.
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UILabel *beerCount = [[UILabel alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addSubview:beerCount];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.beerCountLabel = beerCount;
    self.hideKeyboardTapGestureRecognizer = tap;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set our primary view's background color to Light Gray color
    self.view.backgroundColor = [UIColor brownColor];
    
    // Tells the text field that self, this instance of "ViewController" should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"Alcohol Content For Beer", @"Beer percent placeholder text");
    
    // Tells self.beerCountSlider that when its value changes, it should call [self -sliderValueDidChange:]
    // This is equivalent to connecting the IBAction in our previous checkpoint.
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tells the tap gesture recognizer to call [self tapGestureDidFire:] when it detects a tap
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Get rid of the max number of lines on the result label
    self.resultLabel.numberOfLines = 0;
    self.beerCountLabel.numberOfLines = 0;
    
    
    /* Change the font, text color and alignment of the resultLabel */
    self.resultLabel.font = [UIFont fontWithName:@"Papyrus" size:22];
    self.resultLabel.textColor = [UIColor whiteColor];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    
    /* Change the font, text color and alignment of the beerCountLabel */
    self.beerCountLabel.font = [UIFont fontWithName:@"Papyrus" size:42];
    self.beerCountLabel.textColor = [UIColor orangeColor];
    self.beerCountLabel.textAlignment = NSTextAlignmentCenter;
    
    /* Change the font, text color, alignment, background color and placeholder text of the beerPercentTextField */
    self.beerPercentTextField.font = [UIFont fontWithName:@"Papyrus" size:20];
    self.beerPercentTextField.textColor = [UIColor blackColor];
    self.beerPercentTextField.textAlignment = NSTextAlignmentCenter;
    self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
    [self.beerPercentTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.view.backgroundColor = [UIColor colorWithRed:0.992 green:0.992 blue:0.588 alpha:1]; /*#fdfd96*/

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    /* Establish values */
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 40;
    
    /* Place the beerPercentTextField at the top left +20 on each side */
    self.beerPercentTextField.frame = CGRectMake(padding, padding *4, itemWidth, itemHeight);
    
    /* Place the beerCountSlider at the bottom of the text field +20 */
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    /* Place the beerCountLabel at the bottom of the slider +20 */
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.beerCountLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
    
    /* Place the resultLabel at the bottom of the beerCountLabel +20 */
    CGFloat bottomOfLabel = CGRectGetMaxY(self.beerCountLabel.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight *2);
}

- (void)textFieldDidChange:(UITextField *)sender {
    // Make sure the text is a number
    
    /* Make a string for sender.text */
    NSString *enteredText = sender.text;
    
    /* Convert that text into a float */
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0 or something that is not a number, so clear the field
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; // assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = alcoholPercentageOfBeer * ouncesInOneBeerGlass;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1; // a 1oz shot
    float alcoholPercentageOfWhiskey = 0.4; // 40% is average
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", "singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", "plural of shot");
    }
    
    self.resultLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.0f %@ of whiskey.", nil), numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    
    /* Update the title */
    self.title = [NSString stringWithFormat:NSLocalizedString(@"Whiskey (%.0f %@)", nil), numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    
    /* Assign sender.value's int form to whiskeyVC's tab bar item */
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int)sender.value]];
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}

@end
