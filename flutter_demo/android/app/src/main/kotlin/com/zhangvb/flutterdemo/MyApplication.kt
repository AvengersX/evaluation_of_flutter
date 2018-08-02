package com.zhangvb.flutterdemo

import android.util.Log
import io.flutter.app.FlutterApplication

class MyApplication: FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        Log.d("debug_ang", "test")
    }
}