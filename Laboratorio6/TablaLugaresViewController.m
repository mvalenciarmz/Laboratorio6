//
//  TablaLugaresViewController.m
//  Laboratorio6
//
//  Created by marcos on 2/15/15.
//  Copyright (c) 2015 marcos. All rights reserved.
//

#import "TablaLugaresViewController.h"

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
    
    // Cargamos la imagen a partir de una cadena de texto, que contiene la URL donde esta
    NSString * result = [tableImagen objectAtIndex:indexPath.row];
    //NSLog(@"%@",result);
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:result]];
    cell.imageView.image = [UIImage imageWithData:imageData];

    
    return cell;
}





@end
