//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by Ankur Motreja on 9/7/16.
//  Copyright © 2016 Ankur Motreja. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *settingsTipController;
@property (strong, nonatomic) IBOutlet UIView *settingsView;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SettingsViewController viewDidLoad");
    self.title = @"Settings";
    [self updateDefaultTip];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"SettingsViewController viewWillAppear");
    [self updateDefaultTip];
    self.settingsView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.settingsView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"SettingsViewController viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"SettingsViewController viewWillDisappear");
    self.settingsView.alpha = 1;
    [UIView animateWithDuration:0.2 animations:^{
        self.settingsView.alpha = 0;
    } completion:^(BOOL finished) {
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"SettingsViewController viewDidDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onValueChange:(UISegmentedControl *)sender {
    // Save default tip value
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger selectedTipIndex = self.settingsTipController.selectedSegmentIndex;
    [defaults setInteger:selectedTipIndex forKey:@"selectedTipIndex"];
    [defaults synchronize];
}

- (void)updateDefaultTip {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger selectedTipValue = [defaults integerForKey:@"selectedTipIndex"];
    self.settingsTipController.selectedSegmentIndex = selectedTipValue;
}

@end
