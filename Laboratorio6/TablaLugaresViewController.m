//
//  TablaLugaresViewController.m
//  Laboratorio6
//
//  Created by marcos on 2/15/15.
//  Copyright (c) 2015 marcos. All rights reserved.
//

#import "TablaLugaresViewController.h"

#import "SBJson.h"


NSDictionary    *jsonResponse;

// Array para los datos
NSArray *tableData;
NSArray *tableHorario;
NSArray *tableImagen;

@interface TablaLugaresViewController ()

@end

@implementation TablaLugaresViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self postService];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [tableHorario objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
    
    // Cargamos la imagen a partir de una cadena de texto, que contiene la URL donde esta
    NSString * result = [tableImagen objectAtIndex:indexPath.row];
    //NSLog(@"%@",result);
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:result]];
    cell.imageView.image = [UIImage imageWithData:imageData];

    
    return cell;
}



	/*******************************************************************************
 Web Service
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postService
{
    //NSLog(@"postService");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadService) object:nil];
    [queue addOperation:operation];
 
}
//-------------------------------------------------------------------------------
- (void) loadService
{
    @try
    {
        NSURL *url = [NSURL URLWithString:@"http://localhost:8888/conecta.php"];
        NSLog(@"URL postService = %@", url);
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [NSURLRequest requestWithURL:url];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        //-------------------------------------------------------------------------------
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            jsonResponse = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
        }
        else
        {
            if (error)
            {
                NSLog(@"Error");
                
            }
            else
            {
                NSLog(@"Conect Fail");
            }
        }
        //-------------------------------------------------------------------------------
    }
    @catch (NSException * e)
    {
        NSLog(@"Exception");
    }
    //-------------------------------------------------------------------------------
    //NSLog(@"jsonResponse %@", jsonResponse);
    
    tableData    = [jsonResponse valueForKey:@"nombre"];
    tableHorario = [jsonResponse valueForKey:@"horario"];
    tableImagen = [jsonResponse valueForKey:@"imagen"];
    
    //NSLog(@"tableData vale %@", tableData);
    //NSLog(@"tableHorario vale %@", tableHorario);
    //NSLog(@"tabelImagen vale %@", tableImagen);
    
    
    [self.tblMain reloadData];
    
}


@end
