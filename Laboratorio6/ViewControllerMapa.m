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

@interface ViewControllerMapa () <GMSMapViewDelegate>

@end

@implementation ViewControllerMapa

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.screenName = @"Mapa de Localización";

    
    NSString *lat;
    NSString *lon;
    NSString *nombre;
    NSString *horario;

    lat = [tableLatitud objectAtIndex:2];
    lon = [tableLongitud objectAtIndex:2];

    double latdouble = [lat doubleValue];
    double londouble = [lon doubleValue];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latdouble
                                                            longitude:londouble
                                                                 zoom:15];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;
    self.view = mapView_;

    // Para obtener ubciaciòn actual
    CLLocation * myLocation = mapView_.myLocation;
    NSLog( @"%f %f", myLocation.coordinate.latitude, myLocation.coordinate.longitude);
    
 
    
    
    
    
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


- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {

    // Como lo estamos corriendo desde el emulador, le proporcionamos fija una posicòn del mapa.
    double latdouble = 17.050742;
    double londouble = -96.726895;
    
    CLLocationCoordinate2D start = { latdouble, londouble };
    CLLocationCoordinate2D destination = { marker.position.latitude, marker.position.longitude };
    
    NSString *googleMapsURLString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%1.6f,%1.6f&daddr=%1.6f,%1.6f", 
                                     start.latitude, start.longitude, destination.latitude, destination.longitude];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapsURLString]];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"Mapa de Localización";
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
