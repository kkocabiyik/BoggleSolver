//
//  Board.m
//  boggle-solve-objc-xcode
//
//  Created by Chris Wilcox on 8/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Board.h"


@implementation Board

- (id) initWithString:(NSString *)boardString row:(NSUInteger) r andColumn:(NSUInteger) c{
	
	if ( (self = [self init]) != nil ) {
		
        
        self.row = r;
        self.column = c;
        
		if (boardString.length != self.row*self.column) {
            
			[NSException raise:@"InvalidBoard" format:@"Invalid board size: %d", boardString.length];
            
        }
        
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		
        for (int i=0; i<boardString.length; i++)  {
		
            [tempArray addObject:[NSString stringWithFormat:@"%C", [[boardString lowercaseString] characterAtIndex:i]]];
		
        }
        
        self.board = [NSMutableArray arrayWithArray:tempArray];
        
		return self;
        
	}
    
    return self;
}


-(id) initRandomWithRow:(NSUInteger) r andColumn:(NSUInteger) c{
    
    self = [super init];
    
    if(self) {
        
        self.row = r;
        self.column = c;
        
        self.board = [NSMutableArray new];
        
        NSArray *ar = @[ @{ @"a" : [NSNumber numberWithInt:127]  } ,  @{@"b" : [NSNumber numberWithInt:15]  } , @{@"c" : [NSNumber numberWithInt:12]} , @{@"ç":[NSNumber numberWithInt:12]} , @{@"d":[NSNumber numberWithInt:22]} , @{@"e" : [NSNumber numberWithInt:88]}, @{@"f":[NSNumber numberWithInt:10]}, @{@"g":[NSNumber numberWithInt:12]} ,@{@"ğ" :[NSNumber numberWithInt:5]}, @{@"h":[NSNumber numberWithInt:12]} , @{@"ı":[NSNumber numberWithInt:41]} , @{@"i":[NSNumber numberWithInt:71]}  , @{@"j":[NSNumber numberWithInt:2]} , @{@"k":[NSNumber numberWithInt:73]} ,  @{@"l":[NSNumber numberWithInt:76]} , @{@"m" : [NSNumber numberWithInt:62]} , @{@"n":[NSNumber numberWithInt:49]}, @{@"o":[NSNumber numberWithInt:28]}  , @{@"ö":[NSNumber numberWithInt:7]} , @{@"p":[NSNumber numberWithInt:15]} , @{@"r":[NSNumber numberWithInt:58]} , @{@"s": [NSNumber numberWithInt:37]}, @{@"ş":[NSNumber numberWithInt:21]} , @{@"t":[NSNumber numberWithInt:50]} , @{@"u":[NSNumber numberWithInt:25]} , @{@"ü":[NSNumber numberWithInt:19]} , @{@"v":[NSNumber numberWithInt:10]} , @{@"y":[NSNumber numberWithInt:22]} , @{@"z":[NSNumber numberWithInt:19]} ];
        
        NSMutableArray *temp =[NSMutableArray new];
        
        for(NSDictionary *dict in ar){
            
            for(NSString *s in dict.allKeys){
                
                int number = [[dict valueForKey:s] intValue];
                
                for(int i = 0 ; i < number ; i++){
                    
                    [temp addObject:s];
                }
            }
            
        }
        
        
        for(int i = 0 ; i < self.row * self.column ; i++){
            
            
            int randomShow = (arc4random() % [temp count]);
            
            NSString *str = [[temp objectAtIndex:randomShow] lowercaseString];
            
            [self.board addObject:[NSString stringWithFormat:@"%C", [[str lowercaseString] characterAtIndex:0]]];
        }
    }
    return self;
}


//- (NSString *)description {
//	NSMutableString *tempString = [[NSMutableString alloc] init];
//	for (int i=0; i<[board count]; i++) {
//		if (i % BOARD_SIZE == 0 && i != 0) {
//			[tempString appendString:@"\n"];
//		}
//		[tempString appendString: (NSString *) [board objectAtIndex:i]];
//	}
//	NSString *ret = [NSString stringWithString: tempString];
//
//	return ret;
//}

- (NSString *)atX:(int)x Y:(int)y {
    
	if (x >= self.column || y >= self.row   || x < 0 || y < 0) {
		return nil;
	}
	return [self.board objectAtIndex:x+self.row*y];
}


-(int) calculateScoreForWord:(NSString *)s{
    
    return s.length ;
    
}


@end
