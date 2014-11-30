//
//  WhiskeyViewController.h
//  Calcohol
//
//  Created by Andrew Carvajal on 11/27/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface WhiskeyViewController : ViewController <UITextFieldDelegate>

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;

@end
