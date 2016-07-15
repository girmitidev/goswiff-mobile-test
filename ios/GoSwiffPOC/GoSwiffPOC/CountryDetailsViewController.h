//
//  CountryDetailsViewController.h
//  GoSwiffPOC
//
//  Created by Girmiti Dev on 15/07/16.
//  Copyright (c) 2016 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <MapKit/MapKit.h>
#import "Country.h"

@interface CountryDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *_imageView;
@property (weak, nonatomic) IBOutlet UILabel *_countryName;
@property (weak, nonatomic) IBOutlet MKMapView *_mapView;
@property (strong,nonatomic) Country  *_selectedCountry;

@end
