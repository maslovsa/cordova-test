//
//  ROKOUserObject+ROKOUserObjectMapper.h
//  HelloRoko
//
//  Created by Maslov Sergey on 15.04.16.
//
//

#import <ROKOMobi/ROKOMobi.h>
#import "EasyMapping.h"

@interface ROKOUserObject (ROKOUserObjectMapping)

+ (EKObjectMapping *)objectMapping;

@end
