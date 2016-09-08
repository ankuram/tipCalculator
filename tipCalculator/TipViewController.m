//
//  ViewController.m
//  tipCalculator
//
//  Created by Ankur Motreja on 9/6/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (strong, nonatomic) IBOutlet UIView *tipCalculatorView;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"TipViewController viewDidLoad");
    self.title = @"Tip Calculator";
    [self getDefaultTipValue];
    [self getDefaultBillValue];
    [self updateValues];
    [_billTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"TipViewController viewWillAppear");
    [self getDefaultTipValue];
    [self updateValues];
    self.tipCalculatorView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.tipCalculatorView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"TipViewController viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"TipViewController viewWillDisappear");
    self.tipCalculatorView.alpha = 1;
    [UIView animateWithDuration:0.2 animations:^{
        self.tipCalculatorView.alpha = 0;
    } completion:^(BOOL finished) {
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"TipViewController viewDidDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onValueChange:(UISegmentedControl *)sender {
    [self updateValues];
}

- (void)updateValues {
    //Get bill amount
    float billAmount = [self.billTextField.text floatValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:billAmount forKey:@"billAmount"];
    [defaults setObject:[NSDate date] forKey:@"billDate"];
    [defaults synchronize];
    
    
    //Compute the tip and total
    NSArray *tipValues = @[@(0.15), @(0.2), @(0.25)];
    float tipAmount = [tipValues[self.tipControl.selectedSegmentIndex] floatValue] * billAmount;
    float totalAmount = billAmount + tipAmount;
    
    //Update the UI
    NSString *currencySymbol = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
    
    self.tipLabel.alpha = 1;
    self.totalLabel.alpha = 1;
    [UILabel animateWithDuration:0.3 animations:^{
        self.tipLabel.alpha = 0;
        self.totalLabel.alpha = 0;
    } completion:^(BOOL finished) {
        NSString *tipAmountString = [NSString localizedStringWithFormat:@"%0.2f", tipAmount];
        self.tipLabel.text = [NSString stringWithFormat:@"%@%@", currencySymbol, tipAmountString];
        
        NSString *totalAmountString = [NSString localizedStringWithFormat:@"%0.2f", totalAmount];
        self.totalLabel.text = [NSString stringWithFormat:@"%@%@", currencySymbol, totalAmountString];
        
        [UILabel animateWithDuration:0.3 animations:^{
            self.tipLabel.alpha = 1;
            self.totalLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)getDefaultTipValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger selectedTipIndex = [defaults integerForKey:@"selectedTipIndex"];
    self.tipControl.selectedSegmentIndex = selectedTipIndex;
}

- (void)getDefaultBillValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float billAmount = [defaults integerForKey:@"billAmount"];
    NSDate *billDate = [defaults objectForKey:@"billDate"];
    
    NSTimeInterval diff = fabs([billDate timeIntervalSinceNow]);
    if (diff < 600) { // 10 minutes
        self.billTextField.text = [NSString stringWithFormat:@"%0.0f", billAmount];
    }
}

@end
