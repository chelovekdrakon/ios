#import "DateMachine.h"


@interface DateMachine() <UITextFieldDelegate>

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
    
    _stepTextField.delegate = self;
    _dateUnitTextField.delegate = self;
    
    [_startDateTextField addTarget:self action:@selector(handleEditingDidEndStartDate) forControlEvents:UIControlEventAllEditingEvents];
}

-(void)handleEditingDidEndStartDate {
    NSString *text = _startDateTextField.text;
    
    NSDateFormatter *formatter = [self createDateFormatter];
    NSDate* date = [formatter dateFromString:text];
    
    if (text.length > 0 && date) {
        _dateLabel.text = _startDateTextField.text;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (textField == _stepTextField) {
        return [self validateStepTextField:string];
    } else if (textField == _dateUnitTextField) {
        return [self validateDateUnitTextField:string];
    } else {
        return YES;
    }
}

- (BOOL)validateDateUnitTextField:(NSString *)string {
    if (string.length == 0) {
        return YES;
    }
    
    BOOL result = NO;
    
    NSArray *arr = @[@"year", @"month", @"week", @"day", @"hour", @"minute"];
    NSString *text = [NSString stringWithFormat:@"%@%@", _dateUnitTextField.text, string];
    
    for (NSString *str in arr) {
        if (text.length <= str.length) {
            NSString *sub = [str substringToIndex:text.length];
            
            NSComparisonResult compareResult = [sub caseInsensitiveCompare:text];
            
            if (compareResult == NSOrderedSame) {
                result = YES;
                break;
            }
        }
    }
    
    return result;
}

- (BOOL)validateStepTextField:(NSString *)string {
    if (string.length == 0) {
        return YES;
    }
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d" options:0 error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (match) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDateFormatter*)createDateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+3"]];
    [formatter setLocale:[NSLocale autoupdatingCurrentLocale]];
    
    return [formatter autorelease];
}

- (void)createUI {
    UIGenerator *generator = [[UIGenerator alloc] init];
    
    UIView *subview = [generator generateSubview];
    [self.view addSubview:subview];
    _subview = subview;
    
    UILabel *label = [generator generateLabelWithFormatter:_dateFormatter];
    [_subview addSubview:label];
    _dateLabel = label;
    
    
    UITextField *startDateTextField = [generator generateTextFieldOn:@(120) withPlaceholder:@"Start date"];
    [_subview addSubview:startDateTextField];
    _startDateTextField = startDateTextField;
    
    UITextField *stepTextField = [generator generateTextFieldOn:@(190) withPlaceholder:@"Step"];
    [_subview addSubview:stepTextField];
    _stepTextField = stepTextField;
    
    UITextField *dateUnitTextField = [generator generateTextFieldOn:@(260) withPlaceholder:@"Date unit"];
    [_subview addSubview:dateUnitTextField];
    _dateUnitTextField = dateUnitTextField;
    
    
    UIButton *addButton = [generator generateButtonOn:@[@(10), @(345)] withTitle:@"Add"];
    [_subview addSubview:addButton];
    _addButton = addButton;
    
    [_addButton addTarget:self action:@selector(onAddClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *subButton = [generator generateButtonOn:@[@(180), @(345)] withTitle:@"Sub"];
    [_subview addSubview:subButton];
    _subButton = subButton;
    
    
    [_subButton addTarget:self action:@selector(onSubClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [generator release];
}

- (void)onAddClick:(id)sender {
    NSString *dateUnit = _dateUnitTextField.text.lowercaseString;
    NSInteger step = [_stepTextField.text integerValue];
    
    if (step && dateUnit.length) {
        NSString *text = [self getNextDateWith:dateUnit and:1];
        _dateLabel.text = text;
    }
}

- (NSString *)getNextDateWith:(NSString *)dateUnit and:(NSInteger )multiplier {
    NSDateFormatter *formatter = [self createDateFormatter];
    // I could not use _dateFormatter here : why ? (Crash : BAD_ACCESS)
    
    NSInteger step = [_stepTextField.text integerValue] * multiplier;
    
    NSString *currDateString = _dateLabel.text;
    
    NSDate *currDate = [formatter dateFromString:currDateString];
    
    NSDateComponents *dateComponent = [[NSDateComponents alloc] init];
    
    if ([dateUnit isEqualToString:@"year"]) {
        dateComponent.year = step;
    } else if ([dateUnit isEqualToString:@"month"]) {
        dateComponent.month = step;
    } else if ([dateUnit isEqualToString:@"day"]) {
        dateComponent.day = step;
    } else if ([dateUnit isEqualToString:@"hour"]) {
        dateComponent.hour = step;
    } else if ([dateUnit isEqualToString:@"minute"]) {
        dateComponent.minute = step;
    } else if ([dateUnit isEqualToString:@"week"]) {
        dateComponent.weekOfMonth = step;
    }
    
    NSDate *nextDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:currDate options:0];
    
    NSString* text = [[NSString alloc] initWithString:[formatter stringFromDate:nextDate]];
    
    return [text autorelease];
}

- (void)onSubClick:(id)sender {
    NSString *dateUnit = _dateUnitTextField.text.lowercaseString;
    NSInteger step = [_stepTextField.text integerValue];
    
    if (step && dateUnit.length) {
        NSString *text = [self getNextDateWith:dateUnit and:-1];
        _dateLabel.text = text;
    }
}

@end
