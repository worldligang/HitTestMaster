# HitTestMaster


###处理机制

iOS事件处理，首先应该是找到能处理点击事件的视图，然后在找到的这个视图里处理这个点击事件。

处理原理如下：

• 当用户点击屏幕时，会产生一个触摸事件，系统会将该事件加入到一个由UIApplication管理的事件队列中

• UIApplication会从事件队列中取出最前面的事件进行分发以便处理，通常，先发送事件给应用程序的主窗口(UIWindow)

• 主窗口会调用hitTest:withEvent:方法在视图(UIView)层次结构中找到一个最合适的UIView来处理触摸事件

(hitTest:withEvent:其实是UIView的一个方法，UIWindow继承自UIView，因此主窗口UIWindow也是属于视图的一种)

• hitTest:withEvent:方法大致处理流程是这样的：

首先调用当前视图的pointInside:withEvent:方法判断触摸点是否在当前视图内：

▶ 若pointInside:withEvent:方法返回NO，说明触摸点不在当前视图内，则当前视图的hitTest:withEvent:返回nil

▶ 若pointInside:withEvent:方法返回YES，说明触摸点在当前视图内，则遍历当前视图的所有子视图(subviews)，调用子视图的hitTest:withEvent:方法重复前面的步骤，子视图的遍历顺序是从top到bottom，即从subviews数组的末尾向前遍历，直到有子视图的hitTest:withEvent:方法返回非空对象或者全部子视图遍历完毕：

▷ 若第一次有子视图的hitTest:withEvent:方法返回非空对象,则当前视图的hitTest:withEvent:方法就返回此对象，处理结束

▷ 若所有子视图的hitTest:withEvent:方法都返回nil，则当前视图的hitTest:withEvent:方法返回当前视图自身(self)

• 最终，这个触摸事件交给主窗口的hitTest:withEvent:方法返回的视图对象去处理。我的微信号iOS开发：iOSDevTip

###案列分析

在UIViewController的self.view上加载一个LGFirstView

LGFirstView上面有一个UIButton我们叫它buttonFirst

然后，self.view上加载一个LGSecondView，刚好盖在LGFirstView上面

LGSecondView上面也有一个UIButton我们叫它buttonSecond

#####正常情况下：

用户点击LGSecondView（点击的点不在buttonSecond上，但是在buttonFirst撒很难过吗），事件处理流程如下：

1）调用UIWindow的hitTest:withEvent:方法，hitTest:withEvent:方法会调用pointInside:withEvent:方法。此时pointInside:withEvent:返回YES，说明触摸事件在UIWindow上面。

2）去遍历UIWindow上面的子视图，也就是self.view。同样也是调用self.view的hitTest:withEvent:方法，hitTest:withEvent:方法会调用pointInside:withEvent:方法。此时pointInside:withEvent:返回YES，说明触摸事件在self.view上面。

3）去遍历self.view上的子视图，也就是LGFirstView和LGSecondView。（注意：子视图的遍历顺序是从top到bottom，即从subviews数组的末尾向前遍历）。

4）所以先调用LGSecondView的hitTest:withEvent:方法，hitTest:withEvent:方法会调用pointInside:withEvent:方法。此时pointInside:withEvent:返回YES，说明触摸事件在LGSecondView上面。（此时不会再去遍历LGFirstView，所以正如你所愿buttonFirst的点击事件也不会被调用）

5）还没有结束，接着回去遍历LGSecondView上的所有子视图，结果所有子视图的hitTest:withEvent:方法都返回nil，因为LGSecondView上面只有secondButton，而点击的点不在secondButton。

6）最终hitTest:withEvent:方法返回当前视图自身(self)，而LGSecondView没有事件要处理。整个过程结束。

#####如果我们想让buttonFirst也响应点击事件怎么办？

#####方法一：

我们在LGSecondView加入如下代码：

	#pragma mark - 方法一
	-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
	{
	    UIView *hitView = [super hitTest:point withEvent:event];
	    if (hitView == self)
	    {
	        return nil;
	    }
	    else
	    {
	        return hitView;
	    }
	}

我们再来分析一下：

还是这个场景，用户点击LGSecondView（点击的点不在buttonSecond上，但是在buttonFirst撒很难过吗），事件处理流程如下：

1）调用UIWindow的hitTest:withEvent:方法，hitTest:withEvent:方法会调用pointInside:withEvent:方法。此时pointInside:withEvent:返回YES，说明触摸事件在UIWindow上面。

2）去遍历UIWindow上面的子视图，也就是self.view。同样也是调用self.view的hitTest:withEvent:方法，hitTest:withEvent:方法会调用pointInside:withEvent:方法。此时pointInside:withEvent:返回YES，说明触摸事件在self.view上面。

3）去遍历self.view上的子视图，也就是LGFirstView和LGSecondView。（注意：子视图的遍历顺序是从top到bottom，即从subviews数组的末尾向前遍历）。

4）所以先调用LGSecondView的hitTest:withEvent:方法，hitTest:withEvent:方法会调用pointInside:withEvent:方法。此时pointInside:withEvent:返回YES，说明触摸事件在LGSecondView上面。

5)但是，注意了，这里有个但是， UIView *hitView = [super hitTest:point withEvent:event];就是这句代码发挥了作用。如果hitView是LGSecondView的话，就不处理点击事件。（这跟userInteractionEnabled=NO是不一样的，userInteractionEnabled=NO，LGSecondView上的buttonSecond也不会响应点击事件了。）

6)这个时候会去调用LGFirstView的hitTest:withEvent:方法，hitTest:withEvent:方法会调用pointInside:withEvent:方法。此时pointInside:withEvent:返回YES，说明触摸事件在LGFirstView上面。

7）再去遍历LGFirstView上面的子视图，也就是buttonFirst，调用buttonFirst的hitTest:withEvent:方法，hitTest:withEvent:方法会调用pointInside:withEvent:方法。此时pointInside:withEvent:返回YES，说明触摸事件在buttonFirst上面。

8）再去遍历buttonFirst上的所有子视图，结果所有子视图的hitTest:withEvent:方法都返回nil，说明点击就在buttonFirst，buttonFirst就用响应的点击方法。

#####方法二
在LGSecondView.m

	@interface LGSecondView ()
	
	@property (nonatomic, strong) NSMutableArray *subControlsArray;
	
	@end
	
	@implementation LGSecondView

	        
	- (id)initWithFrame:(CGRect)frame
	{
	    if (self = [super initWithFrame:frame]) {
	        self.subControlsArray = [NSMutableArray array];
	    }
	    return self;
	}


	#pragma mark - 方法二
	
	- (void)addSubview:(UIView *)view{
	    [super addSubview:view];
	    if ([view isKindOfClass:[UIControl class]]) {
	        [self.subControlsArray addObject:view];
	    }
	}
	
	//set self not response action and self subviews response action
	- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;
	{
	    BOOL toNext = YES;
	    for (UIView *view in _subControlsArray) {
	        if (CGRectContainsPoint(view.frame, point)) {
	            toNext = NO;
	            break;
	        }
	    }
	    return !toNext;
	}
	


具体原理就不在累述了，大家自己推一下，也可以把你的思路写下来发给我。

还有很多方法也欢迎你把思路写下来发给我。我的微信号iOS开发：iOSDevTip

代码下载地址:[HitTestMaster](https://github.com/worldligang/HitTestMaster.git)
