//
//  CoreTelephony.h
//  eShieldDemo
//
//  Created by 乔贝斯 on 16/9/9.
//  Copyright © 2016年 FFT. All rights reserved.
//

#ifndef CoreTelephony_h
#define CoreTelephony_h


struct CTResult
{
    int flag;
    int a;
};

struct __CTServerConnection {
    int a;
    int b;
    CFMachPortRef myport;
    int c;
    int d;
    int e;
    int f;
    int g;
    int h;
    int i;
};
typedef struct __CTServerConnection CTServerConnection;
typedef CTServerConnection* CTServerConnectionRef;

struct __CellInfo {
    int servingmnc;
    int network;
    int location;
    int cellid;
    int station;
    int freq;
    int rxlevel;
    int c1;
    int c2;
};
typedef struct __CellInfo CellInfo;
typedef CellInfo* CellInfoRef;

typedef void (*CTServerConnectionCallback)(CTServerConnectionRef, CFStringRef, CFDictionaryRef, void *);

CTServerConnectionRef _CTServerConnectionCreate(CFAllocatorRef allocator, CTServerConnectionCallback, int *unknown);

int *_CTServerConnectionCopySIMToolkitMenu (struct __CTServerConnection * Connection, CFMutableDictionaryRef * Dictionary);

void *_CTServerConnectionSelectSIMToolkitMenuItem(struct __CTServerConnection *Connection, int item);

#endif /* CoreTelephony_h */
