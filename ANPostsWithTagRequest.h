//
//  ANPostsWithTagRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANRequestReturningPostList.h"

@interface ANPostsWithTagRequest : ANRequestReturningPostList

@property (strong) NSString * tag;

@end