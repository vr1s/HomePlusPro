//
// VIVAEditorViewController.m
// Viva
// 
// View controller for the Editor and Home base for anything UI.
// 
// Created Oct 2019 
// Authors: vriska
//
// TODO: rewrite or at least heavily optimize this file
// 
#include "Viva.h"
#include "VivaEditor/VivaEditor.h"
#import "VIVALayoutManager.h"
#include <AudioToolbox/AudioToolbox.h>
#include "VIVAConfigSelectionViewController.h"

#define kButtonSpacing 10

@interface VIVAEditorViewController ()

@property (nonatomic, readwrite, strong) VIVAControllerView *offsetControlView;
@property (nonatomic, readwrite, strong) VIVAControllerView *spacingControlView;
@property (nonatomic, readwrite, strong) VIVAControllerView *iconCountControlView;
@property (nonatomic, readwrite, strong) VIVAControllerView *scaleControlView;
@property (nonatomic, readwrite, strong) VIVAControllerView *settingsView;

@property (nonatomic, readwrite, strong) VIVAEditorViewNavigationTabBar *rightTabBar;
@property (nonatomic, readwrite, strong) VIVAEditorViewNavigationTabBar *leftTabBar;

@property (nonatomic, readwrite, strong) VIVASettingsTableViewController *tableViewController;

@property (nonatomic, retain) VIVAControllerView *activeView;
@property (nonatomic, retain) UIButton *activeButton;

@property (nonatomic, retain) UIButton *rootButton;
@property (nonatomic, retain) UIButton *dockButton;

@property (nonatomic, retain) UIButton *settingsDoneButton;

@end

#pragma mark Constants

const CGFloat MENU_BUTTON_TOP_ANCHOR = 0.05541872;
const CGFloat MENU_BUTTON_SIZE = 40.0;

const CGFloat TABLE_HEADER_HEIGHT = 0.458;


@implementation VIVAEditorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.homeTabControllerViews = [@[[self offsetControlView], [self spacingControlView],
            [self iconCountControlView], [self scaleControlView],
            [self settingsView]] mutableCopy];


    // Add subviews to self. Any time viewDidLoad is called manually, unload these view beforehand

    [self.view addSubview:[self offsetControlView]];
    [self.view addSubview:[self spacingControlView]];
    [self.view addSubview:[self iconCountControlView]];

    [self.view addSubview:[self scaleControlView]];
    [self.view addSubview:[self settingsView]];

    // Load the view
    [self loadControllerView:[self offsetControlView]];

    self.rightTabBar = [self defaultTabBar];
    self.leftTabBar = [self defaultLeftTabBar];

    [self handleDefaultBarTabButtonPress:[self.rightTabBar subviews][0]];
    
    [self.view addSubview:self.rightTabBar];
    [self.view addSubview:self.leftTabBar];
}

- (void)loadLoadouts:(UIButton *)button
{
    VIVAConfigSelectionViewController *vc = [[VIVAConfigSelectionViewController alloc] initWithNibName:nil bundle:nil];

    [vc viewDidLoad];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void)buttonPressDown:(id)arg
{
    AudioServicesPlaySystemSound(1519);
}

- (VIVAEditorViewNavigationTabBar *)defaultTabBar
{
    VIVAEditorViewNavigationTabBar *tabBar = [[VIVAEditorViewNavigationTabBar alloc] initWithFrame:CGRectMake(
            [[UIScreen mainScreen] bounds].size.width - 47.5,
            MENU_BUTTON_TOP_ANCHOR * [[UIScreen mainScreen] bounds].size.height + kDeviceCornerRadius / 2,
            MENU_BUTTON_SIZE, ([UIScreen mainScreen].bounds.size.height) * (0.7))];

    UIButton *offsetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *offsetImage = [VIVAResources offsetImageToggled:NO];
    UIImage *offsetImageToggled = [VIVAResources offsetImageToggled:YES];
    [offsetButton setImage:offsetImage forState:UIControlStateNormal];
    [offsetButton setImage:offsetImageToggled forState:UIControlStateHighlighted];
    offsetButton.frame = CGRectMake(0, 0 + (kButtonSpacing + MENU_BUTTON_SIZE) * 0, MENU_BUTTON_SIZE, MENU_BUTTON_SIZE);
    offsetButton.highlighted = YES;

    [tabBar addSubview:offsetButton toTabBarIndex:0];
    // Since the offset view will be the first loaded, we dont need to lower alpha on the button. 

    UIButton *spacerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *spacerImage = [VIVAResources spacerImageToggled:NO];
    UIImage *spacerImageToggled = [VIVAResources spacerImageToggled:YES];
    [spacerButton setImage:spacerImage forState:UIControlStateNormal];
    [spacerButton setImage:spacerImageToggled forState:UIControlStateHighlighted];

    spacerButton.frame = CGRectMake(0, 0 + (kButtonSpacing + MENU_BUTTON_SIZE), MENU_BUTTON_SIZE, MENU_BUTTON_SIZE);

    spacerButton.highlighted = NO;

    [tabBar addSubview:spacerButton toTabBarIndex:1];

    UIButton *iconCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *iCImage = [VIVAResources iconCountImageToggled:NO];
    UIImage *iCImageToggled = [VIVAResources iconCountImageToggled:YES];
    [iconCountButton setImage:iCImage forState:UIControlStateNormal];
    [iconCountButton setImage:iCImageToggled forState:UIControlStateHighlighted];
    iconCountButton.frame = CGRectMake(0, 0 + (kButtonSpacing + MENU_BUTTON_SIZE) * 2, MENU_BUTTON_SIZE, MENU_BUTTON_SIZE);
    iconCountButton.highlighted = NO;

    [tabBar addSubview:iconCountButton toTabBarIndex:2];

    UIButton *scaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *sImage = [VIVAResources scaleImageToggled:NO];
    UIImage *sImageToggled = [VIVAResources scaleImageToggled:YES];
    [scaleButton setImage:sImage forState:UIControlStateNormal];
    [scaleButton setImage:sImageToggled forState:UIControlStateHighlighted];
    scaleButton.frame = CGRectMake(0, 0 + (kButtonSpacing + MENU_BUTTON_SIZE) * 3, MENU_BUTTON_SIZE, MENU_BUTTON_SIZE);
    scaleButton.highlighted = NO;

    [tabBar addSubview:scaleButton toTabBarIndex:3];

    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *settingsImage = [VIVAResources settingsImageToggled:NO];
    UIImage *settingsImageToggled = [VIVAResources settingsImageToggled:YES];
    [settingsButton setImage:settingsImage forState:UIControlStateNormal];
    [settingsButton setImage:settingsImageToggled forState:UIControlStateHighlighted];
    settingsButton.frame = CGRectMake(0, 0 + (kButtonSpacing + MENU_BUTTON_SIZE) * (4), MENU_BUTTON_SIZE, MENU_BUTTON_SIZE);
    settingsButton.highlighted = NO;

    [tabBar addSubview:settingsButton toBackwardsTabBarIndex:0];


    for (UIButton *button in [tabBar subviews])
    {
        [button addTarget:self
                   action:@selector(handleDefaultBarTabButtonPress:)
         forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self
                   action:@selector(buttonPressDown:)
         forControlEvents:UIControlEventTouchDown];
    }

    self.activeButton = offsetButton;

    return tabBar;
}


- (VIVAEditorViewNavigationTabBar *)defaultLeftTabBar
{
    VIVAEditorViewNavigationTabBar *tabBar = [[VIVAEditorViewNavigationTabBar alloc] initWithFrame:CGRectMake(
            8.75,
            MENU_BUTTON_TOP_ANCHOR * [[UIScreen mainScreen] bounds].size.height + kDeviceCornerRadius / 2,
            MENU_BUTTON_SIZE, ([UIScreen mainScreen].bounds.size.height) * (0.7))];

    self.rootButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rootImage = [VIVAResources rootImageToggled:NO];
    UIImage *rootImageToggled = [VIVAResources rootImageToggled:YES];
    [self.rootButton setImage:rootImage forState:UIControlStateNormal];
    [self.rootButton setImage:rootImageToggled forState:UIControlStateHighlighted];
    self.rootButton.frame = CGRectMake(0, 30 + (kButtonSpacing + MENU_BUTTON_SIZE) * 5, MENU_BUTTON_SIZE, MENU_BUTTON_SIZE);
    self.rootButton.highlighted = YES;
    [self.rootButton addTarget:self action:@selector(handleRootButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:self.rootButton toTabBarIndex:0];

    self.dockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *dockImage = [VIVAResources dockImageToggled:NO];
    UIImage *dockImageToggled = [VIVAResources dockImageToggled:YES];
    [self.dockButton setImage:dockImage forState:UIControlStateNormal];
    [self.dockButton setImage:dockImageToggled forState:UIControlStateHighlighted];
    self.dockButton.frame = CGRectMake(0, 30 + (kButtonSpacing + MENU_BUTTON_SIZE) * 6, MENU_BUTTON_SIZE, MENU_BUTTON_SIZE);
    self.dockButton.highlighted = NO;
    [self.dockButton addTarget:self action:@selector(handleDockButtonPress:) forControlEvents:UIControlEventTouchUpInside];

    [tabBar addSubview:self.dockButton toTabBarIndex:1];

    UIButton *loadoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *loadoutImage = [VIVAResources loadoutsToggled:NO];
    UIImage *loadoutImageToggled = [VIVAResources loadoutsToggled:YES];
    [loadoutButton setImage:loadoutImage forState:UIControlStateNormal];
    [loadoutButton setImage:loadoutImageToggled forState:UIControlStateHighlighted];
    loadoutButton.frame = CGRectMake(0, MENU_BUTTON_SIZE * 2, MENU_BUTTON_SIZE, MENU_BUTTON_SIZE);

    [loadoutButton addTarget:self action:@selector(loadLoadouts:) forControlEvents:UIControlEventTouchUpInside];

    // [tabBar addSubview:loadoutButton toBackwardsTabBarIndex:0];

    return tabBar;
}

- (void)handleDefaultBarTabButtonPress:(UIButton *)button
{
    AudioServicesPlaySystemSound(1519);
    NSUInteger index = [self.rightTabBar.subviews indexOfObject:button];

    if (index < 4)
    {
        [self loadControllerView:self.homeTabControllerViews[index]];
        self.activeButton.userInteractionEnabled = YES;

        [UIView animateWithDuration:.2
                         animations:
                                 ^
                                 {
                                     self.activeButton.highlighted = NO;
                                     button.highlighted = YES;
                                 }
        ];

        self.activeButton = button;
        button.userInteractionEnabled = NO;
    }
    else if (index == 4)
    {
        [self handleSettingsButtonPress:button];
    }
    else if (index == 5)
    {
        [self handleRootButtonPress:button];
    }
    else
    {
        [self handleDockButtonPress:button];
    }

    [self performSelector:@selector(doHighlight:) withObject:button afterDelay:0];
}

- (void)doHighlight:(UIButton *)b
{
    [b setHighlighted:YES];
}

- (void)transitionViewsToActivationPercentage:(CGFloat)amount
{
    CGFloat fullAmt = (([[UIScreen mainScreen] bounds].size.height) * 0.15);
    //CGFloat topTranslation = 0-fullAmt + (amount * fullAmt);
    CGFloat bottomTranslation = fullAmt - (amount * fullAmt);
    bottomTranslation *= 2;
    self.activeView.topView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, bottomTranslation);
    self.activeView.bottomView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, bottomTranslation);
    self.rightTabBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, (50 - (50 * amount)), 0);
    self.leftTabBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, (-50 + (50 * amount)), 0);
}

- (void)transitionViewsToActivationPercentage:(CGFloat)amount withDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration
                     animations:
                             ^
                             {
                                 CGFloat fullAmt = (([[UIScreen mainScreen] bounds].size.height) * 0.15);
                                 //CGFloat topTranslation = 0-fullAmt + (amount * fullAmt);
                                 CGFloat bottomTranslation = fullAmt - (amount * fullAmt);
                                 bottomTranslation *= 2;
                                 self.activeView.topView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, bottomTranslation);
                                 self.activeView.bottomView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, bottomTranslation);
                                 self.rightTabBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, (50 - (50 * amount)), 0);
                                 self.leftTabBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, (-50 + (50 * amount)), 0);
                             }
    ];
}

- (void)reload
{
    [[self.view subviews]
            makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _spacingControlView = nil;
    _offsetControlView = nil;
    _settingsView = nil;
    _iconCountControlView = nil;
    _scaleControlView = nil;

    [self viewDidLoad];
}

#pragma mark Editing Location

- (void)handleDockButtonPress:(UIButton *)sender
{
    if ([[[VIVAUIManager sharedInstance] editingLocation] isEqualToString:@"SBIconLocationDock"])
    {
        return;
    }
    AudioServicesPlaySystemSound(1519);
    [[VIVAUIManager sharedInstance] setEditingLocation:@"SBIconLocationDock"];

    [[self.view subviews]
            makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _spacingControlView = nil;
    _offsetControlView = nil;
    _settingsView = nil;
    _iconCountControlView = nil;
    _scaleControlView = nil;

    // Reload views
    [self viewDidLoad];

    self.rootButton.highlighted = NO;
    self.dockButton.highlighted = YES;

}

- (void)handleRootButtonPress:(UIButton *)sender
{
    if ([[[VIVAUIManager sharedInstance] editingLocation] isEqualToString:@"SBIconLocationRoot"])
    {
        return;
    }
    //AudioServicesPlaySystemSound(1519);
    [[VIVAUIManager sharedInstance] setEditingLocation:@"SBIconLocationRoot"];
    [[self.view subviews]
            makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _spacingControlView = nil;
    _offsetControlView = nil;
    _settingsView = nil;
    _iconCountControlView = nil;
    _scaleControlView = nil;

    // Reload views
    [self viewDidLoad];

    self.rootButton.highlighted = YES;
    self.dockButton.highlighted = NO;

}

#pragma mark Settings View

- (VIVAControllerView *)settingsView
{
    // settings table controller hacked into the usual hpcontrollerview model we use. 
    // top view is the entire controller, bottom view is the header. 
    if (!_settingsView)
    {
        _settingsView = [[VIVAControllerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        UIView *settingsContainerView = self.tableViewController.view;
        _settingsView.topView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [_settingsView.topView addSubview:settingsContainerView];
        [_settingsView addSubview:_settingsView.topView];

        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, (([[UIScreen mainScreen] bounds].size.width) / 750) * 300)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, (([[UIScreen mainScreen] bounds].size.width) / 750) * 300)];

        imageView.image = [VIVAUIManager sharedInstance].dynamicallyGeneratedSettingsHeaderImage;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [tableHeaderView addSubview:imageView];

        UIView *doneButtonContainerView = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 80, ((([[UIScreen mainScreen] bounds].size.width) / 750) * 300) - 40, [[UIScreen mainScreen] bounds].size.width / 2, 40)];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(handleDoneSettingsButtonPress:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Done" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 80, 40);
        [doneButtonContainerView addSubview:button];
        _settingsView.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, (TABLE_HEADER_HEIGHT * [[UIScreen mainScreen] bounds].size.width))];
        [_settingsView.bottomView addSubview:doneButtonContainerView];

        [_settingsView.topView addSubview:tableHeaderView];
        [_settingsView addSubview:_settingsView.bottomView];
    }
    _settingsView.hidden = NO;
    _settingsView.alpha = 0;
    return _settingsView;
}


#pragma mark - Controller Views

- (VIVAControllerView *)offsetControlView
{
    if (!_offsetControlView)
    {
        VIVAControllerViewConfiguration config = {
                .topControl = {
                        .itemType = {
                                kVIVAControllerItemTypeSlider
                        },
                        .itemInfo = {
                                .label = @"TOP_OFFSET",
                                .configKey = @"TopInset",
                                .min = -100,
                                .max = (NSInteger) [[UIScreen mainScreen] bounds].size.height,
                                .defaultValue = 0
                        }
                },
                .bottomControl = {
                        .itemType = {
                                kVIVAControllerItemTypeSlider
                        },
                        .itemInfo = {
                                .label = @"LEFT_OFFSET",
                                .configKey = @"SideInset",
                                .min = -400,
                                .max = 400,
                                .defaultValue = 0
                        }
                }
        };
        _offsetControlView = [[VIVAControllerView alloc] initWithFrame:[[UIScreen mainScreen] bounds] config:config];
        _offsetControlView.alpha = 0;
    }
    return _offsetControlView;
}

- (VIVAControllerView *)spacingControlView
{
    if (!_spacingControlView)
    {
        VIVAControllerViewConfiguration config = {
                .topControl = {
                        .itemType = {
                                kVIVAControllerItemTypeSlider
                        },
                        .itemInfo = {
                                .label = @"VERTICAL_SPACING",
                                .configKey = @"vSpacing",
                                .min = -400,
                                .max = 400,
                                .defaultValue = 0
                        }
                },
                .bottomControl = {
                        .itemType = {
                                kVIVAControllerItemTypeSlider
                        },
                        .itemInfo = {
                                .label = @"HORIZONTAL_SPACING",
                                .configKey = @"hSpacing",
                                .min = -200,
                                .max = 400,
                                .defaultValue = 0
                        }
                }
        };
        _spacingControlView = [[VIVAControllerView alloc] initWithFrame:[[UIScreen mainScreen] bounds] config:config];
        _spacingControlView.alpha = 0;
    }
    return _spacingControlView;
}

- (VIVAControllerView *)iconCountControlView
{
    if (!_iconCountControlView)
    {
        VIVAControllerViewConfiguration config = {
                .topControl = {
                        .itemType = {
                                kVIVAControllerItemTypeCounter
                        },
                        .itemInfo = {
                                .label = @"ROWS",
                                .configKey = @"Rows",
                                .min = 1,
                                .max = 14,
                                .defaultValue = 6
                        }
                },
                .bottomControl = {
                        .itemType = {
                                kVIVAControllerItemTypeCounter
                        },
                        .itemInfo = {
                                .label = @"COLUMNS",
                                .configKey = @"Columns",
                                .min = 1,
                                .max = 14,
                                .defaultValue = 4
                        }
                }
        };
        _iconCountControlView = [[VIVAControllerView alloc] initWithFrame:[[UIScreen mainScreen] bounds] config:config];
        _iconCountControlView.alpha = 0;
    }
    return _iconCountControlView;
}

- (VIVAControllerView *)scaleControlView
{
    if (!_scaleControlView)
    {
        VIVAControllerViewConfiguration config = {
                .topControl = {
                        .itemType = {
                                kVIVAControllerItemTypeSlider
                        },
                        .itemInfo = {
                                .label = @"ICON_SCALE",
                                .configKey = @"IconScale",
                                .min = 1,
                                .max = 200,
                                .defaultValue = 100
                        }
                },
                .bottomControl = {
                        .itemType = {
                                kVIVAControllerItemTypeNone
                        },
                        .itemInfo = {
                                .label = @"ICON_CORNER",
                                .configKey = @"IconCorner",
                                .min = -400,
                                .max = 400,
                                .defaultValue = 0
                        }
                }
        };
        _scaleControlView = [[VIVAControllerView alloc] initWithFrame:[[UIScreen mainScreen] bounds] config:config];
        _scaleControlView.alpha = 0;
    }
    return _scaleControlView;
}

- (void)resetAllValuesToDefaults
{

}

#pragma mark Button Handlers

- (void)handleSettingsButtonPress:(UIButton *)sender
{
    VIVASettingsTableViewController *vc = [[VIVASettingsTableViewController alloc] initWithNibName:nil bundle:nil];
    vc.delegate = self;
    [vc viewDidLoad];
    [self presentViewController:vc animated:YES completion:NULL];

    [vc opened];

    self.activeButton = sender;
}

- (void)handleDoneSettingsButtonPress:(UIButton *)sender
{

}

- (void)settingsViewControllerDidDismiss
{
    self.activeButton.highlighted = NO;
    [[VIVALayoutManager sharedInstance] layoutIconViews];
    [[VIVALayoutManager sharedInstance] layoutIndividualIcons];
}

- (void)resignAllTextFields
{
    [self.view endEditing:YES];
}

- (void)loadControllerView:(VIVAControllerView *)arg1
{
    [self resignAllTextFields];

    [UIView animateWithDuration:.2
                     animations:
                             ^
                             {
                                 self.activeView.alpha = 0;
                                 arg1.alpha = 1;
                             }
    ];


    self.activeView = arg1;
    [self transitionViewsToActivationPercentage:1];
}

#pragma mark Springboard Layout Updates

- (void)layoutAllSpringboardIcons
{
    
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self reload];
}

#pragma mark UIViewController overrides

- (BOOL)shouldAutorotate
{
    return [VIVAUtility deviceRotatable];
}


@end
