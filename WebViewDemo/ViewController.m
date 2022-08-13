//
//  ViewController.m
//  WebViewDemo
//
//  Created by wittyx on 7/5/22.
//

#import "ViewController.h"
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    //[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.apple.com"]]];
    //WebAppScriptMessageHandler *handler = [[WebAppScriptMessageHandler alloc]initWithDelegate:self];

    //! WKWebView
    //NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    NSString *jScript = @"window.alert('Testing')";

    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:userScript];
    [userContentController addScriptMessageHandler:self name:@"jsToOc"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;

    NSRect rect = CGRectMake(0, 0, 350, 300);
    //self.view.bounds
    _webView1 = [[WKWebView alloc] initWithFrame:rect  configuration:configuration];
    
    //_webView = [[WKWebView alloc] initWithFrame:NSZeroRect];
    [_webView1.configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    [_webView1.configuration.preferences setValue:@(YES) forKey:@"javaScriptCanAccessClipboard"];
    [_webView1.configuration.preferences setValue:@(YES) forKey:@"fullScreenEnabled"];
    [_webView1.configuration.preferences setValue:@(YES) forKey:@"DOMPasteAllowed"];
    [_webView1.configuration setValue:@YES forKey:@"allowUniversalAccessFromFileURLs"];
    
    
    _webView1.UIDelegate = self;
    _webView1.navigationDelegate = self;
    
    NSURL *myUrl = [[NSBundle mainBundle] URLForResource: @"index" withExtension:@"html"];
    [_webView1 loadRequest:[NSURLRequest requestWithURL:myUrl]];
    //[NSUserDefaults registerDefaults:]
    
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:PerferencesKey_DeveloperExtras];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Mac OS X" forKey:@"kOS"];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"TRUE", PerferencesKey_DeveloperExtras,
                                    @"Google", @"kSearchEngine", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];

    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:PerferencesKey_DeveloperExtras]);
    
    //[[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    
    [self.view addSubview:_webView1];
    //[self registerKVOObserver];
    
}

//! WKWebView Receive ScriptMessage, call this method
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name caseInsensitiveCompare:@"jsToOc"] == NSOrderedSame) {
        NSString *originUrl = message.frameInfo.request.URL.absoluteString;
        NSString *messageBody = message.body;

        NSLog(@"%@", originUrl);
        NSLog(@"%@", messageBody);
        [ViewController showAlertWithTitle:message.name message:message.body cancelHandler:nil];
    }
}

-(void) webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *testToInput = @"From XCode didFinishNavigation";
    NSString *script = [NSString stringWithFormat:@"document.getElementById('testid').innerHTML= '%@'", testToInput];
    
    
    //NSString *script = @"alert('hello world')";;
    [_webView1 evaluateJavaScript:script completionHandler:^(id response, NSError *error) {
        NSLog(@"response: %@", response);
    }];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


#pragma mark - Util functions for NSAlert. 

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelHandler:(void(^)(void))handler {
    
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSAlertStyleCritical;
    alert.messageText = @"Testing Message";
    alert.informativeText = @"OK";
    [alert runModal];

}


- (void)registerKVOObserver
{
    [NSUserDefaults.standardUserDefaults addObserver:self forKeyPath:PerferencesKey_DeveloperExtras options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
}

- (void)unregisterKVOObserver
{
    [NSUserDefaults.standardUserDefaults removeObserver:self forKeyPath:PerferencesKey_DeveloperExtras context:nil];
}


- (IBAction)clickRunJS:(id)sender {
    NSLog(@"on click");
    NSString *testToInput = @"From XCode ViewController";
    //NSString *script = [NSString stringWithFormat:@"document.body.style.backgroundColor = '#212121';", testToInput];  //work
    //NSString *script = [NSString stringWithFormat:@"document.getElementById('testid').innerHTML= '%@'", testToInput];
    NSString *script = @"testingFunction_FromXcode()";;
    [_webView1 evaluateJavaScript:script completionHandler:^(id response, NSError *error) {
        NSLog(@"response: %@", response);
    }];
    
    
}
@end
