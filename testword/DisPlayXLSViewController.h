//
//  DisPlayXLSViewController.h
//  testword
//
//  Created by TTSiMac on 2018/12/11.
//  Copyright © 2018 tts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>


@interface DisPlayXLSViewController : UIViewController


@property (nonatomic,strong)  QLPreviewController *previewController;
@property (nonatomic,strong) NSURL *fileURL;

@end
