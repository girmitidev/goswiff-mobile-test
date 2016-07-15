package com.gmt.goswiff;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.gmt.goswiff.store.model.Country;
import com.squareup.picasso.Picasso;

/**
 * @author Girmiti Dev
 * @Copyright (c) 2016 Girmiti Software. All rights reserved
 */
public class DetailsFragment extends Fragment {

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_details, container, false);
        return view;
    }

    @Override
    public void onResume() {
        super.onResume();
        Country country = ((DetailsActivity) getActivity()).getCountry();

        ImageView image = (ImageView) getView().findViewById(R.id.flag);
        Picasso.with(getActivity())
                .load(country.getFlag_128())
                .placeholder(R.drawable.placeholder_big)
                .tag(getActivity())
                .into(image);

        ((TextView) getView().findViewById(R.id.name)).setText(country.getName_official());
    }
}
