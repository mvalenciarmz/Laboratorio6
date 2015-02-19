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
    
    self.screenName = @"Tabla de Establecimientos";
    
    // Do any additional setup after loading the view.

    // Cargamos los anuncios
    [self cfgiAdBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"Tabla de Establecimientos";
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





// Funciones para que funcionen los anuncios de iAd
// Aparte de èsto, sòlo hay que incluir el frameworkd e iAd.framework y en AppDelegate.m delegar e incluir el tema de banners
- (void)cfgiAdBanner {
    
    // Setup iAdView
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
    //Set coordinates for adView
    CGRect adFrame      = adView.frame;
    
    // Posiciòn del banner (si queremos que esté arriba el valor debe ser 0)
    adFrame.origin.y    = self.view.frame.size.height - 50;
    
    //    NSLog(@"adFrame.origin.y: %f",adFrame.origin.y);
    adView.frame        = adFrame;
    
    [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self.view addSubview:adView];
    adView.delegate         = self;
    adView.hidden           = YES;
    self->bannerIsVisible   = NO;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self->bannerIsVisible)
    {
        adView.hidden = NO;
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        [UIView commitAnimations];
        self->bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self->bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        [UIView commitAnimations];
        adView.hidden = YES;
        self->bannerIsVisible = NO;
    }
}

// Los siguientes eventos son útiles en los siguientes casos: si la app tiene sonido o video, es seguro que queremos detenerlos para que el video-sonido del anuncio no interfiera.   Así que antes de iniciar el anuncio podemos detener el sonido-video, y cuando el anuncio haya terminado lo reanudamos

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    //    NSLog(@"Banner view is beginning an ad action");
    BOOL shouldExecuteAction = YES;
    if (!willLeave && shouldExecuteAction)
    {
        // stop all interactive processes in the app
        // [video pause];
        // [audio pause];
    }
    return shouldExecuteAction;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    // resume everything you've stopped
    // [video resume];
    // [audio resume];
}





@end
