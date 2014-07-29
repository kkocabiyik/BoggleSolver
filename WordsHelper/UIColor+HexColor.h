//
//  UIColor+HexColor.h
//  LogBook
//
//  Created by KEMAL KOCABIYIK on 3/16/12.
//  Copyright (c) 2012 Koc University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIColor *)lighterColorForColor:(UIColor *)c;
+ (UIColor *)darkerColorForColor:(UIColor *)c;
@end
