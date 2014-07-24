//
//  ViewController.m
//  MySafari
//
//  Created by Nicolas Semenas on 23/07/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end
@implementation ViewController

- (IBAction)onBackButtonPressed:(id)sender {
    
    [self.myWebView goBack];

}

- (IBAction)onForwardButtonPressed:(id)sender {
    
    [self.myWebView goForward];

}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.myWebView stopLoading];

}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.myWebView reload];

}
- (IBAction)onNew:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming Soon!"
                                                    message:@"We are working on this..."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}
- (IBAction)onClearButtonPressed:(id)sender {
    self.myURLTextField.text = @"";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationController.navigationBar.topItem.title = @"YourTitle";
    
    self.myURLTextField.text = _myWebView.request.URL.absoluteString;
    
    
    if ( [ self.myWebView canGoBack ]) {
        self.backButton.enabled = true;
    } else {
        self.backButton.enabled = false;

    }
    
    if ( [ self.myWebView canGoForward ]) {
        self.forwardButton.enabled = true;
        
    }else {
        self.forwardButton.enabled = false;
        }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backButton.enabled = false;
    self.forwardButton.enabled = false;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.myURLTextField resignFirstResponder];
    

    if (![self.myURLTextField.text hasPrefix:@"http"]) {
        
        self.myURLTextField.text = [NSString stringWithFormat:@"http://%@", self.myURLTextField.text];
    }
    
    NSURL *url = [[NSURL alloc] initWithString:self.myURLTextField.text];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    
    return YES;

}



@end
