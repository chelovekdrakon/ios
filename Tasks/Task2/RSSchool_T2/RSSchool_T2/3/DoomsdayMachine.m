#import "DoomsdayMachine.h"
#import "AssimilationInfo.h"

@interface DoomsdayMachine()
@property(readonly)NSString *doomsDay;
@end

@implementation DoomsdayMachine

-(id) init {
    self = [super init];
    
    if (self) {
        NSString *str = [[NSString alloc] initWithString:@"Sunday, August 14, 2208"];
        _doomsDay = str;
    }
    
    return self;
}

- (void)dealloc {
    [_doomsDay release];
    [super dealloc];
}

- (NSString *)doomsdayString {
    return _doomsDay;
}

- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString {
    AssimilationInfo *assibilationInfo = [[AssimilationInfo alloc] initWithDate:dateString];
    
    return [assibilationInfo autorelease];
}

@end
