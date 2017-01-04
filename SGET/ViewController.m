//
//  ViewController.m
//  SGET
//
//  Created by BRABUS on 1/3/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property double aValue;
@property double bValue;
@property double cValue;
@property (weak, nonatomic) IBOutlet UITextField *aTextField;
@property (weak, nonatomic) IBOutlet UITextField *bTextField;
@property (weak, nonatomic) IBOutlet UITextField *cTextField;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UILabel *resultOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultTwoLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculateButton.hidden = YES;
}

- (IBAction)beginCalculation:(id)sender {
    self.aValue = [self.aTextField.text doubleValue];
    self.bValue = [self.bTextField.text doubleValue];
    self.cValue = [self.cTextField.text doubleValue];
    [self decrementCalculation];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.calculateButton.hidden = YES;
    textField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self validationOnlyNumbers:self.aTextField] && ([self.aTextField.text intValue] != 0) && [self validationOnlyNumbers:self.bTextField] && [self validationOnlyNumbers:self.cTextField]) {
        self.calculateButton.hidden = NO;
        [self.view endEditing:YES];
    }
    return YES;
}
#pragma mark - verifications
- (BOOL)validationOnlyNumbers:(UITextField *)inputText {
    BOOL valid;
    valid = [inputText.text intValue];
//    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
//    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:inputText.text];
//    valid = [alphaNums isSupersetOfSet:inStringSet];
    return valid;
}
#pragma mark - logic
- (void)decrementCalculation {
    //b in square
    double bValueInSquare = (self.bValue * self.bValue);
    //4ac
    double aValueMCValueMFour = 4 * self.aValue * self.cValue;
    //decrement calc: b^2 - 4ac
    double decrementValue = bValueInSquare - aValueMCValueMFour;
    NSLog(@"%f", decrementValue);
    if (decrementValue == 0) {
        [self oneSquareScenario:decrementValue];
    }
    else if (decrementValue > 0) {
        [self twoSquaresScenario:decrementValue];
    }
    else {
        //when there is no squares in equation - nothing to calculate
        self.resultOneLabel.text = self.resultTwoLabel.text = @"...";
    }
}
//If there is only one square in equation
- (void)oneSquareScenario:(int)decrement {
    double resultX = (-self.bValue + sqrt(decrement)) / (self.aValue * 2);
    [self viewResultWithFirstValue:(int)resultX secondValue:0];
}
//If we got two squares in equation
- (void)twoSquaresScenario:(int)decrement {
    double firstX = (-self.bValue + sqrt(decrement)) / (self.aValue * 2);
    double secontX = (-self.bValue - sqrt(decrement)) / (self.aValue * 2);
    [self viewResultWithFirstValue:(int)firstX secondValue:(int)secontX];
}
#pragma mark - presentation of results
- (void)viewResultWithFirstValue:(int)resultOne secondValue:(int)resultTwo {
    self.resultOneLabel.text = [NSString stringWithFormat:@"%i", resultOne];
    if (resultTwo == 0) {
        self.resultTwoLabel.text = @"...";
    }
    else {
        self.resultTwoLabel.text = [NSString stringWithFormat:@"%i", resultTwo];
    }
}
@end
