//
//  CALayer+ShadedRoundedLayer.h
//  JustCallMe
//
//  Created by Nilofar Vahab poor on 28/07/2016.
//  Copyright © 2016 Voxygen Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (ShadedRoundedLayer)

- (void) makeShadedRoundedWithCornerRadius:(CGFloat)radius borderColor:(UIColor*)color;


@end
