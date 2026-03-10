import 'package:dartz/dartz.dart';
import 'package:paymentapp/core/errors/failures.dart';
import 'package:paymentapp/features/checkout/data/models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
