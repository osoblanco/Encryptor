//
//  ViewController.m
//  Encryptor
//
//  Created by Erik Arakelyan on 4/28/15.
//  Copyright (c) 2015 Erik Arakelyan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textForEncrypt;
@property (weak, nonatomic) IBOutlet UITextField *keyForEncrypt;
@property (nonatomic, strong) NSArray * key;
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (nonatomic, strong) NSMutableArray * sBox;
@end

@implementation ViewController


static const int SBOX_LENGTH = 256;
static const int KEY_MIN_LENGTH = 1;
-(void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)encrypt:(id)sender {
    self.result.text=[self encrypt:self.textForEncrypt.text withKey:self.keyForEncrypt.text];
    
}
- (IBAction)decrypt:(id)sender {
    
    self.result.text=[self decrypt:self.textForEncrypt.text withKey:self.keyForEncrypt.text];
}

-(NSString *)encrypt:(NSString *)string withKey:(NSString *)key{
    
    self.sBox = [[self frameSBox:key] mutableCopy];
    unichar code[string.length];
    
    int i = 0;
    int j = 0;
    for (int n = 0; n < string.length; n++) {
        i = (i + 1) % SBOX_LENGTH;
        j = (j + [[self.sBox objectAtIndex:i]integerValue]) % SBOX_LENGTH;
        [self.sBox exchangeObjectAtIndex:i withObjectAtIndex:j];
        
        int index=([self.sBox[i] integerValue]+[self.sBox[j] integerValue]);
        
        int rand=([self.sBox[(index%SBOX_LENGTH)] integerValue]);
        
        code[n]=(rand  ^  (int)[string characterAtIndex:n]);
    }
    const unichar* buffer;
    buffer = code;
    
    return  [NSString stringWithCharacters:buffer length:string.length];
}

- (NSString*) decrypt:(NSString*)string withKey:(NSString*)key
{
    return [self encrypt:string withKey:key];
}


-(NSArray *)frameSBox:(NSString *)keyValue{
    
    NSMutableArray *sBox = [[NSMutableArray alloc] initWithCapacity:SBOX_LENGTH];
    
    int j = 0;
    
    for (int i = 0; i < SBOX_LENGTH; i++) {
        [sBox addObject:[NSNumber numberWithInteger:i]];
    }
    
    for (int i = 0; i < SBOX_LENGTH; i++) {
        j = (j + [sBox[i] integerValue] + [keyValue characterAtIndex:(i % keyValue.length)]) % SBOX_LENGTH;
        [sBox exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:sBox];
}

@end
