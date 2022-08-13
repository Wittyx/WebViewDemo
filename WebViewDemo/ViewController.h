//
//  ViewController.h
//  WebViewDemo
//
//  Created by wittyx on 7/5/22.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

static NSString* PerferencesKey_DeveloperExtras = @"WebKitDeveloperExtras";


@interface ViewController : NSViewController <WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>

@property (weak) IBOutlet WKWebView *webView;

@property (strong) WKWebView *webView1;
- (IBAction)clickRunJS:(id)sender;

@end

