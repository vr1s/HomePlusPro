//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Mar 22 2020 01:47:48).
//
//  Copyright (C) 1997-2019 Steve Nygard.
//

#import <objc/NSObject.h>

#import <SpringBoard/BSDescriptionProviding-Protocol.h>

@class NSDictionary, NSString;

@interface SBAppLayout : NSObject <NSCopying, BSDescriptionProviding>
{
    long long _cachedAppLayoutType;
    BOOL _hidden;
    long long _configuration;
    long long _environment;
    NSDictionary *_rolesToLayoutItemsMap;
}

+ (id)homeScreenAppLayout;
+ (id)appLayoutWithProtobufRepresentation:(id)arg1;
@property(copy, nonatomic) NSDictionary *rolesToLayoutItemsMap; // @synthesize rolesToLayoutItemsMap=_rolesToLayoutItemsMap;
@property(readonly, nonatomic, getter=isHidden) BOOL hidden; // @synthesize hidden=_hidden;
@property(readonly, nonatomic) long long environment; // @synthesize environment=_environment;
@property(nonatomic) long long configuration; // @synthesize configuration=_configuration;
// - (void).cxx_destruct;
- (id)descriptionBuilderWithMultilinePrefix:(id)arg1;
- (id)descriptionWithMultilinePrefix:(id)arg1;
- (id)succinctDescriptionBuilder;
- (id)succinctDescription;
@property(readonly, copy) NSString *description;
@property(readonly, nonatomic, getter=isInsetForHomeAffordance) BOOL insetForHomeAffordance;
- (id)appLayoutWithItemsPassingTest:(id /* CDUnknownBlockType */)arg1;
- (long long)compare:(id)arg1;
- (BOOL)isEqual:(id)arg1;
@property(readonly) NSUInteger hash;
// - (id)copyWithZone:(_NSZone )arg1;
- (id)appLayoutByModifyingHiddenState:(BOOL)arg1;
@property(readonly, nonatomic) long long type;
- (id)allItems;
- (long long)layoutRoleForItem:(id)arg1;
- (BOOL)containsItemWithUniqueIdentifier:(id)arg1;
- (BOOL)containsItemWithBundleIdentifier:(id)arg1;
- (BOOL)containsItem:(id)arg1;
- (BOOL)containsAnyItemFromSet:(id)arg1;
- (void)enumerate:(id /* CDUnknownBlockType */)arg1;
- (id)itemForLayoutRole:(long long)arg1;
- (id)protobufRepresentation;
- (id)plistRepresentation;
- (id)initWithPlistRepresentation:(id)arg1;
- (id)initWithItemsForLayoutRoles:(id)arg1 configuration:(long long)arg2 environment:(long long)arg3 hidden:(BOOL)arg4;
- (id)initWithItemsForLayoutRoles:(id)arg1 configuration:(long long)arg2 environment:(long long)arg3;
- (id)init;
- (NSUInteger)frameOptions;

@end
