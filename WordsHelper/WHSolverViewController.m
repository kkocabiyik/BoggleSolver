//
//  WHSolverViewController.m
//  WordsHelper
//
//  Created by Kemal Kocabiyik on 10/27/13.
//  Copyright (c) 2013 Ovidos Creative. All rights reserved.
//

#import "WHSolverViewController.h"
#import "UIColor+HexColor.h"

@interface WHSolverViewController ()

@end

@implementation WHSolverViewController{
    
    Board *board;
    BoggleSolver *solver;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.solveButton.enabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Instance Methods


-(void) initializeBoardView:(NSMutableArray *) array{
    
    for(UIView *v in self.lettersViewArray){
        [v removeFromSuperview];
    }
    
    if(self.lettersViewArray){
        [self.lettersViewArray removeAllObjects];
    }
    
    self.lettersViewArray= [NSMutableArray new];
    
    double rectWidth =  self.lettersView.frame.size.width / (double) 4;
    double rectHeight = self.lettersView.frame.size.height / (double) 4;
    
    int centerX = rectWidth / (double) 2;
    int centerY = rectHeight / (double) 2;
    
    for(int i = 0 ; i < array.count ; i++){
        
        if(i % 4 == 0){
            
            if(i != 0){
                centerY += rectHeight;
            }
            
            centerX = rectWidth / (double) 2;
            
        }else{
            centerX += rectWidth;
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rectWidth-5, rectHeight-5)];
        view.center = CGPointMake(centerX + 1, centerY + 1);
        view.layer.borderWidth = 2;
        view.layer.borderColor = [[UIColor redColor] CGColor];
        view.layer.cornerRadius = 30;
        view.tintColor = [UIColor redColor];
        
        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        label.text = [[array objectAtIndex:i] uppercaseStringWithLocale:[NSLocale localeWithLocaleIdentifier:@"tr-TR"]];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:25];
        [view addSubview:label];
        
        [self.lettersView addSubview:view];
        [self.lettersViewArray addObject:view];
        
    }
}

#pragma mark - Events


-(IBAction)solveClicked:(id)sender{
    board = [[Board alloc] initWithString:self.wordsTextField.text row:4 andColumn:4];
    [self initializeBoardView:board.board];
    [self solveWithBoard:board];
    [self.wordsTextField resignFirstResponder];
}

#pragma mark - Solver

- (void)solveWithBoard:(Board *) b{
    
    [NSThread detachNewThreadSelector:@selector(solveBoardInBackground:) toTarget:self withObject:b];
}

- (void)solveBoardInBackground:(Board *)b {
    
    @autoreleasepool {
        
        solver = [[BoggleSolver alloc] init];
        
        NSDictionary *solutions = [solver solve:board];
        
        
        [self performSelectorOnMainThread:@selector(handleSolutionArray:) withObject:solutions waitUntilDone:YES];
    }
}

- (void)handleSolutionArray:(NSDictionary *)_solutions {
    
    
    
    NSArray *sorted = [[_solutions allKeys] sortedArrayWithOptions:NSSortStable usingComparator:^(id obj1, id obj2) {
        
        return [obj1 length] <= [obj2 length];
    }];
    
    self.wordPaths = [[NSMutableDictionary alloc] initWithDictionary:_solutions];
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary new];
    
    for(NSString *word in sorted){
        
        NSString *key= [NSString stringWithFormat:@"%d" ,word.length];
        NSMutableArray *ar = [mutableDict objectForKey:key];
    
        if(ar){
            [ar addObject:word];
        }else{
            [mutableDict setObject:[[NSMutableArray alloc] initWithObjects:word, nil] forKey:key];
        }
    }
    
    
    self.words = mutableDict;
    
    [self.wordsTableView reloadData];
    
}

#pragma mark - TextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if([string isEqualToString:@" "])return NO;
    
    if (range.length == 0 && [textField.text stringByAppendingString:string].length >= 16 ){
        
        if(textField.text.length < 16)
            textField.text = [textField.text stringByAppendingString:string];
        
        self.solveButton.enabled = YES;
        return NO;
        
    }
    self.solveButton.enabled = NO;
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.solveButton.enabled = NO;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - TableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    for(UIView *v in self.lettersViewArray){
        [v setTintColor:[UIColor redColor]];
        
        for(id a in v.subviews){
            if([a isKindOfClass:[UILabel class]]){
                [a setTextColor:[UIColor redColor]];
            }
        }
        
        v.layer.borderColor = [[UIColor redColor] CGColor];
    }
    
    id keys = [self.words.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSString *word= [[self.words objectForKey:[keys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    NSDictionary *dict= [self.wordPaths objectForKey:word ];
    
    for(id str in dict.allKeys){
        
        NSArray *ar = [str componentsSeparatedByString:@","];
        int x = [[ar objectAtIndex:0] intValue];
        int y = [[ar objectAtIndex:1] intValue];
        
        int index = x + (y * 4);
        UIView *v = [self.lettersViewArray objectAtIndex:index];
        
        v.layer.borderColor = [[UIColor colorWithHexString:@"27ae60"] CGColor];
        for(id a in v.subviews){
            if([a isKindOfClass:[UILabel class]]){
                [a setTextColor:[UIColor colorWithHexString:@"27ae60"] ];
            }
        }
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WordCell"];
    
    if(!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WordCell"];
    }
        id keys = [self.words.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    /*DICTIONARY : { "1" : [NSMUTABLEARRAY] , "2" : [NSMUTABLEARRAY"] } */
    cell.textLabel.text = [[self.words objectForKey:[keys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.words.allKeys.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    id keys = [self.words.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return [NSString stringWithFormat:@"%@ LETTERS" , [keys objectAtIndex:section]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    id keys = [self.words.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return [[self.words objectForKey:[keys objectAtIndex:section]] count];
}

@end
