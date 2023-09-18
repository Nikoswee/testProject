package com.nikostest.test_project

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel  // <-- Add this import
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "yourapp.com/payment"
    private val EVENT_CHANNEL = "yourapp.com/events"
    private var eventSink: EventChannel.EventSink? = null


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        eventSink = events
                        Log.d("MainActivity", "EventChannel onListen called!")
                        handleIntent(intent)
                    }

                    override fun onCancel(arguments: Any?) {
                        eventSink = null
                        Log.d("MainActivity", "EventChannel onCancel called!")
                    }
                }
        )
    }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("MainActivity", "onCreate is called with intent: $intent")


        supportFragmentManager
                .beginTransaction()
                .runOnCommit {
                    handleIntent(intent)
                }
                .commit()
    }

    // ... rest of your code ...

    private fun handleIntent(intent: Intent) {
        val action = intent.action
        val data = intent.data
        val feature = intent.getStringExtra("feature")
        Log.d("MainActivity", "handleIntent is called with action: $action and data: $data and feature: $feature")

        if (Intent.ACTION_VIEW == action && feature != null) {
            when (feature) {
                "pay_action" -> {
                    Log.d("MainActivity", "Detected pay_action in feature extra")
                    if (flutterEngine == null) {
                        Log.e("MainActivity", "Flutter engine is not initialized")
                    } else {
                        Log.d("MainActivity", "About to send 'pay' event to Flutter")
                        eventSink?.success("pay")

                        Log.d("MainActivity", "'pay' event sent to Flutter!")
                    }
                }
            }
        }
    }
}
