// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:test_project/model/cart.dart' as _i6;
import 'package:test_project/screens/cart/cart_screen.dart' as _i1;
import 'package:test_project/screens/payment/payment_screen.dart' as _i3;
import 'package:test_project/screens/stall/foodItem_screen.dart' as _i2;
import 'package:test_project/screens/stall/stall_screen.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    CartRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CartScreen(),
      );
    },
    FoodItemsRoute.name: (routeData) {
      final args = routeData.argsAs<FoodItemsRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.FoodItemsScreen(stallName: args.stallName),
      );
    },
    PaymentRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PaymentScreen(
          isAuthenticated: args.isAuthenticated,
          cartItems: args.cartItems,
        ),
      );
    },
    StallsRoute.name: (routeData) {
      final args = routeData.argsAs<StallsRouteArgs>(
          orElse: () => const StallsRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.StallsScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CartScreen]
class CartRoute extends _i5.PageRouteInfo<void> {
  const CartRoute({List<_i5.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.FoodItemsScreen]
class FoodItemsRoute extends _i5.PageRouteInfo<FoodItemsRouteArgs> {
  FoodItemsRoute({
    required String stallName,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          FoodItemsRoute.name,
          args: FoodItemsRouteArgs(stallName: stallName),
          initialChildren: children,
        );

  static const String name = 'FoodItemsRoute';

  static const _i5.PageInfo<FoodItemsRouteArgs> page =
      _i5.PageInfo<FoodItemsRouteArgs>(name);
}

class FoodItemsRouteArgs {
  const FoodItemsRouteArgs({required this.stallName});

  final String stallName;

  @override
  String toString() {
    return 'FoodItemsRouteArgs{stallName: $stallName}';
  }
}

/// generated route for
/// [_i3.PaymentScreen]
class PaymentRoute extends _i5.PageRouteInfo<PaymentRouteArgs> {
  PaymentRoute({
    required bool isAuthenticated,
    required List<_i6.CartItem> cartItems,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          PaymentRoute.name,
          args: PaymentRouteArgs(
            isAuthenticated: isAuthenticated,
            cartItems: cartItems,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentRoute';

  static const _i5.PageInfo<PaymentRouteArgs> page =
      _i5.PageInfo<PaymentRouteArgs>(name);
}

class PaymentRouteArgs {
  const PaymentRouteArgs({
    required this.isAuthenticated,
    required this.cartItems,
  });

  final bool isAuthenticated;

  final List<_i6.CartItem> cartItems;

  @override
  String toString() {
    return 'PaymentRouteArgs{isAuthenticated: $isAuthenticated, cartItems: $cartItems}';
  }
}

/// generated route for
/// [_i4.StallsScreen]
class StallsRoute extends _i5.PageRouteInfo<StallsRouteArgs> {
  StallsRoute({
    bool triggerConfirm = false,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          StallsRoute.name,
          args: StallsRouteArgs(triggerConfirm: triggerConfirm),
          initialChildren: children,
        );

  static const String name = 'StallsRoute';

  static const _i5.PageInfo<StallsRouteArgs> page =
      _i5.PageInfo<StallsRouteArgs>(name);
}

class StallsRouteArgs {
  const StallsRouteArgs({this.triggerConfirm = false});

  final bool triggerConfirm;

  @override
  String toString() {
    return 'StallsRouteArgs{triggerConfirm: $triggerConfirm}';
  }
}
