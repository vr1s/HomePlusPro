//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Mar 22 2020 01:47:48).
//
//  Copyright (C) 1997-2019 Steve Nygard.
//

#import <UIKit/UIButton.h>

@class SBHomeScreenMaterialView, UIView;

@interface SBHomeScreenButton : UIButton
{
    SBHomeScreenMaterialView *_materialView;
}

+ (UIEdgeInsets)backgroundInsets;
+ (id)defaultContentImage;
@property(readonly, nonatomic) SBHomeScreenMaterialView *materialView; // @synthesize materialView=_materialView;
// - (void).cxx_destruct;
@property(readonly, nonatomic) UIView *backgroundView;
- (void)setHighlighted:(BOOL)arg1;
- (void)layoutSubviews;
- (id)initWithFrame:(CGRect)arg1;
- (id)initWithFrame:(CGRect)arg1 backgroundView:(id)arg2;

@end
