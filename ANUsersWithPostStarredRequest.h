//
//  ANUsersWithPostStarredRequest.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/7/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANAuthenticatedRequest.h"

@interface ANUsersWithPostStarredRequest : ANAuthenticatedRequest

@property (assign) ANResourceID postID;

- (void)sendRequestWithCompletion:(ANUserListRequestCompletion)completion;

@end
