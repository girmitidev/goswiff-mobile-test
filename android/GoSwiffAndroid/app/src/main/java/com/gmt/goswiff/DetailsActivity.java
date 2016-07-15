package com.gmt.goswiff;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.gmt.goswiff.store.model.Country;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

/**
 * @author Girmiti Dev
 * @Copyright (c) 2016 Girmiti Software. All rights reserved
 */
public class DetailsActivity extends AppCompatActivity implements OnMapReadyCallback {

    private GoogleMap mMap;
    private Country country;

    private String lat;
    private String lon;
    private String name;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);

        setTitle("Details");

        Bundle b = getIntent().getBundleExtra("country");
        if(b != null) {
            lon = b.getString("lon");
            lat = b.getString("lat");
            name = b.getString("name");

            String image = b.getString("image");
            String name_off = b.getString("name_off");

            country = new Country();
            country.setName(name);
            country.setFlag_128(image);
            country.setName_official(name_off);

            SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                    .findFragmentById(R.id.map);
            mapFragment.getMapAsync(this);
        }
    }

    public Country getCountry() {
        return country;
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;

        LatLng location = new LatLng(Double.parseDouble(lat), Double.parseDouble(lon));
        mMap.addMarker(new MarkerOptions().position(location).title(name));
        mMap.moveCamera(CameraUpdateFactory.newLatLng(location));
    }
}
