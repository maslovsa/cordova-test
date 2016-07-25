#import <UIKit/UIKit.h>
#import "RMPPortalManager.h"
#import <ROKOMobi/ROKOMobi.h>
#import "ROKOPortalInfo+ROKOPortalInfoMapper.h"
#import "ROKOSessionInfo+ROKOSessionInfoMapper.h"
#import "ROKOUserObject+ROKOUserObjectMapper.h"

NSString *const kUserNameKey = @"userName";
NSString *const kPasswordKey = @"type";
NSString *const kReferralCodeKey = @"referralCode";
NSString *const kShareChannelKey = @"shareChannel";
NSString *const kEmailKey = @"email";
NSString *const kAmbassadorCodeKey = @"ambassadorCode";
NSString *const kLinkShareChannel = @"linkShareChannel";

@interface RMPPortalManager () {
    ROKOPortalManager *_portalManager;
}
@end

@implementation RMPPortalManager

- (void)pluginInitialize {
    [super pluginInitialize];
    _portalManager = [[ROKOComponentManager sharedManager] portalManager];
}

- (void)login:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        NSDictionary *params = command.arguments.count == 2 ? command.arguments[1] : nil;
        
        if (params) {
            __weak __typeof__(self) weakSelf = self;
            
            NSString *userName = params[kUserNameKey];
            NSString *password = params[kPasswordKey];
            
            if (userName && password) {
                [_portalManager loginWithUser:userName andPassword:password completionBlock:^(NSError *_Nullable error) {
                    if (error) {
                        [weakSelf handleError:error];
                    } else {
                        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Login Successful"];
                        [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                    }
                }];
            }
        }
    }
}

- (void)setUser:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        NSDictionary *params = command.arguments.count == 2 ? command.arguments[1] : nil;
        
        if (params) {
            __weak __typeof__(self) weakSelf = self;
            
            NSString *userName = params[kUserNameKey];
            NSString *referralCode = params[kReferralCodeKey];
            NSString *shareChannel = params[kShareChannelKey];
            
            if (userName) {
                [_portalManager setUserWithName:userName referralCode:referralCode linkShareChannel:shareChannel completionBlock:^void (NSError *__nullable error) {
                    if (error) {
                        [weakSelf handleError:error];
                    } else {
                        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Set User Successful"];
                        [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                    }
                }];
            }
        }
    }
}

- (void)logout:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        __weak __typeof__(self) weakSelf = self;
        
        [_portalManager logoutWithCompletionBlock:^(NSError *_Nullable error) {
            if (error) {
                [weakSelf handleError:error];
            } else {
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Logout Successful"];
                [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
            }
        }];
    }
}

- (void)signupUser:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        NSDictionary *params = command.arguments.count == 2 ? command.arguments[1] : nil;
        
        if (params) {
            __weak __typeof__(self) weakSelf = self;
            
            NSString *userName = params[kUserNameKey];
            NSString *email = params[kEmailKey];
            NSString *password = params[kPasswordKey];
            NSString *ambassadorCode = params[kAmbassadorCodeKey];
            NSString *linkShareChannel = params[kLinkShareChannel];
            
            if (userName && email && password) {
                [_portalManager signupUser:userName email:email andPassword:password ambassadorCode:ambassadorCode linkShareChannel:linkShareChannel completionBlock:^(NSError *_Nullable error) {
                    if (error) {
                        [weakSelf handleError:error];
                    } else {
                        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Sign up User Successful"];
                        [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                    }
                }];
            }
        }
    }
}

- (void)getPortalInfo:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        __weak __typeof__(self) weakSelf = self;
        
        [_portalManager getPortalInfoWithCompletionBlock:^(ROKOPortalInfo *_Nullable info, NSError *_Nullable error) {
            if (error) {
                [weakSelf handleError:error];
            } else {
                NSDictionary *representation = [EKSerializer serializeObject:info withMapping:[ROKOPortalInfo objectMapping]];
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:representation];
                [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                
            }
        }];
    }
}

- (void)getSessionInfo:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        __weak __typeof__(self) weakSelf = self;
        
        [_portalManager getSessionInfoWithCompletionBlock:^(ROKOSessionInfo *_Nullable info, NSError *_Nullable error) {
            if (error) {
                [weakSelf handleError:error];
            } else {
                NSDictionary *representation = [EKSerializer serializeObject:info withMapping:[ROKOSessionInfo objectMapping]];
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:representation];
                [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                
            }
        }];
    }
}

- (void)getUserInfo:(CDVInvokedUrlCommand *)command {
    BOOL isParseOk = [self parseCommand:command];
    
    if (isParseOk) {
        ROKOUserObject *userInfo = [_portalManager userInfo];

        if (userInfo) {
            NSDictionary *representation = [EKSerializer serializeObject:userInfo withMapping:[ROKOUserObject objectMapping]];
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:representation];
            [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
        } else {
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"No user"];
            [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
        }
    }
}
@end
