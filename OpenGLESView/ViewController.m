//
//  ViewController.m
//  OpenGLESView
//
//  Created by wuyd on 2021/8/31.
//

#import "ViewController.h"
#import "OpenGLESView.h"
@interface ViewController ()
@property (nonatomic ,strong)OpenGLESView *openGLView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.openGLView = [[OpenGLESView alloc] init];
    self.view = self.openGLView;
}


@end
