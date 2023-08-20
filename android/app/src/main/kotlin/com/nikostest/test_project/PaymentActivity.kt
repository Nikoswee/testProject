package com.nikostest.test_project

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.commit
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PaymentActivity : AppCompatActivity() {
    private val CHANNEL = "com.nikostest.test_project/payment"
    private lateinit var flutterEngine: FlutterEngine

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            FlutterEngine.DartEntrypoint("payment_screen") // Replace with the appropriate Dart entrypoint
        )

        val flutterFragment = FlutterFragment.withCachedEngine(flutterEngine)
            .build()

        supportFragmentManager.commit {
            add(android.R.id.content, flutterFragment)
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (call.method == "closeFlutterScreen") {
                    finish() // Close the PaymentActivity when requested from Flutter
                } else {
                    result.notImplemented()
                }
            }
    }
}
