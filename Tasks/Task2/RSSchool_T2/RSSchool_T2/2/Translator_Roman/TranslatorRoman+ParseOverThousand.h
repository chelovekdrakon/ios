//
//  TranslatorRoman+ParseOverThousand.h
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman.h"

@interface TranslatorRoman (ParseOverThousand)

- (NSMutableString *)parseOverThousand:(double)number;

@end
