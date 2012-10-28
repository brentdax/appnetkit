//
//  ANFiltersForCurrentUserRequest.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"

@interface ANFiltersForCurrentUserRequest : ANAuthenticatedRequest

- (void)sendRequestWithCompletion:(ANFilterListRequestCompletion)completion;

@end
