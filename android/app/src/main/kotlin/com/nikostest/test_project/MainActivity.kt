package com.nikostest.test_project

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.Log

class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "com.nikostest.test_project"
    private var flutterChannel: MethodChannel? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        // Handle intent on app launch
        handleShortcutIntent(intent)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Handle intent on app launch
        handleShortcutIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        // Handle new intent
        handleShortcutIntent(intent)
    }

    private fun handleShortcutIntent(intent: Intent) {
        if (Intent.ACTION_VIEW == intent.action) {
            Log.d("methodChannel", "handleShortcutIntent is triggered nikos!")
            val extras = intent.extras
            Log.d("methodChannel", "Intent extras: $extras")
            if (extras != null) {
                val feature = extras.getString("feature")
                Log.d("methodChannel", "Feature: $feature")
                if (!feature.isNullOrBlank() && flutterChannel != null) {
                    // val flutterChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
                    Log.d("methodChannel", "feature is not null and flutter channel is not null")
                    flutterChannel!!.invokeMethod("receivedFeature", feature)
                }
            }
        }
    }

}


    // private val CHANNEL = "com.nikostest.test_project";

    // override fun onCreate(savedInstanceState: Bundle?) {
    //     super.onCreate(savedInstanceState)

    //     MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
    //         .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
    //             if (call.method == "handleIntent") {
   
    //             } else {
    //                 result.notImplemented()
    //             }
    //         }
    // }



        // private fun handleIntent(intent: Intent) {
    //     if (Intent.ACTION_VIEW == intent.action) {
    //         val data: Uri? = intent.data
    //         if (data != null) {
    //             val feature: String? = data.getQueryParameter("feature")
    //             if (!feature.isNullOrBlank()) {
    //                 // Handle opening the feature based on the value of 'feature'
    //                 // For example, you can navigate to a specific screen in your Flutter app
    //                 println("Recieved feature parameter from google assistant: $feature")

    //                 // Send the 'feature' parameter to Flutter using MethodChannel
    //                 val flutterChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL);
    //                 flutterChannel.invokeMethod("receivedFeature", feature)
    //             }
    //         }
    //     }
    // }


    // override fun onNewIntent(intent: Intent) {
    //     super.onNewIntent(intent)
    //     handleIntent(intent)
    // }

    // private fun navigateToPayment() {
    //     val paymentIntent = Intent(this, PaymentActivity::class.java) // Replace PaymentActivity with your actual PaymentScreen activity
    //     startActivity(paymentIntent)
    // }

