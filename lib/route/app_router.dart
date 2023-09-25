import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

//dart run build_runner build --delete-conflicting-outputs

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: StallsRoute.page, initial:true),
    AutoRoute(page: CartRoute.page),
    AutoRoute(page: FoodItemsRoute.page),
    AutoRoute(page: PaymentRoute.page),

  ];
}
