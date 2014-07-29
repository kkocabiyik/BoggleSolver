//
//  Dictionary.m
//  boggle-solve-objc-xcode
//
//  Created by Chris Wilcox on 8/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Dictionary.h"


@implementation Dictionary

- (id) init {
	if (self = [super init]) {
		
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dictionary" ofType:@"txt"];
        NSString *stringFromFile = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
		NSMutableArray *wordsArray = [[NSMutableArray alloc] init];
		
        NSArray *ar =[stringFromFile componentsSeparatedByString:@"\n"];
		for (NSString *word in ar ) {
			if (!([word isEqualToString:@""]) && [[word substringToIndex:1] isEqualToString: [[word substringToIndex:1] lowercaseString]]) {
				[wordsArray addObject:word];
			} 
		}
		
		trie = [NDTrie trieWithArray:wordsArray];
	
	}
	return self;
}

- (BOOL) checkWord: (NSString *)word {
	BOOL found = [trie containsString:word];
	return found;
}

- (NSArray *) checkPrefix:(NSString *)prefix {
    
	if ([trie containsStringWithPrefix:prefix]) {
        
        NSArray * ar =[trie everyStringWithPrefix:prefix];
        
        if([ar count] == 0){
            return [[NSArray alloc ] initWithObjects:prefix, nil];
        }else
            return ar;
        
	} else {
		return [[NSArray alloc] init];
	}
}

- (int) countl {
	return [trie count];
}

@end