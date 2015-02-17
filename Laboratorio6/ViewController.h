//
//  ViewController.h
//  Laboratorio6
//
//  Created by marcos on 2/15/15.
//  Copyright (c) 2015 marcos. All rights reserved.
//

#import <UIKit/UIKit.h>

// Para los anuncios de iAd
#import <iAd/iAd.h>

// Delegamos para que funcionen los banners de iAd
@interface ViewController : UIViewController<UIApplicationDelegate, ADBannerViewDelegate> {
    
    ADBannerView *adView;
    BOOL bannerIsVisible;

}

@end
