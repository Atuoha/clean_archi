import 'package:clean_archi/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

Future<void> main() async {
  late MockConnectivity mockConnectivity;
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockConnectivity = MockConnectivity();
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(
      connectivity: mockConnectivity,
      internetConnectionChecker: mockInternetConnectionChecker,
    );
  });

  group('isConnected', () {
    setUp(() {
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((invocation) async => ConnectivityResult.wifi);
    });

    test('check if device is connected', () async {
      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      final result = await networkInfoImpl.isConnected;
      verify(() => mockConnectivity.checkConnectivity());
      verify(() => mockInternetConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
