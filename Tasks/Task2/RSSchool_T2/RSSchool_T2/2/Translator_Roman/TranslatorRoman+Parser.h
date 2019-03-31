//
//  TranslatorRoman+Parser.h
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman.h"

@interface TranslatorRoman (Parser)

- (NSMutableString *)parseDigit:(double)number withMultiplier:(int)multiplier;

@end
