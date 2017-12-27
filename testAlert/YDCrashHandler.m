//
//  YDCrashHandler.m
//  MyPersonalLibrary
//  This file is part of source code lessons that are related to the book
//  Title: Professional IOS Programming
//  Publisher: John Wiley & Sons Inc
//  ISBN 978-1-118-66113-0
//  Author: Peter van de Put
//  Company: YourDeveloper Mobile Solutions
//  Contact the author: www.yourdeveloper.net | info@yourdeveloper.net
//  Copyright (c) 2013 with the author and publisher. All rights reserved.
//

#import "YDCrashHandler.h"
#import <UIKit/UIKit.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString * const YDCrashHandlerSignalExceptionName = @"YDCrashHandlerSignalExceptionName";
NSString * const YDCrashHandlerSignalKey = @"YDCrashHandlerSignalKey";
NSString * const YDCrashHandlerAddressesKey = @"YDCrashHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@interface YDCrashHandler ()<UIAlertViewDelegate>

@end

@implementation YDCrashHandler
+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (
         i = UncaughtExceptionHandlerSkipAddressCount;
         i < UncaughtExceptionHandlerSkipAddressCount +
         UncaughtExceptionHandlerReportAddressCount;
         i++)
        {
	 	[backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
        }
    free(strs);
    
    return backtrace;
}

- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex
{
        //if (anIndex == 0)
        //    {
    dismissed = YES;
        //    }
}



- (void)handleException:(NSException *)exception
{
    UIAlertView *thisAlert = [[UIAlertView alloc] initWithTitle:@"程序要挂了~"  message:@"大兄弟,要挂了啊~凉了~凉了~" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    dispatch_async(dispatch_get_main_queue(), ^{
//    });
    [thisAlert show];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"showAlert" object:nil];
	
	CFRunLoopRef runLoop = CFRunLoopGetCurrent();
	CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
	
	while (!dismissed)
        {
		for (NSString *mode in (NSArray *)CFBridgingRelease(allModes))
            {
			CFRunLoopRunInMode((CFStringRef)CFBridgingRetain(mode), 0.001, false);
            }
        }
	
	CFRelease(allModes);
    
	NSSetUncaughtExceptionHandler(NULL);
	signal(SIGABRT, SIG_DFL);
	signal(SIGILL, SIG_DFL);
	signal(SIGSEGV, SIG_DFL);
	signal(SIGFPE, SIG_DFL);
	signal(SIGBUS, SIG_DFL);
	signal(SIGPIPE, SIG_DFL);
	
	if ([[exception name] isEqual:YDCrashHandlerSignalExceptionName])
        {
		kill(getpid(), [[[exception userInfo] objectForKey:YDCrashHandlerSignalKey] intValue]);
        }
	else
        {
		[exception raise];
        }
}
@end

void HandleException(NSException *exception)
{
	int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
	if (exceptionCount > UncaughtExceptionMaximum)
        {
		return;
        }
	
	NSArray *callStack = [YDCrashHandler backtrace];
	NSMutableDictionary *userInfo =
    [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
	[userInfo
     setObject:callStack
     forKey:YDCrashHandlerAddressesKey];
	
	[[[YDCrashHandler alloc] init]
     performSelectorOnMainThread:@selector(handleException:)
     withObject:
     [NSException
      exceptionWithName:[exception name]
      reason:[exception reason]
      userInfo:userInfo]
     waitUntilDone:YES];
}

void SignalHandler(int signal)
{
	int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
	if (exceptionCount > UncaughtExceptionMaximum)
        {
		return;
        }
	
	NSMutableDictionary *userInfo =
    [NSMutableDictionary
     dictionaryWithObject:[NSNumber numberWithInt:signal]
     forKey:YDCrashHandlerSignalKey];
    
	NSArray *callStack = [YDCrashHandler backtrace];
	[userInfo
     setObject:callStack
     forKey:YDCrashHandlerAddressesKey];
	
	[[[YDCrashHandler alloc] init]
     performSelectorOnMainThread:@selector(handleException:)
     withObject:
     [NSException
      exceptionWithName:YDCrashHandlerSignalExceptionName
      reason:
      [NSString stringWithFormat:@"Signal %d was raised.", signal]
      userInfo:
      [NSDictionary
       dictionaryWithObject:[NSNumber numberWithInt:signal]
       forKey:YDCrashHandlerSignalKey]]
     waitUntilDone:YES];
}

void InstallCrashExceptionHandler()
{
	NSSetUncaughtExceptionHandler(&HandleException);
	signal(SIGABRT, SignalHandler);
	signal(SIGILL, SignalHandler);
	signal(SIGSEGV, SignalHandler);
	signal(SIGFPE, SignalHandler);
	signal(SIGBUS, SignalHandler);
	signal(SIGPIPE, SignalHandler);
}
 
