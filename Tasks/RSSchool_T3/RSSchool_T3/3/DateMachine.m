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
}

- (void)onAddClick:(id)sender {
    NSLog(@"onAddClick, sender: %@", sender);
}

- (void)onSubClick:(id)sender {
    NSLog(@"onSubClick, sender: %@", sender);
}

@end
