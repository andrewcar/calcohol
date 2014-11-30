//
//  ViewController.h
//  Calcohol
//
//  Created by Andrew Carvajal on 11/17/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;

- (void)buttonPressed:(UIButton *)sender;

@end

