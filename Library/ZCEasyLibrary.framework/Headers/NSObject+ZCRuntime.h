//
//  NSObject+ZCRuntime.h
//  CocoapodsLibrary
//
//  Created by 王志超 on 2017/11/3.
//  Copyright © 2017年 王志超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZCRuntime)

#pragma mark -
/// 添加动态属性
- (void)zc_setValue:(NSObject *)value forKey:(NSString *)key;

/// 获取动态属性value
- (NSString *)zc_valueForKey:(NSString *)key;

#pragma mark -
/**
 查看所有属性
 
 @param zc_catProperty 返回属性名
 @return 返回所有属性数组
 */
- (NSArray<NSString *> *)zc_catProperty:(void (^)(NSString *propertyName, NSString *propertyType))zc_catProperty;

/**
 修改指定属性的值
 
 @param key 属性名
 @param value 值
 */
- (void)zc_setProperty:(NSString *)key value:(id)value;

#pragma mark -

@end
