import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:paymentapp/core/utils/api_service.dart';
import 'package:paymentapp/core/utils/apikeys.dart';
import 'package:paymentapp/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:paymentapp/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    var response = await apiService.post(
      url: 'https://api.stripe.com/v1/payment_intents',
      body: paymentIntentInputModel.toJson(),
      contenttype: 'application/x-www-form-urlencoded',
      token: Apikeys.secretKey,
    );

    // debug: print the raw JSON so we can see what shape Stripe sent back
    // remove or guard this in production
    try {
      print(
        'Here you gonna see the PaymentIntentInputModel:${paymentIntentInputModel.toJson()}',
      );
      print(
        '................Stripe createPaymentIntent response: ${response.data}',
      );
      return PaymentIntentModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        print("Stripe ERROR RESPONSE: ${e.response?.data}");
      }
      throw FormatException(
        '.....................Failed to parse Stripe payment intent: $e\njson=${response.data}',
      );
    }
  }


 

  Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
    // required String customerId,
    // required String ephemeralKeySecret,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Medo Stripe',
          // customerId: customerId,
          // customerEphemeralKeySecret: ephemeralKeySecret,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentintentmodel = await createPaymentIntent(paymentIntentInputModel);

    await initPaymentSheet(
      paymentIntentClientSecret: paymentintentmodel.clientSecret!,
    );

    await displayPaymentSheet();
  }
}
