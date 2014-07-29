//
//  WHSolverViewController.h
//  WordsHelper
//
//  Created by Kemal Kocabiyik on 10/27/13.
//  Copyright (c) 2013 Ovidos Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "BoggleSolver.h"
@interface WHSolverViewController : UIViewController <UITextFieldDelegate , UITableViewDataSource , UITableViewDelegate>

@property (strong,nonatomic) NSMutableDictionary *wordPaths;
@property (strong,nonatomic) NSMutableDictionary *words;
/*UI Controls*/
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (weak, nonatomic) IBOutlet UITextField *wordsTextField;
@property (weak, nonatomic) IBOutlet UITableView *wordsTableView;
@property (weak, nonatomic) IBOutlet UIView *lettersView;
@property (strong,nonatomic) NSMutableArray *lettersViewArray;
/*UI EVENTS*/
-(IBAction)solveClicked:(id)sender;
@end
