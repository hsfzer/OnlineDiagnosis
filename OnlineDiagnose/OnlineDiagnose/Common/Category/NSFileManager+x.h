//
//  NSFileManager+NSFileManagerx.h
//  MemoLite
//
//  Created by czh0766 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (x)

+(NSString*) pathInDocuments:(NSString*)path;

+(NSString*) pathInLibrary:(NSString*)path;

+(NSString*) pathInLibraryCaches:(NSString*)path;

-(NSArray*) subpathsInDocuments:(NSString*)directory;

-(NSArray*) subpathsInLibrary:(NSString*)directory;

-(BOOL) deleteFileAtPath:(NSString*)path;

@end
