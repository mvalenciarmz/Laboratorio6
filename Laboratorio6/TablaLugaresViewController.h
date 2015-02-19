//
//  TablaLugaresViewController.h
//  Laboratorio6
//
//  Created by marcos on 2/15/15.
//  Copyright (c) 2015 marcos. All rights reserved.
//

#import <UIKit/UIKit.h>

// Para los anuncios de iAd
#import <iAd/iAd.h>
// Para el gogle analytics
#import "GAITrackedViewController.h"



@interface TablaLugaresViewController : GAITrackedViewController <UIApplicationDelegate, UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate> {
 
    ADBannerView *adView;
    BOOL bannerIsVisible;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tblMain;


@end


