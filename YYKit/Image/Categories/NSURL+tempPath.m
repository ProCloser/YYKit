//
//  NSURL+tempPath.m
//  YYKit
//
//  Created by xzming on 2018/3/27.
//

#import "NSURL+tempPath.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSURL (tempPath)

-(BOOL)isLocalThumbImage{
    if ([self.query.lowercaseString containsString:@"s="]) {
        return YES;
    }
    return NO;
}

-(NSString *)tempDownloadPath{
    
    NSString *md5str = [NSURL md5:self.absoluteString];
    NSString *path = [NSTemporaryDirectory() stringByAppendingFormat:@"/%@.temp", md5str];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    return path;
}

+ (nullable NSString *)md5:(nullable NSString *)str {
    if (!str) return nil;
    
    const char *cStr = str.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}

@end
