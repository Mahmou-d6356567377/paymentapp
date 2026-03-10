import 'package:dartz/dartz.dart';
import 'package:paymentapp/core/errors/failures.dart';
import 'package:paymentapp/core/utils/stripe_service.dart';
import 'package:paymentapp/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:paymentapp/features/checkout/data/repos/checkout_repo.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  StripeService stripeService = StripeService();

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      // Call the StribeService to make the payment
      // You can inject the StribeService as a dependency if needed
      // For example: final stribeService = StribeService();
      // await stribeService.makePayment(paymentIntentInputModel: paymentIntentInputModel);

      // For now, we will just return a successful result

      await stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );

      return Right(null);
    } catch (e) {
      if (e is Map) {
        print('Error response from Stripe (its a map ): $e');
        return Left(
          ServerFailure(
            errmessage: e['message']?.toString() ?? 'Payment failed',
          ),
        );
      } else {
        print('...........Unexpected error: $e');
        return Left(ServerFailure(errmessage: e.toString()));
      }
    }
  }
}
