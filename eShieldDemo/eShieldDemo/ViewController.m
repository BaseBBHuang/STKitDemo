//
//  ViewController.m
//  eShieldDemo
//
//  Created by 乔贝斯 on 16/9/7.
//  Copyright © 2016年 FFT. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CoreTelephonyDefines.h>
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include "CoreTelephony.h"


void ConnectionCallback(CTServerConnectionRef connection, CFStringRef string, CFDictionaryRef dictionary, void *data) {
    NSLog(@"ConnectionCallback");
    CFShow(dictionary);
}


@interface ViewController ()
{
    void *conn;
    struct CTResult it;
    CFMutableDictionaryRef dict;
}

@property (nonatomic, strong)NSMutableDictionary *stkMenuDic;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectItemButton;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initServerConnectionCreate];
    [self readSTKMenu];
   // [self selectSTKMenuItems];
}

- (void)initServerConnectionCreate
{
    conn = _CTServerConnectionCreate(kCFAllocatorDefault, ConnectionCallback,NULL);
}

// You can use this method to read the STK Menu
- (void)readSTKMenu
{
    _CTServerConnectionCopySIMToolkitMenu(conn, &dict);
    self.stkMenuDic = (__bridge NSMutableDictionary *)(dict);
    NSLog(@"STK Menu List is: %@", self.stkMenuDic);
    NSMutableArray *stkArr = self.stkMenuDic[@"kCTSIMToolkitMenuItems"];
    NSDictionary *itemDic = [stkArr objectAtIndex:0]; // select the first one
    NSString *str = itemDic[@"kCTSIMToolkitText"];
    self.displayLabel.text = str;
}

// select one of STKMenuItems
- (void)selectSTKMenuItems
{
    int selectItem = 0;
    _CTServerConnectionSelectSIMToolkitMenuItem(conn, selectItem);
}
- (IBAction)selectItemClick:(id)sender {
    [self selectSTKMenuItems];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
