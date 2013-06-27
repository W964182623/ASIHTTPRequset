//
//  ViewController.m
//  ASIHTTPRequset
//
//  Created by 赵云 on 13-6-11.
//  Copyright (c) 2013年 赵云. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(90, 100, 60, 60*0.71);
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tipButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
    request=[[ASIHTTPRequest requestWithURL:url] retain];

    [request setDelegate:self];
    [request startAsynchronous];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tipButton:(UIButton*)button{
//    NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
//    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
//    [request startSynchronous];
//    NSError *error=[request error];
//    
//    if(!error){
//        NSString *response=[request responseString];
//        NSLog(@"response=%@",response);
//    }else{
//        NSLog(@"error heppened");
//    }

    NSLog(@"123456");
    [self grabURLInTheBackground:request];
}

-(void)requestFinished:(ASIHTTPRequest*)request{
//    NSString *responseString=[request responseString];
//    NSData *responseData=[request responseData];
//    NSLog(@"responseString=%@,respondeData=%@",responseString,responseData);
    NSLog(@"hdddd");
}

-(void)requestFailed:(ASIHTTPRequest*)requests{
    NSError *error=[request error];
    NSLog(@"error=%@",[error localizedDescription]);
}

-(void)grabURLInTheBackground:(ASIHTTPRequest*)resquest{
    ASINetworkQueue *queue=[[ASINetworkQueue alloc] init];
    queue.delegate=self;
    queue.requestDidFinishSelector=@selector(requestDone:);
    queue.requestDidFailSelector=@selector(requestWentWrong:);
    
    NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
    ASIHTTPRequest *request_Background=[ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [queue addOperation:request_Background];
    [queue go];
}

-(void)requestDone:(ASIHTTPRequest*)request{
    NSLog(@"fuck 你妹");
}

-(void)requestWentWrong:(ASIHTTPRequest*)requests{
    NSError *error=[request error];
    NSLog(@"error_back=%@",[error localizedDescription]);
    
}
@end
