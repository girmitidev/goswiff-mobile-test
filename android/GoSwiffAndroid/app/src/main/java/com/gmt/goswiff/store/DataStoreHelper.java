package com.gmt.goswiff.store;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.gmt.goswiff.store.model.Country;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Girmiti Dev
 * @Copyright (c) 2016 Girmiti Software. All rights reserved
 */
public class DataStoreHelper {

    private DataStore dbHelper;
    private SQLiteDatabase countryDataBase;
    private Context context;

    public DataStoreHelper(Context paramContext) {
        this.context = paramContext;
        this.dbHelper = new DataStore(paramContext);
    }

    private void close() {
        this.dbHelper.close();
    }

    private void open() throws Exception {
        this.countryDataBase = this.dbHelper.openEmployeeDataBase(this.context);
    }

    public List<Country> fetchCountryNamesAndFlag() throws Exception {
        open();
        Cursor cursor = this.countryDataBase.rawQuery("select name, name_official, latitude, longitude, code3L, flag_128 from countries;", null);

        List<Country> countries = new ArrayList<>();

        while(cursor.moveToNext()) {
            Country country = new Country();
            country.setName_official(cursor.getString(cursor.getColumnIndex("name_official")));
            country.setLatitude(cursor.getString(cursor.getColumnIndex("latitude")));
            country.setLongitude(cursor.getString(cursor.getColumnIndex("longitude")));
            country.setCode3L(cursor.getString(cursor.getColumnIndex("code3L")));
            country.setFlag_128(cursor.getString(cursor.getColumnIndex("flag_128")));
            country.setName(cursor.getString(cursor.getColumnIndex("name")));

            countries.add(country);
        }

        cursor.close();
        close();

        return countries;
    }
}
