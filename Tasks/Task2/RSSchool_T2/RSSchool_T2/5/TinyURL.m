#import "TinyURL.h"
#import <CommonCrypto/CommonDigest.h>

@interface TinyURL()
@property(readonly)NSString *tinyUrl;
@property(readonly)NSMutableDictionary *originalURLs;
@end

@implementation TinyURL
- (id)init {
    self = [super init];
    if (self) {
        _tinyUrl = @"https://co.co/";
        _originalURLs = [NSMutableDictionary new];
    }
    return self;
}

- (void)dealloc {
    [_originalURLs release];
    [super dealloc];
}

- (NSString *)getMD5Hash:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), digest); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (NSURL *)encode:(NSURL *)originalURL {
    [originalURL retain];
    
    NSString *md5 = [self getMD5Hash:originalURL.absoluteString];
    NSString *key = [NSString stringWithString:[md5 substringWithRange:NSMakeRange(0, 5)]];
    
    [_originalURLs setObject:originalURL.absoluteString forKey:key];
    
    NSString *tinyUrl = [NSString stringWithFormat:@"%@%@", _tinyUrl, key];
    
    [originalURL release];
    
    NSURL *result = [[NSURL alloc] initWithString:tinyUrl];
    
    return [result autorelease];
}

- (NSURL *)decode:(NSURL *)shortenedURL {
    NSString *path = shortenedURL.path;
    NSString *key = [path substringFromIndex:1];
    
    NSURL *result = [[NSURL alloc] initWithString:_originalURLs[key]];
    
    return [result autorelease];
}

@end
