import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paymentapp/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:paymentapp/features/checkout/data/repos/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(PaymentLoading());
    try {
      final result = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );
      result.fold(
        (failure) =>
            emit(PaymentFailure(errorMessage: failure.message.toString())),
        (success) => emit(PaymentSuccess()),
      );
    } catch (e) {
      emit(PaymentFailure(errorMessage: e.toString()));
    }
  }

  @override
  void onChange(Change<PaymentState> change) {
    print(
      'PaymentCubit state changed: ${change.currentState} -> ${change.nextState}',
    );
    super.onChange(change);
  }
}
