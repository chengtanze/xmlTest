//
//  ViewController.m
//  xmlTest
//
//  Created by wangsl-iMac on 15/3/11.
//  Copyright (c) 2015年 chengtz-iMac. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSError* Xmlerror;
    NSError* returnError;
    NSString * xmlstring = @"<\?xml version=\"1.0\" encoding=\"UTF-8\"\?><root><resultCode>0</resultCode><msg></msg><data><userBaseInfo><userId>924886</userId><cStatus>0</cStatus><nickName>设备924886</nickName><sex>1</sex><city></city><car>08款 2.5S 特别纪念版</car><signature> </signature><class>0</class><userPhoto>user_photo.gif</userPhoto><mobileNo> </mobileNo><email> </email><terminalId>17765115</terminalId><qqUid></qqUid><sinaUid></sinaUid></userBaseInfo><userDetailInfo><displacement>0.0</displacement><carNumber>粤BRN358</carNumber><carColor> </carColor><age>0</age><openMobileNo>2</openMobileNo><openCarInfo>1</openCarInfo><teamVerifyType>1</teamVerifyType><teamId>0</teamId><brand>丰田</brand></userDetailInfo><blog></blog></data></root>";
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:[xmlstring dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&Xmlerror];
    if (document != nil)
    {
        //取出xml的根节点
        GDataXMLElement* rootElement = [document rootElement];
        //NSLog(@"--------root element:--------\n%@",rootElement);
        //取出根节点的所有孩子节点
        NSArray* children = [rootElement children];
        //NSLog(@"--------root's children:--------\n%@", children);
        //取出某一个具体节点(body节点)
        GDataXMLElement* bodyElement = [[rootElement elementsForName:@"data"]objectAtIndex:0];
        NSLog(@"--------body:--------\n%@", bodyElement);
        
        NSArray* childrenBody = [bodyElement children];
       GDataXMLElement* bodyElement1 = childrenBody[2];
        
        
        for (GDataXMLElement *item in children)
        {
            NSArray *names = [item elementsForName:@"userBaseInfo"];
            
            for(GDataXMLElement *name in names)
            {
                NSLog(@">>> my name is : %d", name.childCount);
                
                for (NSUInteger index = 0; index < name.childCount; index++) {
                    GDataXMLElement *data =  name.children[index];
                    NSLog(@">>> Key:%@ name%@", data.stringValue, data.name);
                }
            }
            
            NSArray *levels = [item elementsForName:@"userDetailInfo"];
            for(GDataXMLElement *level in levels)
            {
                NSLog(@">>> my level is : %d",level.childCount);
            }
            
            NSArray *blog = [item elementsForName:@"blog"];
            for(GDataXMLElement *level1 in blog)
            {
                NSLog(@">>> my level is : %d", level1.childCount);
            }
        }
        //某个具体节点的文本内容
        //NSString* content = [bodyElement stringValue];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
