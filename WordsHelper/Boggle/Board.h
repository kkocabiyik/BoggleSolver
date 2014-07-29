//
//  Board.h
//  boggle-solve-objc-xcode
//
//  Created by Chris Wilcox on 8/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#define MIN_WORD_LENGTH 3

@interface Board : NSObject

@property (nonatomic) NSUInteger row;
@property (nonatomic) NSUInteger column;
@property (strong,  nonatomic) 	NSMutableArray *board;

//- (NSString *) description;

- (id) initRandomWithRow:(NSUInteger) r andColumn:(NSUInteger) c;
- (id) initWithString:(NSString *)boardString row:(NSUInteger) row andColumn:(NSUInteger) column;

- (NSString *) atX:(int)x Y:(int)y;
- (int) calculateScoreForWord:(NSString *)s;

@end
