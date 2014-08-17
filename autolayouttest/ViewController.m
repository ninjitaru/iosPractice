//
//  ViewController.m
//  autolayouttest
//
//  Created by Jason Chang on 8/17/14.
//
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,weak) UIButton *button;
@end

@implementation ViewController

- (void) clearConstraint:(UIView *) view {
    for(UIView *one in view.subviews) {
        [self clearConstraint: one];
    }
    [view removeConstraints:view.constraints];
}

- (void) go {
    UIViewController *c = [[UIStoryboard storyboardWithName: @"Main_iPhone" bundle: nil] instantiateViewControllerWithIdentifier: @"ScrollTestViewController"];
    [self.navigationController pushViewController: c animated: YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *b = [UIButton buttonWithType: UIButtonTypeCustom];
    [b setTitle: @"next" forState: UIControlStateNormal];
    b.backgroundColor = [UIColor blackColor];
    b.frame = CGRectMake(10,200,50,50);
    [b addTarget: self action: @selector(go) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: b];
    self.button = b;
    
    
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    for(UIView *view in self.views) {
        NSLog(@"%@ %@ %@", NSStringFromClass(view.class), view, NSStringFromCGPoint(view.center));
    }
    
    int index = 1;
    for(UILabel *label in self.labels) {
        label.text = [NSString stringWithFormat: @"asfj asdfwe asdfwoej  %i",index];
        index++;
        label.backgroundColor = [UIColor blueColor];
    }
    
    [_view1 setTranslatesAutoresizingMaskIntoConstraints: NO];
    [_view2 setTranslatesAutoresizingMaskIntoConstraints: NO];
//    [self.view1 setContentHuggingPriority: UILayoutPriorityDefaultHigh forAxis: UILayoutConstraintAxisHorizontal];
//    [self.view1 setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
//    [self.view2 setContentHuggingPriority: UILayoutPriorityDefaultHigh forAxis: UILayoutConstraintAxisVertical];
//
    [self clearConstraint: self.view];
    NSDictionary *viewsDictionary =
    NSDictionaryOfVariableBindings(_view1, _view2,_label1,_label2);
    NSMutableArray *constraints = [NSMutableArray new];
//    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_view1(>=100)]-50-[_view2(>=100)]-|"
//                                            options:0
//                                            metrics:nil
//                                              views:viewsDictionary]];
//    self.navigationController.navigationController.bottomLayoutGuide.length
    CGFloat th = 64;
//    NSLog(@"%f",self.bottomLayoutGuide.length);
    // - is size 8 point
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_view1(_view2@100)]-20@10-[_view2]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary]];

    // example of define metrics
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-th-[_view1(==h)]"
                                            options:0
                                                                             metrics:@{@"h":@100,@"th": @(th+20)}
                                              views:viewsDictionary]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-th-[_view2(==200)]"
                                            options:0
                                                                             metrics:@{@"th": @(th+40)}
                                              views:viewsDictionary]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_label1(>=70,<=_view1)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_label1(<=_view1)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary]];
    
    [self.view addConstraints: constraints];
    
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    NSLog(@"%f",self.topLayoutGuide.length);
//    NSLog(@"%f",self.bottomLayoutGuide.length);
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
//    NSLog(@"%f",self.topLayoutGuide.length);
//    NSLog(@"%f",self.bottomLayoutGuide.length);
}

@end
