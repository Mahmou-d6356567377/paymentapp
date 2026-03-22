import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:paymentapp/core/utils/api_service.dart';
import 'package:paymentapp/core/utils/apikeys.dart';
import 'package:paymentapp/features/checkout/data/models/customer_sessions/customer_sessions.dart';
import 'package:paymentapp/features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:paymentapp/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:paymentapp/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    var response = await apiService.post(
      url: '${Apikeys.baseurl}payment_intents',
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

  Future<String> createcustomsession({required String customerId}) async {
    var response = await apiService.post(
      url: '${Apikeys.baseurl}customer_sessions',
      body: {
        'customer': customerId,
        "components[mobile_payment_element][enabled]": true,
        "components[mobile_payment_element][features][payment_method_save]":
            "enabled",
        "components[mobile_payment_element][features][payment_method_redisplay]":
            "enabled",
        "components[mobile_payment_element][features][payment_method_remove]":
            "enabled",
      },
      contenttype: 'application/x-www-form-urlencoded',
      token: Apikeys.secretKey,
    );

    print('Stripe CustomerSession response: ${response.data}');

    return response.data['client_secret'];
  }

  Future<void> initPaymentSheet({
    required InitPaymentSheetInputModel initPaymentSheetInputModel,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
          merchantDisplayName: Apikeys.merchantDisplayName,
          customerId: initPaymentSheetInputModel.customerId,
          customerSessionClientSecret:
              initPaymentSheetInputModel.cutomersessionsSecret,
          //! customerEphemeralKeySecret: ephemeralKeySecret,  old version of flutter_stripe package
        ),
      );
    } on StripeException catch (e) {
      print(
        'StripeException during initPaymentSheet: ${e.error.localizedMessage}',
      );
      rethrow;
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

    var customerSessionSecret = await createcustomsession(
      customerId: paymentIntentInputModel.customerId,
    );

    var initpaymentsheetinputmodel = InitPaymentSheetInputModel(
      clientSecret: paymentintentmodel.clientSecret,
      customerId: paymentIntentInputModel.customerId,
      cutomersessionsSecret: customerSessionSecret,
    );

    await initPaymentSheet(
      initPaymentSheetInputModel: initpaymentsheetinputmodel,
    );

    await displayPaymentSheet();
  }
}

//   Future<void> makePayment({
//     required PaymentIntentInputModel paymentIntentInputModel,
//   }) async {
//     var paymentintentmodel = await createPaymentIntent(paymentIntentInputModel);
//     var customersessionmodel = await createcustomsession(
//       customerId: paymentIntentInputModel.customerId,
//     );
//     var initpaymentsheetinputmodel = InitPaymentSheetInputModel(
//       clientSecret: paymentintentmodel.clientSecret,
//       customerId: paymentIntentInputModel.customerId,
//       cutomersessionsSecret: customersessionmodel.clientSecret!,
//     );
//     await initPaymentSheet(
//       initPaymentSheetInputModel: initpaymentsheetinputmodel,
//     );

//     await displayPaymentSheet();
//   }
// }

// Future<CustomerSessions> createcustomsession({
//   required String customerId,
// }) async {
//   var response = await apiService.post(
//     url: '${Apikeys.baseurl}customer_sessions',
//     body: {
//       'customer': customerId,
//       "components[mobile_payment_element][enabled]": true,
//       "components[mobile_payment_element][features][payment_method_save]":
//           "enabled",
//       "components[mobile_payment_element][features][payment_method_redisplay]":
//           "enabled",
//       "components[mobile_payment_element][features][payment_method_remove]":
//           "enabled",
//     },
//     contenttype: 'application/x-www-form-urlencoded',
//     token: Apikeys.secretKey,
//   );

//   // debug: print the raw JSON so we can see what shape Stripe sent back
//   // remove or guard this in production
//   try {
//     print(
//       'Here you gonna see the CustomerSessionModel:${CustomerSessions.fromJson(response.data)}',
//     );
//     print(
//       '................Stripe CustomerSession response: ${response.data}',
//     );

//     final customerSessionClientSecret = response.data['client_secret'];
//     return customerSessionClientSecret != null
//         ? CustomerSessions.fromJson(response.data)
//         : throw FormatException(
//             'Missing client_secret in Stripe response: ${response.data}',
//           );
//   } catch (e) {
//     if (e is DioException) {
//       print("Stripe ERROR RESPONSE: ${e.response?.data}");
//     }
//     throw FormatException(
//       '.....................Failed to parse Stripe CustomerSession: $e\njson=${response.data}',
//     );
//   }
// }
