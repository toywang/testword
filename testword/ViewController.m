//
//  ViewController.m
//  testword
//
//  Created by TTSiMac on 2018/12/11.
//  Copyright © 2018 tts.com. All rights reserved.
//



#import "ViewController.h"
#import <QuickLook/QuickLook.h>

@interface ZZDocument : UIDocument
@property (nonatomic, strong) NSData *data;
@end
@implementation ZZDocument

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    self.data = contents;
    return YES;
}


@end



typedef void(^downloadBlock)(id obj);

@interface iCloudManager : NSObject

+ (BOOL)iCloudEnable;

+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block;

@end
@implementation iCloudManager

+ (BOOL)iCloudEnable {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    
    if (url != nil) {
        return YES;
    }
    
    NSLog(@"iCloud 不可用");
    return NO;
}
+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block {
    
    ZZDocument *iCloudDoc = [[ZZDocument alloc]initWithFileURL:url];
    
    [iCloudDoc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            
            [iCloudDoc closeWithCompletionHandler:^(BOOL success) {
                NSLog(@"关闭成功");
            }];
            
            if (block) {
                block(iCloudDoc.data);
            }
            
        }
    }];
}

@end


@interface ViewController ()<UIDocumentPickerDelegate,QLPreviewControllerDataSource>

@property (nonatomic,strong) UIButton *opentICloudButton;
@property (nonatomic,strong)  QLPreviewController *previewController;
@property (nonatomic,copy) NSString *filePath;
@property (nonatomic,strong) NSURL *fileURL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.opentICloudButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.opentICloudButton.frame = CGRectMake(0, 0, 100, 200);
    [self.opentICloudButton setTitle:@"打开iCloud" forState:UIControlStateNormal];
    [self.opentICloudButton addTarget:self action:@selector(openclick:) forControlEvents:UIControlEventTouchUpInside];
    self.opentICloudButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.opentICloudButton];
   self.previewController = [[QLPreviewController alloc] init];
    self.previewController.view.frame = CGRectMake(0, 200,self.view.frame.size.width, self.view.frame.size.height-200);
    self.previewController.dataSource = self;
    [self addChildViewController:self.previewController];
    [self.view addSubview:self.previewController.view];

}
- (void)openclick:(UIButton *)sender
{
    [self presentDocumentPicker];
}
- (void)presentDocumentPicker {
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
    
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes
                                                                                                                          inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;
    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
    NSString *fileName = [array lastObject];
    fileName = [fileName stringByRemovingPercentEncoding];
    self.fileURL = url;
    if ([iCloudManager iCloudEnable]) {
        [iCloudManager downloadWithDocumentURL:url callBack:^(id obj) {
            NSData *data = obj;
            
            //写入沙盒Documents
            self.filePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",fileName]];
            [data writeToFile:self.filePath atomically:YES];
            [self.previewController reloadData];
          
        }];
    }
}
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    //需要在线预览的文件的路径
    if (self.fileURL) {
        return self.fileURL;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
