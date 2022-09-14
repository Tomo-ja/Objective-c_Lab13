//
//  ViewController.m
//  Lab13
//
//  Created by Tomonao Hashiguchi on 2022-09-14.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableAttributedString *textSofar;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setTextSofar: [[NSMutableAttributedString alloc] init]];
}

- (NSMutableAttributedString *)makeWordRed: (NSString *)word
{
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:word];
	[text addAttribute:NSForegroundColorAttributeName value:[UIColor systemRedColor] range:NSMakeRange(0, word.length)];
	return text;
}

- (void)inputValueAdded: (NSString *)inputValue
{
	if ([[inputValue substringFromIndex: inputValue.length - 1] isEqualToString:@" "]){
		NSString *tempString = [inputValue stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
		NSArray *words = [tempString componentsSeparatedByString:@" "];
		self.textSofar = [[NSMutableAttributedString alloc] init];
		for (NSString *word in words) {
			
			if([[word lowercaseString] isEqualToString:@"red"]) {
				[self.textSofar appendAttributedString: [self makeWordRed: word]];
			} else {
				[self.textSofar appendAttributedString: [[NSMutableAttributedString alloc] initWithString:word]];
			}
			[self.textSofar appendAttributedString:	[[NSMutableAttributedString alloc] initWithString: @" "]];
		}
	} else {
		[[self textSofar] appendAttributedString: [[NSMutableAttributedString alloc] initWithString:[inputValue substringFromIndex: inputValue.length - 1]]];
	}
}

-(void)inputValueDeleted
{
	[[self textSofar] deleteCharactersInRange: [self.textSofar.string rangeOfComposedCharacterSequenceAtIndex: self.textSofar.length - 1]];
}

- (IBAction)onChangeInputValue:(UITextField *)sender {
	if (sender.text.length == 0) { return; }

	if (sender.text.length < self.textSofar.length){
		[self inputValueDeleted];
	} else if (sender.text.length > self.textSofar.length) {
		[self inputValueAdded: sender.text];
	} else {
		return;
	}

	[_inputField setAttributedText: self.textSofar];
}

@end
