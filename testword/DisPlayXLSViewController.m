//
//  DisPlayXLSViewController.m
//  testword
//
//  Created by TTSiMac on 2018/12/11.
//  Copyright © 2018 tts.com. All rights reserved.
//

#import "DisPlayXLSViewController.h"

@interface DisPlayXLSViewController ()<QLPreviewControllerDataSource>

@end

@implementation DisPlayXLSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.previewController = [[QLPreviewController alloc] init];
    self.previewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height);
    self.previewController.dataSource = self;
    [self addChildViewController:self.previewController];
    [self.view addSubview:self.previewController.view];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
