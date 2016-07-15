//
//  CountryDetailsViewController.m
//  GoSwiffPOC
//
//  Created by Girmiti Dev on 15/07/16.
//  Copyright (c) 2016 Appcoda. All rights reserved.
//

#import "CountryDetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CountryDetailsViewController ()

@end

@implementation CountryDetailsViewController

@synthesize _selectedCountry;

- (void)viewDidLoad {
    [super viewDidLoad];

    self._countryName.text = self._selectedCountry._nameOfficial;
    
    [self._imageView sd_setImageWithURL:[NSURL URLWithString:self._selectedCountry._flag128] placeholderImage:[UIImage imageNamed:@"placeholder@4x.jpg"]];
    
    CLLocationCoordinate2D track;
    track.latitude = [ self._selectedCountry._latitude longLongValue];
    track.longitude = [ self._selectedCountry._logitude longLongValue];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 100;
    span.longitudeDelta = 100;
    region.span = span;
    region.center = track;
    
    // Create Annotation point
    MKPointAnnotation *pin = [[MKPointAnnotation alloc]init];
    pin.coordinate = track;
    pin.title =  self._selectedCountry._name;
    pin.subtitle =  self._selectedCountry._nameOfficial;
    
    [self._mapView addAnnotation:pin];
    [self._mapView setRegion:region animated:TRUE];
    [self._mapView regionThatFits:region];
    
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
