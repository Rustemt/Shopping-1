//
//  ImageToDataTransformer.m
//  StudentManager
//
//  Created by Mingle Chang on 13-11-1.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "ImageToDataTransformer.h"

@implementation ImageToDataTransformer
+ (BOOL)allowsReverseTransformation {
	return YES;
}


+ (Class)transformedValueClass {
	return [NSData class];
}


- (id)transformedValue:(id)value {
	return UIImagePNGRepresentation(value);
}


- (id)reverseTransformedValue:(id)value {
	return [[[UIImage alloc] initWithData:value]autorelease];
}
@end
