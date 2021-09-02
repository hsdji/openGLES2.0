//
//  ViewController.m
//  LearnOpenGLES01
//
//  Created by wuyd on 2021/9/1.
//

void firstTimeTraning(void);
void secondTimeTraning(void);
#import "ViewController.h"
ViewController *currentSelf;
@interface ViewController ()
@property (nonatomic, strong) EAGLContext *mContext;

@property (nonnull, strong) GLKBaseEffect *mEffect;
@end

@implementation ViewController

GLuint buffer;//数据缓存;
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initializedOpenglEs2];
//    [self uploadVertexArray];
    currentSelf = self;
//    第一次练习
//    firstTimeTraning();
    secondTimeTraning();

}
/// 初始化OpenGL Es 并且指定版本为OpenGL Es 2.0
- (void)initializedOpenglEs2{
// 指定要使用的openglEs 的版本 ，当前使用的是OpenGL Es 2.0版本
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    self.mContext = [[EAGLContext alloc] initWithAPI:api];
    if (!self.mContext) {
        NSLog(@"initialized OpenGl Es 2.0 failed %s", __func__);
        exit(0);
    }else{
        NSLog(@"Initialized OpenGl Es 2.0 Success %s",__func__);
    }
    GLKView *view = (GLKView *)self.view;
    view.context = self.mContext;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    GLboolean contextSetSuccess = GL_FALSE;
    contextSetSuccess =[EAGLContext setCurrentContext:self.mContext];
    if (!contextSetSuccess) {
        NSLog(@"Set New OpenGl Es Context Failed %s",__func__);
    }else{
        NSLog(@"Set New OpenGl Es Context Success %s",__func__);
    }
}

//
- (void)uploadVertexArray{
    GLfloat vertexData[] =
    {
        //顶点数据，前三个是顶点坐标（x、y、z轴），后面两个是纹理坐标（x，y）
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
    };
    
   
    /***glGenBuffers
                用来生成缓冲区的对象的名称：
        函数的原型 void glGenBuffers(GLSize n , GLUint Buffers);
            第一个参数:要生成的饿换成对象的数量
            第二个参数:输入用来存储缓冲对象名称的数组
     该函数会在buffer里面返回n个缓冲对象的名称
     
     
     这个缓冲对象没哟实际意义，他仅仅就是一个缓冲对象，还不是一个顶点数组缓冲，它有点类似于C语言里面的指针变量，我们可以分配内存对象并且用他的名称来引用内存对象。
        openGl 有很多的缓冲duixiang，那么缓冲对象到底是什么类型就需要用到glBindBuffer这个单数了。
        简单介绍一下: glCreateBuffers和GLGenBuffers是一样的意思，但是前者是opengl4.5开始支持的，而后者支持所有的版本。
     
     
     glBindBuffer函数解析：
            函数原型:void glBindBuffer(GLenum target, GLuint buffer);
        参数解析：第一个参数：target 代表的就是缓冲对象的类型。
                第二个参数：要绑定的缓冲对象的名称，也就是我们在上一个函数生层的名称，使用更改函数将缓冲对象绑定到OpenGl上下文环境中可以使用。如果把target绑定到一个已经创建好的缓冲对象上，那么这个缓冲对象将为当前的target的激活对象；但是如果绑定的buffer为0 ，那么Opengl 将不在对当前的targer使用任何缓冲对象。
     */
    glGenBuffers(1, &buffer);// 给缓冲区对象命名
    NSLog(@"%u",buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);//用命名过的缓冲区对象的名称绑定到OpenGL上下文
//    创建并初始化缓冲区对象的数据存储
    /**
     名称
     glBufferData- 创建并初始化缓冲区对象的数据存储
     C规范
     void glBufferData（GLenum target,GLsizeiptr size,const GLvoid * data,GLenum usage）;
     参数
     target
     指定目标缓冲区对象。
     符号常量必须为GL_ARRAY_BUFFER//缓冲区对象表示将该缓冲区对象用于顶点属性数据
     或GL_ELEMENT_ARRAY_BUFFER。//缓冲区对象绑定到的target（）
     size
     指定缓冲区对象的新数据存储的大小（以字节为单位）。
     data
     指定将复制到数据存储区以进行初始化的数据的指针，如果不复制数据，则指定NULL。
     usage
     指定数据存储的预期使用模式。 符号常量必须为GL_STREAM_DRAW，GL_STATIC_DRAW或GL_DYNAMIC_DRAW。
     描述
     glBufferData为当前绑定到target的缓冲区对象创建一个新的数据存储。 删除任何预先存在的数据存储。 使用指定的字节和usage创建新数据存储。 如果data不是NULL，则使用来自此指针的数据初始化数据存储。

     usage是关于如何访问缓冲区对象的数据存储的GL实现的提示。这使GL实现能够做出更明智的决策，这可能会显着影响缓冲区对象的性能。 但是，它不会限制数据存储的实际使用。usage可以分为两部分：第一，访问频率（修改和使用），第二，访问的性质。 访问频率可能是以下之一：

     STREAM

             数据存储内容将被修改一次并最多使用几次。

     STATIC

             数据存储内容将被修改一次并多次使用。

     DYNAMIC

             数据存储内容将被重复修改并多次使用。

     访问的性质必须是：

     DRAW

             数据存储内容由应用程序修改，并用作GL绘图和图像规范命令的源。

     注意
     如果data为NULL，则仍会创建指定大小的数据存储，但其内容仍未初始化，因此被视为未定义的。

     客户端必须使数据元素与客户端平台的要求保持一致，并具有额外的基本级要求，即缓冲区内对包含N的数据的偏移量是N的倍数。

     错误
     GL_INVALID_ENUM ：target不是GL_ARRAY_BUFFER或GL_ELEMENT_ARRAY_BUFFER。

     GL_INVALID_ENUM ：usage不是GL_STREAM_DRAW，GL_STATIC_DRAW或GL_DYNAMIC_DRAW。

     GL_INVALID_VALUE ：size是负数

     GL_INVALID_OPERATION ：如果保留的缓冲区对象名称0绑定到target。

     GL_OUT_OF_MEMORY ：如果GL无法创建具有指定大小的数据存储
     
     */
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition); //顶点数据缓存
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
    
    
    GLKTextureInfo* textureInfo = [[GLKTextureInfo alloc] init];
    //着色器
    self.mEffect = [[GLKBaseEffect alloc] init];
    self.mEffect.texture2d0.enabled = GL_TRUE;
    self.mEffect.texture2d0.name = textureInfo.name;
    
}

/**
 *  渲染场景代码
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    //启动着色器
    [self.mEffect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
}




- (void)createManyContext{
    EAGLContext *firstContect,*secondContext;
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    firstContect = [[EAGLContext alloc] initWithAPI:api];
    if (!self.mContext) {
        NSLog(@"initialized OpenGl Es 2.0 failed %s", __func__);
        exit(0);
    }else{
        NSLog(@"Initialized OpenGl Es 2.0 Success %s",__func__);
    }
    secondContext = [[EAGLContext alloc] initWithAPI:[firstContect API] sharegroup:[firstContect sharegroup]];
}

@end
/**
    类解析：
@class EAGLContext
    OPengl Es 上下文 当程序使用Opengl Es 调用时，线程的上线文就会被那个调用改变 要设置当前上下文，就可以通过EAGLContext类的setCurrentContext方法
 应用程序也可以通过EAGLContext类的currentContext方法来获取一个线程的当前的上下文。
 当程序设置了一个新的上下文时，EAGL就会释放当前的上下文，并且获取新的上下文。
 
 当你的程序创建和初始化EAGLContext对象时，可以用初始化方法initWithAPI：来决定当前使用的OpenGl Es的版本号,创建OpenGl Es2.0 ，初始化方式如上面代码：
    eg: initializedOpenglEs2
 
 
 ps:
    在不同的上下文中,共性的资源不会变化（双缓冲区原理）
 当你想要程序在一个线程中创建新的OpenGL ES对象，而在主线程渲染时。在这种情况下，第二个上下文会独立的运行在一个线程中，并且致力于获取数据和资源。在所有的资源都加载完成后，第一个上下文绑定到这些对象上，然后立即使用它。
 第二个或者之后的上下文初始化时，就可以通过调用initWithAPI：shareGroup方法使用第一个上下文创建的共享组，第一个上下文通过使用快捷方法。第二个上下文时通过一个扩展的API传递了第一个上下文的共享组从而被创建.
  note：两个或者多个上下文使用的openGL Es的版本要保持相同。
 
 
 
 @class GLKBaseEffect  该类是GLKit提供的一个基础的效果类。他简化了许多OpenGl应用程序常见的视觉效果
    GLKBaseEffect 提供了一些光照和着色的功能
 下面直接说这个类的头文件中给我们开放了什么属性和方法。
 
 @property (nullable, nonatomic, copy) NSString *label;此属性可以理解成给当前的效果命名
 
 
 @property (nonatomic, readonly) GLKEffectPropertyTransform *transform;此属性配置模型视图转换，比如说模型视图的投影 、纹理、和派生矩阵转换。
 
 @property (nonatomic, assign) GLKLightingType lightingType;配置光照效果 是一个枚举类型的属性 两个枚举值：第一个GLKLightingTypePerVertex ：在三角形的每个顶点上执行光照计算，然后在三角形上进行插值。第二个:GLKLightingTypePerPixel:把计算的输入插入到三角形中，然后在每片段执行光照计算。
 
 @property (nonatomic, assign) GLboolean lightModelTwoSided;配置光照 BOOl类型的值 是否为图元的两侧计算光照，如果是GL_TRUE，并且渲染的是图元的背面的话，那么就通过求出该图元的便面法线反转去计算光照值。默认值是GL_FALSE
 
 @property (nonatomic, readonly) GLKEffectPropertyMaterial *material;计算渲染图元的光照时，可以设置的材料属性。
 
 @property (nonatomic, assign) GLKVector4 lightModelAmbientColor;//环境颜色



 @property (nonatomic, readonly) GLKEffectPropertyLight  *light0, *light1, *light2;场景中的三个光照属性。GLKBaseEffect只有这三个光照属性，如果你要设置4个的话，那么就不能应用GLKBaseEffect。这时候就需要自己来自定义着色器来完成。这也说明了GLKBaseEffect只是GLKit帮我们做的一些简单的封装，当遇到复杂的情况的时候，还是要自己来实现。


 @property (nonatomic, readonly) GLKEffectPropertyTexture  *texture2d0, *texture2d1;2D纹理属性，也有两个，有顺序的。也是一个情况，只能处理两个纹理，所以你要使用超过2个纹理的话，还是要自己来做，不能用GLKBaseEffect。
 
 @property (nullable, nonatomic, copy) NSArray<GLKEffectPropertyTexture*> *textureOrder;你可以设置以下属性里面Array元素的顺序来确定渲染图元的纹理的顺序。
 
 @property (nonatomic, readonly) GLKEffectPropertyFog *fog;应用于场景的雾化属性。

 @property (nonatomic, assign) GLboolean colorMaterialEnabled; 计算光照和材质交互的时候，要不要使用颜色顶点属性。
 
 @property (nonatomic, assign) GLboolean useConstantColor;是否使用常量颜色。
 
 @property (nonatomic, assign) GLKVector4 constantColor;不提供每个顶点的颜色数据时，要用的常量颜色值。
 
 - (void) prepareToDraw;同步所有更改的效果状态，让他们保持一致。在我们执行渲染之前，一定要准备渲染。，准备绘制

 */


void firstTimeTraning(void){
    EAGLContext *context;
/// initialized OpenGL Es library
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    context = [[EAGLContext alloc] initWithAPI:api];
    if (context) {
        NSLog(@"Initialized Opengl Es 2.0 success");
    }else{
        NSLog(@"Initialized OpenGL Es 2.0 Failed");
    }
    currentSelf.mContext = context;
    GLKView *view = (GLKView *)currentSelf.view;
    view.context = currentSelf.mContext;
    [EAGLContext setCurrentContext:context];
    GLuint buffer;
    glGenBuffers(1, &buffer);//生成缓冲区别名
    glBindBuffer(GL_ARRAY_BUFFER, buffer);//绑定
    GLfloat vertex[] = {
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
    };
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertex), vertex, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition); //启用顶点数据 读取顶点数组中的值
    
    /***
    @method glVertexAttribPointer
 description: 设置着色器的数据格式，数据包大小，等等
    第一个参数指定我们要配置的顶点属性。还记得我们在顶点着色器中使用layout(location = 0)定义了position顶点属性的位置值(Location)吗？它可以把顶点属性的位置值设置为0。因为我们希望把数据传递到这一个顶点属性中，所以这里我们传入0。
     第二个参数指定顶点属性的大小。顶点属性是一个vec3，它由3个值组成，所以大小是3。
     第三个参数指定数据的类型，这里是GL_FLOAT(GLSL中vec*都是由浮点数值组成的)。指定数组中每个组件的数据类型。 接受符号常量GL_BYTE，GL_UNSIGNED_BYTE，GL_SHORT，GL_UNSIGNED_SHORT，GL_FIXED或GL_FLOAT。 初始值为GL_FLOAT。
     下个参数定义我们是否希望数据被标准化(Normalize)。如果我们设置为GL_TRUE，所有数据都会被映射到0（对于有符号型signed数据是-1）到1之间。我们把它设置为GL_FALSE。指定在访问定点数据值时是应将其标准化（GL_TRUE）还是直接转换为定点值（GL_FALSE）。
     第五个参数叫做步长(Stride)，它告诉我们在连续的顶点属性组之间的间隔。由于下个组位置数据在3个float之后，我们把步长设置为3 * sizeof(float)。要注意的是由于我们知道这个数组是紧密排列的（在两个顶点属性之间没有空隙）我们也可以设置为0来让OpenGL决定具体步长是多少（只有当数值是紧密排列时才可用）。一旦我们有更多的顶点属性，我们就必须更小心地定义每个顶点属性之间的间隔，我们在后面会看到更多的例子（译注: 这个参数的意思简单说就是从这个属性第二次出现的地方到整个数组0位置之间有多少字节）。指定连续通用顶点属性之间的字节偏移量。 如果stride为0，则通用顶点属性被理解为紧密打包在数组中的。 初始值为0。
     最后一个参数的类型是void*，数据指针， 这个值受到VBO的影响；1：在不使用VBO的情况下，就是一个指针，指向的是需要上传到顶点数据指针，项目中通常在不使用VBO的情况下，绘制之前，执行glBindBuffer(GL_ARRAY_BUFFER, 0)，否则会导致数组顶点无效，界面无法显示；2：使用VBO的情况下，先要执行glBindBuffer(GL_ARRAY_BUFFER, 1)，如果一个名称非零的缓冲对象被绑定至GL_ARRAY_BUFFER目标（见glBindBuffer）且此时一个定点属性数组被指定了，那么pointer被当做该缓冲对象数据存储区的字节偏移量。并且，缓冲对象绑定（GL_ARRAY_BUFFER_BINDING）会被存为索引为index的顶点属性数组客户端状态；此时指针指向的就不是具体的数据了。因为数据已经缓存在缓冲区了。这里的指针表示位置数据在缓冲中起始位置的偏移量(Offset)。由于位置数据在数组的开头，所以这里是0。我们会在后面详细解释这个参数。指定指向数组中第一个通用顶点属性的第一个组件的指针。 初始值为0。
     */
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);//设置着色器数据格式 等其他参数
    GLKTextureInfo* textureInfo = [[GLKTextureInfo alloc] init];
    //着色器
    currentSelf.mEffect = [[GLKBaseEffect alloc] init];
    currentSelf.mEffect.texture2d0.enabled = GL_TRUE;
    currentSelf.mEffect.texture2d0.name = textureInfo.name;
}

void secondTimeTraning(void){
    EAGLContext *context;
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    context =  [[EAGLContext alloc] initWithAPI:api];
    if (!context) {
        NSLog(@"Initialized OpenGl Es2.0 Failed %s",__func__);
    }else{
        NSLog(@"Initialized opengl Es2.0 Success %s",__func__);
    }
    [EAGLContext setCurrentContext:context];
    currentSelf.mContext = context;
    GLKView *view = (GLKView *)currentSelf.view;
    view.context = context;
//    setUpVertextData
    GLfloat vertextData[] = {
        -0.5,0.5 ,0 ,0 ,1,
        0.5 ,0.5 ,0 ,1 ,1,
        0.5 ,-0.5,0 ,0 ,-1,
        
        -0.5, 0.5,0 ,0,1,
        0.5,-0.5 ,0 ,0,-1,
        -0.5,-0.5,0,0,0,
    };
    GLuint buffer;
    glGenBuffers(1, &buffer);//生成缓冲区别名
    glBindBuffer(GL_ARRAY_BUFFER, buffer);//绑定

    glBufferData(GL_ARRAY_BUFFER, sizeof(vertextData), vertextData, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*5, (GLfloat *)NULL + 0);
    GLKTextureInfo *info = [[GLKTextureInfo alloc] init];
    currentSelf.mEffect = [[GLKBaseEffect alloc] init];
    currentSelf.mEffect.texture2d0.enabled = GL_TRUE;
    currentSelf.mEffect.texture2d0.name = info.name;
    
    
}


