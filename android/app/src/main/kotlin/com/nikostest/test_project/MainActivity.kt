package com.nikostest.test_project

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.nikostest.test_project/payment"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (call.method == "navigateToPayment") {
                    // Call the method to navigate to PaymentActivity
                    navigateToPayment()
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun handleIntent(intent: Intent) {
        if (Intent.ACTION_VIEW == intent.action) {
            val data: Uri? = intent.data
            if (data != null) {
                val feature: String? = data.getQueryParameter("feature")
                if (!feature.isNullOrBlank()) {
                    // Handle opening the feature based on the value of 'feature'
                    // For example, you can navigate to a specific screen in your Flutter app
                }
            }
        }
    }

    private fun navigateToPayment() {
        val paymentIntent = Intent(this, PaymentActivity::class.java) // Replace PaymentActivity with your actual PaymentScreen activity
        startActivity(paymentIntent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // You can configure additional plugins and settings for the FlutterEngine here.
    }
}
