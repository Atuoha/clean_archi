import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final InternetConnectionChecker internetConnectionChecker;

  const NetworkInfoImpl({
    required this.connectivity,
    required this.internetConnectionChecker,
  });

  @override
  Future<bool> get isConnected async {
    bool isDeviceConnected = false;
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      isDeviceConnected = await internetConnectionChecker.hasConnection;
    }
    return isDeviceConnected;
  }
}
