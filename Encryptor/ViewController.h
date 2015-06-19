//
//  ViewController.h
//  Encryptor
//
//  Created by Erik Arakelyan on 4/28/15.
//  Copyright (c) 2015 Erik Arakelyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(NSString *)encrypt:(NSString *)string withKey:(NSString *)key;
- (NSString*) decrypt:(NSString*)string withKey:(NSString*)key;
-(NSArray *)frameSBox:(NSString *)keyValue;


@end

