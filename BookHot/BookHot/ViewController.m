//
//  ViewController.m
//  BookHot
//
//  Created by Admin on 27.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import "CardController.h"
#include "SignIn.h"
@interface ViewController (){
    NSArray *resultLog;
}

@property (strong, nonatomic) IBOutlet UITextField *login;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UILabel *text;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signIn:(id)sender {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    resultLog = [app getPasswordWithLogin:[_login text]];
    if([resultLog count]>0){

        SignIn *rec = (SignIn *)[resultLog objectAtIndex:0];
        if([rec.password compare:_password.text]==0) {
        
     [self performSegueWithIdentifier:@"ShowHotel" sender:self];
     }
    else {
        [_text setText:@"Illegal data"];
    }
    }
     else {
     [_text setText:@"Illegal data"];
     }
}


@end
