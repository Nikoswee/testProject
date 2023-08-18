import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

}
//override fun onCreate(savedInstanceState: Bundle?) {
//    super.onCreate(savedInstanceState)
//    handleIntent(intent)
//}
//
//override fun onNewIntent(intent: Intent) {
//    super.onNewIntent(intent)
//    handleIntent(intent)
//}
//
//private fun handleIntent(intent: Intent) {
//    if (Intent.ACTION_VIEW == intent.action) {
//        val data: Uri? = intent.data
//        if (data != null) {
//            val feature: String? = data.getQueryParameter("feature")
//            if (!feature.isNullOrBlank()) {
//                // Handle opening the feature based on the value of 'feature'
//                if ("demo" == feature || "home" == feature || "demo page" == feature) {
//                    // Open your demo page or perform the desired action
//                    // For example, you can navigate to a specific screen in your Flutter app
//                }
//            }
//        }
//    }
//}