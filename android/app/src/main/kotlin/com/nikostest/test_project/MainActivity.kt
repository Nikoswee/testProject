package com.nikostest.test_project

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "yourapp.com/payment"

//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//            // handle incoming calls from Flutter
//        }
//    }

    // on first launch of the application
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



    // when new intent are sent after first launch of the application
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.d("MainActivity", "Received intent: $intent")
        handleIntent(intent)
    }

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
                        Log.d("MainActivity", "About to invoke Flutter method on $CHANNEL")
                        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
                            .invokeMethod("receivedFeature", "pay", object: MethodChannel.Result {
                                override fun success(result: Any?) {
                                    Log.d("MainActivity", "Method invoked successfully")
                                }

                                override fun error(code: String, message: String?, details: Any?) {
                                    Log.e("MainActivity", "Error invoking method: $message")
                                }

                                override fun notImplemented() {
                                    Log.e("MainActivity", "Method not implemented")
                                }
                            })

                        Log.d("MainActivity", "Flutter method invoked")
                    }

                }

            }
        }
    }

    private fun invokeFlutterMethod(methodName: String) {
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
            .invokeMethod(methodName, null)
    }
}
