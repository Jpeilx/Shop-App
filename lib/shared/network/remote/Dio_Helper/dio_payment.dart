import 'package:dio/dio.dart';
import 'package:shop/shared/network/remote/end_points.dart';

class DioPayment {
  static String _publicKey = "pk_sbox_5twfjivla36maknfagyevgz6ouv";
  static String _secretkey = "sk_sbox_ycewssp3mwdimcdaybbltvsrge6";
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.sandbox.checkout.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getToken({
    required String number,
    required int expiryMonth,
    required int expiryYear,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_publicKey',
    };
    return await dio.post(PAYMENTTOKEN, data: {
      "type": "card",
      "number": number,
      "expiry_month": expiryMonth,
      "expiry_year": expiryYear
    });
  }

  static Future<Response> payment({
    required String paymenttoken,
    required int amount,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_secretkey ',
    };
    return await dio.post(PAYMENT, data: {
      
        "source": {
          "type": "token",
          "token": paymenttoken,
        },
        "amount": amount,
        "currency": "EGP",
      
    });
  }
}
