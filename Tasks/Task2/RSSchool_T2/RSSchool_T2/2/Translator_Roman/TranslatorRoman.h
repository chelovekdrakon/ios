//
//  TranslatorRoman.h
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TranslatorRoman : NSObject

@property(readonly) NSDictionary *mapArabicToRoman;

- (NSString *)translateToArabic:(NSString *)romanString;

@end

