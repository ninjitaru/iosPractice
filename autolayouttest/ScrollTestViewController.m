//
//  ScrollTestViewController.m
//  autolayouttest
//
//  Created by Jason Chang on 8/17/14.
//
//

#import "ScrollTestViewController.h"

@interface ScrollTestViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak,nonatomic) IBOutlet UIButton *button;

@end

@implementation ScrollTestViewController


- (void) clearConstraint:(UIView *) view {
    for(UIView *one in view.subviews) {
        [self clearConstraint: one];
    }
    [view removeConstraints:view.constraints];
}

- (void) animate {
    [self.scrollView layoutIfNeeded]; // Ensures that all pending layout operations have been completed
    NSMutableArray *constraints = [NSMutableArray new];
    NSMutableDictionary *viewDic = [NSMutableDictionary new];
    viewDic[@"scrollView"] = self.scrollView;
    viewDic[@"view"] = self.view;
    viewDic[@"button"] = self.button;
    int index = 1;
    for(UILabel *label in self.labels) {
        viewDic[[NSString stringWithFormat: @"label%i",index]] = label;
        label.text = [NSString stringWithFormat: @"label%i",index];
        index++;
    }
    NSDictionary *tt = @{
                         @"h1":@(arc4random()%400),
                         @"h2":@(arc4random()%400),
                         @"h3":@(arc4random()%400),
                         @"h4":@(arc4random()%400),
                         };
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[label1]-h1-[label2]-h2-[label3]-h3-[label4]-20-|"
                                                                             options:0
                                                                             metrics:tt
                                                                               views: viewDic]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label1]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label2]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label3]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label4]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [self.scrollView removeConstraints: self.scrollView.constraints];
    [UIView animateWithDuration:1.0 animations:^{
        // Make all constraint changes here
        [self.scrollView addConstraints: constraints];
        [self.scrollView layoutIfNeeded];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self clearConstraint: self.view];
    UIButton * b=  [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [b setTitle: @"animate" forState: UIControlStateNormal];
    b.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview: b];
    [b addTarget: self action: @selector(animate) forControlEvents: UIControlEventTouchUpInside];
    b.translatesAutoresizingMaskIntoConstraints = NO;
    self.button = b;
    
    // scroll content size set by constraints
    NSMutableArray *constraints = [NSMutableArray new];
    NSMutableDictionary *viewDic = [NSMutableDictionary new];
    viewDic[@"scrollView"] = self.scrollView;
    viewDic[@"view"] = self.view;
    viewDic[@"button"] = self.button;
    int index = 1;
    for(UILabel *label in self.labels) {
        viewDic[[NSString stringWithFormat: @"label%i",index]] = label;
        label.text = [NSString stringWithFormat: @"label%i",index];
        index++;
    }
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label1]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label2]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label3]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label4]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[label1]-400-[label2]-400-[label3]-400-[label4]-20-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [self.scrollView addConstraints: constraints];
    [constraints removeAllObjects];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views: viewDic]];
    [self.view addConstraints: constraints];
    [constraints removeAllObjects];
    NSLayoutConstraint * cc = [NSLayoutConstraint constraintWithItem: self.view attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationEqual toItem: self.button attribute: NSLayoutAttributeLeading multiplier:1 constant: 20];
    cc.priority = 10;
    [constraints addObject: cc];
    [constraints addObject: [NSLayoutConstraint constraintWithItem: self.view attribute: NSLayoutAttributeRight relatedBy: NSLayoutRelationEqual toItem: self.button attribute: NSLayoutAttributeTrailing multiplier:1 constant: 20]];
    [constraints addObject: [NSLayoutConstraint constraintWithItem: self.view attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: self.button attribute: NSLayoutAttributeBottom multiplier:1 constant: 40]];
    [constraints addObject: [NSLayoutConstraint constraintWithItem: self.button attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationGreaterThanOrEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1 constant: 100]];
    [constraints addObject: [NSLayoutConstraint constraintWithItem: self.button attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationGreaterThanOrEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1 constant: 55]];
    [self.view addConstraints: constraints];
    
//    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(==44)]-20-[view]"
//                                                                             options:UIL
//                                                                             metrics:nil
//                                                                               views: viewDic]];
//    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[view]-[button(>=200)]-[view]"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views: viewDic]];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    NSLog(@"%f",self.topLayoutGuide.length);
    NSLog(@"%f",self.bottomLayoutGuide.length);
}

@end
