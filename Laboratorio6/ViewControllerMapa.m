//
//  ViewControllerMapa.m
//  Laboratorio6
//
//  Created by marcos on 2/17/15.
//  Copyright (c) 2015 marcos. All rights reserved.
//

#import "ViewControllerMapa.h"
#import <GoogleMaps/GoogleMaps.h>

// Array para los datos
NSArray *tableData;
NSArray *tableHorario;
NSArray *tableImagen;
NSArray *tableLongitud;
NSArray *tableLatitud;


GMSMapView *mapView_;

@interface ViewControllerMapa ()

@end

@implementation ViewControllerMapa

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSString *lat;
    NSString *lon;
    NSString *nombre;
    NSString *horario;

    lat = [tableLatitud objectAtIndex:0];
    lon = [tableLongitud objectAtIndex:0];

    double latdouble = [lat doubleValue];
    double londouble = [lon doubleValue];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latdouble
                                                            longitude:londouble
                                                                 zoom:16];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    NSUInteger count = [tableData count];
    for (NSUInteger index = 0; index < count ; index++) {
        
        lat = [tableLatitud objectAtIndex:index];
        lon = [tableLongitud objectAtIndex:index];
        nombre = [tableData objectAtIndex:index];
        horario = [tableHorario objectAtIndex:index];
        
        double latdouble = [lat doubleValue];
        double londouble = [lon doubleValue];

        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(latdouble, londouble);
        marker.title = nombre;
        marker.snippet = horario;
        marker.map = mapView_;

    }
    
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

@end
