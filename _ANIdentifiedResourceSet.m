//
//  _ANIdentifiedResourceSet.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/27/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "_ANIdentifiedResourceSet.h"

// Basically just a safer version of +[NSValue valueWithNonretainedObject:]
@interface _ANWeakReference : NSObject

+ (id)weakReferenceWithReferent:(id)referent;
- (id)initWithReferent:(id)referent;

@property (nonatomic,readonly,weak) id referent;

@end

@interface _ANIdentifiedResourceSet ()

@property (strong,nonatomic) NSMutableDictionary * resources;

@end

@implementation _ANIdentifiedResourceSet

- (id)init {
    if((self = [super init])) {
        _resources = [NSMutableDictionary new];
    }
    return self;
}

- (void)addResource:(ANIdentifiedResource *)resource {
    _ANWeakReference * ref = [_ANWeakReference weakReferenceWithReferent:resource];
    
    NSMutableDictionary * resourcesByID = [self resourcesByIDForClassOfResource:resource];
    id <NSCopying> IDKey = [self IDKeyForIdentifiedResource:resource];
    [resourcesByID setObject:ref forKey:IDKey];
}

- (ANIdentifiedResource *)existingResource:(ANIdentifiedResource *)resource {
    NSDictionary * resourcesByID = [self resourcesByIDForClassOfResource:resource];
    id <NSCopying> IDKey = [self IDKeyForIdentifiedResource:resource];
    _ANWeakReference * resourceReference = [resourcesByID objectForKey:IDKey];
    
    return resourceReference.referent;
}

- (void)removeResource:(ANIdentifiedResource *)resource {
    if([self existingResource:resource] != resource) {
        return;
    }
    
    NSMutableDictionary * resourcesByID = [self resourcesByIDForClassOfResource:resource];
    id <NSCopying> IDKey = [self IDKeyForIdentifiedResource:resource];
    [resourcesByID removeObjectForKey:IDKey];
}

- (id <NSCopying>)classKeyForIdentifiedResource:(ANIdentifiedResource*)resource {
    return NSStringFromClass(resource.class);
}

- (id <NSCopying>)IDKeyForIdentifiedResource:(ANIdentifiedResource*)resource {
    return [NSNumber numberWithUnsignedLongLong:resource.ID];
}

- (NSMutableDictionary*)resourcesByIDForClassOfResource:(ANIdentifiedResource*)resource {
    id <NSCopying> classKey = [self classKeyForIdentifiedResource:resource];
    
    NSMutableDictionary * resourcesByID = [self.resources objectForKey:classKey];
    if(!resourcesByID) {
        resourcesByID = [NSMutableDictionary new];
        [self.resources setObject:resourcesByID forKey:classKey];
    }
    
    return resourcesByID;
}

@end

@implementation _ANWeakReference

+ (id)weakReferenceWithReferent:(id)referent {
    return [[self alloc] initWithReferent:referent];
}

- (id)initWithReferent:(id)referent {
    if((self = [super init])) {
        _referent = referent;
    }
    return self;
}

@end
