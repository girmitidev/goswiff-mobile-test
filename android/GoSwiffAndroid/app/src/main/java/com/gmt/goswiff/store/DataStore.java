package com.gmt.goswiff.store;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.database.sqlite.SQLiteOpenHelper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;

/**
 *
 */
public class DataStore extends SQLiteOpenHelper {

    private SQLiteDatabase employeeDataBase;

    public DataStore(Context paramContext) {
        super(paramContext, "countries.db", null, 1);
        createCountryDataBaseFromFile(paramContext);
    }

    private void createCountryDataBaseFromFile(Context paramContext) {
        if (!checkDataBase(paramContext)) {
            getReadableDatabase();
            copyDataBase(paramContext);
        }
    }

    private boolean checkDataBase(Context paramContext) {
        try {
            SQLiteDatabase db = SQLiteDatabase.openDatabase(paramContext.getDatabasePath("GoSwiff.db").getPath(), null, 1);
            if (db != null) {
                db.close();
            }
            return db != null;
        } catch (SQLiteException e) {
            e.printStackTrace();
        }
        return false;
    }

    private void copyDataBase(Context paramContext) {
        try {
            InputStream inputStream = paramContext.getAssets().open("GoSwiff.db");
            File file = paramContext.getDatabasePath("GoSwiff.db");
            if (!file.exists()) {
                if (!file.getParentFile().exists()) {
                    file.getParentFile().mkdir();
                }
                OutputStream outputStream = new FileOutputStream(file.getAbsolutePath());
                byte[] buffer = new byte[1024];
                int length;
                while ((length = inputStream.read(buffer))>0) {
                    outputStream.write(buffer,0,length);
                }

                outputStream.flush();
                outputStream.close();
                inputStream.close();
            }

            return;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void close() {
        try {
            if (this.employeeDataBase != null) {
                this.employeeDataBase.close();
            }
            super.close();
            return;
        } finally {
        }
    }

    @Override
    public void onCreate(SQLiteDatabase db) {

    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

    }

    public SQLiteDatabase openEmployeeDataBase(Context paramContext) throws SQLException {
        this.employeeDataBase = SQLiteDatabase.openDatabase(paramContext.getDatabasePath("GoSwiff.db").getPath(), null, 0);
        return this.employeeDataBase;
    }
}
