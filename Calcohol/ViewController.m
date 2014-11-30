//
//  ViewController.m
//  Calcohol
//
//  Created by Andrew Carvajal on 11/17/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UILabel *beerCountLabel;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

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
    // Calls the superclass's implementation
    [super viewDidLoad];
    
    // Set our primary view's background color to Light Gray color
    self.view.backgroundColor = [UIColor blackColor];
    
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
    
    self.resultLabel.font = [UIFont fontWithName:@"Papyrus" size:22];
    self.resultLabel.textColor = [UIColor whiteColor];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    
    self.beerCountLabel.font = [UIFont fontWithName:@"Papyrus" size:42];
    self.beerCountLabel.textColor = [UIColor orangeColor];
    self.beerCountLabel.textAlignment = NSTextAlignmentCenter;
    
    self.beerPercentTextField.font = [UIFont fontWithName:@"Papyrus" size:20];
    self.beerPercentTextField.textColor = [UIColor blackColor];
    self.beerPercentTextField.textAlignment = NSTextAlignmentCenter;
    self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
    
    [self.beerPercentTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    
//    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//    NSArray *fontNames;
//    NSInteger indFamily, indFont;
//    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
//    {
//        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
//        fontNames = [[NSArray alloc] initWithArray:
//                     [UIFont fontNamesForFamilyName:
//                      [familyNames objectAtIndex:indFamily]]];
//        for (indFont=0; indFont<[fontNames count]; ++indFont)
//        {
//            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
//        }
//    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 40;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.beerCountLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.beerCountLabel.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight *2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    if (enteredNumber == 0) {
        // The user typed 0 or something that is not a number, so clear the field
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %.0f.", sender.value);
    self.beerCountLabel.text = [NSString stringWithFormat:@"%.0f", sender.value];
    // First, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // Now, calculate the equivalent value of wine...
    
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13; // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", "singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", "plural of glass");
    }
    
    self.resultLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.0f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    
    
    
    [self.beerPercentTextField resignFirstResponder];
}

- (void)buttonPressed:(UIButton *)sender {
    
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}

@end
