//
//  AppDelegate.m
//  testword
//
//  Created by TTSiMac on 2018/12/11.
//  Copyright © 2018 tts.com. All rights reserved.
//

#import "AppDelegate.h"
#import "DisPlayXLSViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (launchOptions) {
        NSString *str = [NSString stringWithFormat:@"\n发送请求的应用程序的 Bundle ID：%@\n\n文件的NSURL：%@\n\n文件相关的属性列表对象：%@",
                         launchOptions[UIApplicationLaunchOptionsSourceApplicationKey],
                         launchOptions[UIApplicationLaunchOptionsURLKey],
                         launchOptions[UIApplicationLaunchOptionsSourceApplicationKey]];
        
        [[[UIAlertView alloc] initWithTitle:@""
                                    message:str
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil] show];
    }
    return YES;
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
//    UINavigationController *navigation = (UINavigationController *)application.keyWindow.rootViewController;
//    ViewController *displayController = (ViewController *)navigation.topViewController;
//
//    [displayController.imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
//    [displayController.label setText:sourceApplication];
    
    return YES;
}

#else
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIViewController *navigation = application.keyWindow.rootViewController;
    DisPlayXLSViewController *displayController = [[DisPlayXLSViewController alloc]init];
    displayController.fileURL = url;
    [navigation presentViewController:displayController animated:YES completion:nil];
    return YES;
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
