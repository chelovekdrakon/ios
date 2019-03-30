//
//  TranslatorRoman+parseTen.h
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman.h"

NS_ASSUME_NONNULL_BEGIN

@interface TranslatorRoman (parseTen)
- (NSMutableString *)parseTen:(double)number;
@end

NS_ASSUME_NONNULL_END
