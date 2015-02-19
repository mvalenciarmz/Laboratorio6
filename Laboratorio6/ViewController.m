//
//  ViewController.m
//  Laboratorio6
//
//  Created by marcos on 2/15/15.
//  Copyright (c) 2015 marcos. All rights reserved.
//

#import "ViewController.h"
#import "SBJson.h"


NSDictionary    *jsonResponse;

// Array para los datos
NSArray *tableData;
NSArray *tableHorario;
NSArray *tableImagen;
NSArray *tableLongitud;
NSArray *tableLatitud;


// NSUInteger elements;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Para google analytics comenta el profe que es buena idea ponerlo aquì tambièn
    self.screenName = @"Pantalla Principal";
    
    // Nomàs para estar seguro del bundle id
    //NSLog(@"Current identifier: %@", [[NSBundle mainBundle] bundleIdentifier]);
    
    // Cargamos los anuncios
    [self cfgiAdBanner];
    
//     elements = [tableData count];
    
    // Cargamos desde un webservcie los adtos
    // Como lo hacemos desde la pantalla principal y estaremos regresando a esta, cno ésot trataremos de que se ejecute unav ez al arranque de la app solamente y no cada que regresemos, para ver si se agiliza la visaulización
//    if ( elements == 0 ) {
        [self postService];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"Pantalla Principal";
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
        //NSLog(@"URL postService = %@", url);
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
    tableLatitud = [jsonResponse valueForKey:@"latitud"];
    tableLongitud = [jsonResponse valueForKey:@"longitud"];
    
    //NSLog(@"tableData vale %@", tableData);
    //NSLog(@"tableHorario vale %@", tableHorario);
    //NSLog(@"tabelImagen vale %@", tableImagen);
    
    
//    [self.tblMain reloadData];
    
}



@end
