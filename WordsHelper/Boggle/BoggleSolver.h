//
//  BoggleSolver.h
//  boggle-solve-objc-xcode
//
//  Created by Chris Wilcox on 8/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Dictionary.h"
#import "Board.h"

@interface BoggleSolver : NSObject {
	
	Board *lastBoard;
}

@property (strong , nonatomic) Dictionary *dict;
@property (strong , nonatomic) NSDictionary *lastSolution;

- (NSDictionary *) solve: (Board *)board;

@end
