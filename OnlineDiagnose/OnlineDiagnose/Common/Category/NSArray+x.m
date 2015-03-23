//
//  NSMutableArray+NSMutableArrayx.m
//  MemoLite
//
//  Created by czh0766 on 11-10-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSArray+x.h"
#import "NSFileManager+x.h"

@implementation NSArray (x)

-(BOOL) writeToFile:(NSString *)path forKey:(NSString*)key {
    NSMutableData* data = [NSMutableData data]; 
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:key];
    [archiver finishEncoding];
    return [data writeToFile:path atomically:YES];
}

-(BOOL)isEmpty {
    return self.count <= 0;
}

-(id)firstObject {
    return [self isEmpty] ? nil : self[0];
}

-(BOOL) containsObjectWithBlock:(BOOL (^)(id))block {
    for (id obj in self) {
        if (block(obj)) {
            return YES;
        }
    }
    return NO;
}

-(NSArray*) subarrayWithBlock:(BOOL (^)(id))block {
    NSMutableArray* subarray = [[NSMutableArray alloc] init];
    for (id obj in self) {
        if (block(obj)) {
            [subarray addObject:obj];
        }
    }
    return subarray;
}

-(NSArray*) arrayGenWithBlock:(id (^)(id))block {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (id obj in self) {
        id e = block(obj);
        if (e) {
            [array addObject:e];
        }
    }
    return array;
}

@end

@implementation NSMutableArray (x)

-(void)removeFirstObject {
    if (![self isEmpty]) {
        [self removeObjectAtIndex:0];
    }
}

-(void) removeObjectsWithCondition:(BOOL (^)(id))condition {
    for (int i = 0; i < [self count]; i++) {
        id e = self[i];
        if (condition(e)) {
            [self removeObject:e];
            i--;
        }
    }
}

+(id) arrayWithContentsOfFile:(NSString *)path forKey:(NSString*)key {
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id array = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    
    return array;
}

@end




