package com.gmt.goswiff;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.gmt.goswiff.store.DataStoreHelper;
import com.gmt.goswiff.store.model.Country;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Girmiti Dev
 * @Copyright (c) 2016 Girmiti Software. All rights reserved
 */
public class HomeActivity extends AppCompatActivity {

    private DataStoreHelper helper;
    private ListView countryListView;
    private List<Country> countries;
    private List<Country> countriesFiltered;
    private CountryAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);

        helper = new DataStoreHelper(this);

        try {
            countries = helper.fetchCountryNamesAndFlag();
            countriesFiltered = countries;

            adapter = new CountryAdapter(countries);

            countryListView = (ListView) findViewById(R.id.countries);
            countryListView.setAdapter(adapter);
            countryListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                @Override
                public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                    Country country = countriesFiltered.get(position);

                    Bundle b = new Bundle();
                    b.putString("lon", country.getLongitude());
                    b.putString("lat", country.getLatitude());
                    b.putString("code", country.getCode3L());
                    b.putString("image", country.getFlag_128());
                    b.putString("name", country.getName());
                    b.putString("name_off", country.getName_official());

                    Intent intent = new Intent(HomeActivity.this, DetailsActivity.class);
                    intent.putExtra("country", b);

                    startActivity(intent);
                }
            });

            ((EditText)findViewById(R.id.filter)).addTextChangedListener(new TextWatcher() {

                @Override
                public void onTextChanged(CharSequence s, int start, int before, int count) {
                    adapter.getFilter().filter(s.toString());
                }

                @Override
                public void beforeTextChanged(CharSequence s, int start, int count, int after) { }

                @Override
                public void afterTextChanged(Editable s) { }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private class CountryAdapter extends BaseAdapter implements Filterable {

        private List<Country> dataSet;
        private ItemFilter filter;

        CountryAdapter(List<Country> countries) {
            this.dataSet = countries;
            filter = new ItemFilter();
        }

        @Override
        public int getCount() {
            return dataSet.size();
        }

        @Override
        public Object getItem(int position) {
            return dataSet.get(position);
        }

        @Override
        public long getItemId(int position) {
            return 0;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {

            if(convertView == null) {
                convertView = LayoutInflater.from(HomeActivity.this).inflate(R.layout.row, null);

                Holder h = new Holder();
                h.flag = (ImageView) convertView.findViewById(R.id.flag);
                h.name = (TextView) convertView.findViewById(R.id.name);

                convertView.setTag(h);
            }

            Holder h = (Holder) convertView.getTag();
            Country country = (Country) getItem(position);

            Picasso.with(HomeActivity.this)
                    .load(country.getFlag_128())
                    .placeholder(R.drawable.placeholder_big)
                    .fit()
                    .tag(HomeActivity.this)
                    .into(h.flag);

            h.name.setText(country.getName());

            return convertView;
        }

        @Override
        public Filter getFilter() {
            return filter;
        }

        private class ItemFilter extends Filter {

            private List<Country> filtered = new ArrayList<>();

            @Override
            protected FilterResults performFiltering(CharSequence constraint) {
                FilterResults results = new FilterResults();
                String filterString = constraint.toString().toLowerCase();

                String filterableString ;
                filtered.clear();

                for (Country country : countries) {
                    filterableString = country.getName();
                    if (filterableString.toLowerCase().startsWith(filterString)) {
                        filtered.add(country);
                    }
                }

                results.values = filtered;
                results.count = filtered.size();
                countriesFiltered = filtered;

                return results;
            }

            @Override
            protected void publishResults(CharSequence constraint, FilterResults results) {
                dataSet = (List<Country>) results.values;
                notifyDataSetChanged();
            }
        }
    }

    private class Holder {
        ImageView flag;
        TextView name;
    }
}
