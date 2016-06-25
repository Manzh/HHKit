// light@huohua.tv
#import "HHAlertView.h"

@interface HHAlertView () <UIAlertViewDelegate>
@property (strong, nonatomic) NSMutableArray *blocks;
@end

@implementation HHAlertView

- (NSMutableArray *)blocks
{
    if (!_blocks) {
        _blocks = [[NSMutableArray alloc] init];
    }
    
    return _blocks;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    self = [self initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle cancelBlock:^{}];
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(HHBasicBlock)cancelBlock
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    if (self) {
        if (cancelBlock) {
            [self.blocks addObject:[cancelBlock copy]];
        }
    }
    
    return self;
}

- (void)addButtonWithTitle:(NSString *)title block:(HHBasicBlock)block
{
    [self addButtonWithTitle:title];
    
    if (block) {
        [self.blocks addObject:[block copy]];
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    HHBasicBlock block = [self.blocks objectAtIndex:0];
    
    block();
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    HHBasicBlock block = [self.blocks objectAtIndex:buttonIndex];
    
    block();
}

@end
