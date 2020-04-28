#import "L0Prefs.h"

@implementation L0PrefVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
}

+ (UIWindow *)keyWindow {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    UIWindow *ret = nil;
    for (UIWindow *window in windows) {
        if (window.isKeyWindow) {
            ret = window;
            break;
        }
    }
    return ret;
}

- (void)setupTable {
    [self setCells:@{
        @"LinkCell"     : [L0LinkCell class],
        @"PickerCell"   : [L0PickerCell class],
        @"ButtonCell"   : [L0ButtonCell class],
        @"ToggleCell"   : [L0ToggleCell class],
        @"EditTextCell" : [L0EditTextCell class],
    }];

    [self setTableView:[[UITableView alloc] initWithFrame:CGRectZero
                                                    style:UITableViewStyleGrouped]];
    
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    [[self tableView] setRowHeight:44];
    [[self tableView] setAllowsMultipleSelectionDuringEditing:NO];

    for(NSString *reuseID in [self cells]) {
        [[self tableView] registerClass:[self cells][reuseID]
                 forCellReuseIdentifier:reuseID];
    }

    [self setView:[self tableView]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIWindow *window = [L0PrefVC keyWindow];
    if (!window) {
        window = [[[UIApplication sharedApplication] windows] firstObject];
    }
    if ([window respondsToSelector:@selector(setTintColor:)]) {
        [window setTintColor:LINK_COLOR];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if([self isRootVC]) {
        UIWindow *window = [L0PrefVC keyWindow];
        if (!window) {
            window = [[[UIApplication sharedApplication] windows] firstObject];
        }
        if ([window respondsToSelector:@selector(setTintColor:)]) {
            [window setTintColor:nil];
        }
    }
}

- (void)controllerDidChangeModel:(L0PrefVC *)controller {
    [[self tableView] reloadData];
    [[self delegate] controllerDidChangeModel:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (BOOL)isRootVC { return NO; }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
}

@end