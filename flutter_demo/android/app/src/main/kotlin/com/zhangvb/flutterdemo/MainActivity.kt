package com.zhangvb.flutterdemo

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    var time: Long = 0
    override fun onCreate(savedInstanceState: Bundle?) {

        time = System.currentTimeMillis()
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        var timeForOnCreate = System.currentTimeMillis() - time;
        println("timeForOnCreate = ${timeForOnCreate}")
    }

    override fun onResume() {
        var delta = System.currentTimeMillis() - time
        println("delta = ${delta}")
        super.onResume()
    }
}
