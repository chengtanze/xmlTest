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
    NSString * xmlstring = @"<\?xml version=\"1.0\" encoding=\"UTF-8\"\?><root><resultCode>0</resultCode><msg>9001</msg><data><userBaseInfo><userId>924886</userId><cStatus>0</cStatus><nickName>设备924886</nickName><sex>1</sex><city></city><car>08款 2.5S 特别纪念版</car><signature> </signature><class>0</class><userPhoto>user_photo.gif</userPhoto><mobileNo> </mobileNo><email> </email><terminalId>17765115</terminalId><qqUid></qqUid><sinaUid></sinaUid></userBaseInfo><userDetailInfo><displacement>0.0</displacement><carNumber>粤BRN358</carNumber><carColor> </carColor><age>0</age><openMobileNo>2</openMobileNo><openCarInfo>1</openCarInfo><teamVerifyType>1</teamVerifyType><teamId>0</teamId><brand>丰田</brand></userDetailInfo><blog></blog></data></root>";
    
    NSString * xmlstring2 = @"<\?xml version=\"1.0\" encoding=\"UTF-8\"\?><root><data><recv><userID>10001</userID><sex>1</sex></recv><recv><userID>10002</userID><sex>0</sex></recv></data></root>";
    
    NSArray * arrayKey = [[NSArray alloc]initWithObjects:@"userBaseInfo", @"userDetailInfo",@"blog",nil];
    
    NSArray * arrayKey2 = [[NSArray alloc]initWithObjects:@"resultCode", nil];
    
    NSArray * arrayKey3 = [[NSArray alloc]initWithObjects:@"msg", nil];
    
    
    NSArray * array = [self analysisDataFromXML:xmlstring Key:arrayKey3];
    if (array.count > 0) {
        NSString * errorMsg = [array[0] valueForKey:@"msg"];
    }
    

}



-(NSArray *)analysisDataFromXML:(NSString *)xmlString Key:(NSArray *)key{
    NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:10];
    NSError* Xmlerror;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:[xmlString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&Xmlerror];
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
        //NSLog(@"--------body:--------\n%@", bodyElement);
        
        //NSArray* childrenBody = [bodyElement children];
        //GDataXMLElement* bodyElement1 = childrenBody[2];
        
        
        for (GDataXMLElement *item in children)
        {
            for (NSString * string in key) {
                //NSArray *names = [item elementsForName:@"resultCode"];
           
                //循环该item下的所有子节点
                NSArray *names = [item elementsForName:string];
                for(GDataXMLElement *name in names)
                {
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithCapacity:10];
                    NSLog(@">>> my name is : %lu", (unsigned long)name.childCount);
                    
                    for (NSUInteger index = 0; index < name.childCount; index++) {
                        GDataXMLElement *data =  name.children[index];
                        NSLog(@">>> Key:%@ name:%@", data.stringValue, data.name);
                        
                        [dic setObject:data.stringValue forKey:data.name];
                    }
                    
                    [array addObject:dic];
                }
                //如果这个item没有子节点，直接获取该item的值
                if (names == nil && [item.name isEqualToString:string]) {
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithCapacity:10];
                    [dic setObject:item.stringValue forKey:item.name];
                    [array addObject:dic];
                }
            }
        }
    }
    
    return array;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
