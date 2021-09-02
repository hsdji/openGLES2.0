//
//  OpenGLESView.m
//  OpenGLESView
//
//  Created by wuyd on 2021/8/31.
//

#import "OpenGLESView.h"
#import "OpenGLESView.h"
#import <OpenGLES/ES2/glext.h>
@interface OpenGLESView ()
@property (nonatomic, strong)EAGLContext *context;
@property (nonatomic, assign)GLuint mycolorRenderBuffer;
@property (nonatomic, assign)GLuint frameBuffer;
@property (nonatomic, strong)CAEAGLLayer *eaglLayer;
@end

@implementation OpenGLESView
+(Class)layerClass{
    return [CAEAGLLayer class];
}
-(instancetype)init{
    if (self == [super init]) {
        [self initializedEaglLayer];
        [self initializedContext];
    }
    return self;
}
- (void)initializedEaglLayer{
    _eaglLayer = (CAEAGLLayer *)self.layer;
    [self setContentScaleFactor: [[UIScreen mainScreen] scale]];
    self.eaglLayer.opaque = YES;
    self.eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
}

//初始化 OpenGL ES2 Library
- (void)initializedContext{
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    if (!_context) {
        NSLog(@"initialized OpenGL ES2 Failed %s",__func__);
        exit(0);
    }else{
        NSLog(@"Initialized OpenGL ES2 Success %s",__func__);
        [self setCurrentContext];
    }
}

// 把当前的上线文设置成和我们创建的上下文
- (void)setCurrentContext{
    BOOL setContextSuccess = false;
    setContextSuccess = [EAGLContext setCurrentContext:_context];
    if (!setContextSuccess) {
        NSLog(@"Set CurrentContext Failed %s",__func__);
        exit(0);
    }else{
        NSLog(@"Set CurrentContext Success %s",__func__);
        [self setFrameBuffer];
    }
}

//设置缓冲区
- (void)setFrameBuffer{
//    创建颜色缓冲对象
    glGenBuffers(1, &_mycolorRenderBuffer);
//    绑定颜色缓冲对象
    glBindRenderbuffer(GL_RENDERBUFFER, _mycolorRenderBuffer);
//    为渲染颜色缓存对象分配存储空间
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
    
//    分配n个未使用的帧缓存对象，并将它存储到framebuffers中。
        glGenFramebuffers(1, &_frameBuffer);
//   设置一个可读可写的帧缓存。当第一次来绑定某个帧缓存的时候，它会分配这个对象的存储空间并初始化，此后再调用这个函数的时候会将指定的帧缓存对象绑定为当前的激活状态。
    
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
// 该函数是将相关的 buffer（三大buffer之一）attach到framebuffer上（如果 renderbuffer不为 0，知道前面为什么说glGenRenderbuffers 返回的id 不会为 0 吧）或从 framebuffer上detach（如果 renderbuffer为 0）。参数 attachment 是指定 renderbuffer 被装配到那个装配点上，其值是GL_COLOR_ATTACHMENTi, GL_DEPTH_ATTACHMENT, GL_STENCIL_ATTACHMENT中的一个，分别对应 color，depth和 stencil三大buffer。
    
       glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                                 GL_RENDERBUFFER, _mycolorRenderBuffer);
    /**
     附件名称    描述
     GL_COLOR_ATTACHMENT(0-i)    第i个颜色缓存（0-GL_MAX_COLOR_ATTACHMENTS-1）0为默认的颜色缓存
     GL_DEPTH_ATTACHMENT    深度缓存
     GL_STENCIL_ATTACHMENT    模板缓存
     */
    [self setCurrentWindow];
    
}


- (void)setCurrentWindow{
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(1.0, 1.0, 0, 1.0);
    if (![_context presentRenderbuffer:GL_RENDERBUFFER]) {
        NSLog(@"Render Window Failed %s",__func__);
    }else{
        NSLog(@"Render Window Success %s",__func__);
    }
}


- (void)destoryRenderAndFrameBuffer{
    glDeleteFramebuffers(1, &_frameBuffer);
    _frameBuffer = 0;
    glDeleteRenderbuffers(1, &_mycolorRenderBuffer);
    _mycolorRenderBuffer = 0;
}

@end
