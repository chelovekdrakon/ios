#import "DateMachine.h"

// capable of adding and substracting dates.

// 3 text fields : "Start date", "Step" and "Date unit" placeholders
// 2 buttons: "Add" and "Sub".
// 1 label: current date (date format: 20/04/2004 04:20)

// "Step" should allow only numbers, it is the step by which the date value should be increased or decreased.
// "Date unit" should only allow these values: year, month, week, day, hour, minute. If is the "what" should be added/subtracted to/from the date by "Step" values.

@interface DateMachine()

@property(retain, nonatomic)NSDateFormatter *dateFormatter;

@property(retain, nonatomic)UIView *subview;

@property(retain, nonatomic)UILabel *dateLabel;

@property(retain, nonatomic)UIButton *addButton;
@property(retain, nonatomic)UIButton *subButton;

@property(retain, nonatomic)UITextField *startDateTextField;
@property(retain, nonatomic)UITextField *stepTextField;
@property(retain, nonatomic)UITextField *dateUnitTextField;

@end


@implementation DateMachine

- (void)viewDidLoad {
  [super viewDidLoad];

    NSDateFormatter *formatter = [self createDateFormatter];
    _dateFormatter = formatter;
    
    [self createUI];
}

- (NSDateFormatter*)createDateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+3"]];
    [formatter setLocale:[NSLocale autoupdatingCurrentLocale]];
    return [formatter autorelease];
}

- (void)createUI {
    UIView *subview = [self generateSubview];
    [self.view addSubview:subview];
    _subview = subview;
    
    UILabel *label = [self generateLabel];
    [_subview addSubview:label];
    _dateLabel = label;
    
    
    UITextField *startDateTextField = [self generateTextFieldOn:@(120) withPlaceholder:@"Start date"];
    [_subview addSubview:startDateTextField];
    _startDateTextField = startDateTextField;
    
    UITextField *stepTextField = [self generateTextFieldOn:@(190) withPlaceholder:@"Step"];
    [_subview addSubview:stepTextField];
    _stepTextField = stepTextField;
    
    UITextField *dateUnitTextField = [self generateTextFieldOn:@(260) withPlaceholder:@"Date unit"];
    [_subview addSubview:dateUnitTextField];
    _dateUnitTextField = dateUnitTextField;
    
    
    UIButton *addButton = [self generateButtonOn:@[@(10), @(345)] withTitle:@"Add"];
    [_subview addSubview:addButton];
    _addButton = addButton;
    
    
    UIButton *subButton = [self generateButtonOn:@[@(180), @(345)] withTitle:@"Sub"];
    [_subview addSubview:subButton];
    _addButton = subButton;
}

- (UIButton *)generateButtonOn:(NSArray *)positions withTitle:(NSString *)title {
    NSNumber *x = positions[0];
    NSNumber *y = positions[1];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x.doubleValue, y.doubleValue, 130, 50)];
    
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return [button autorelease];
}


- (UIView *)generateSubview {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(25, 60, 325, 410)];
    view.backgroundColor = [UIColor blackColor];
    
    return [view autorelease];
}

- (UILabel *)generateLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 70)];
    
    NSString* text = [[NSString alloc] initWithString:[_dateFormatter stringFromDate:[NSDate date]]];
    
    label.backgroundColor = [UIColor redColor];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;

    return [label autorelease];
}

- (UITextField *)generateTextFieldOn:(NSNumber *)position withPlaceholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc]
                              initWithFrame:CGRectMake(20, position.doubleValue, 280, 50)];
    
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = placeholder;
    
    return [textField autorelease];
}

@end
