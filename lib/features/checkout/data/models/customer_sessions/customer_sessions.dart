import 'components.dart';

class CustomerSessions {
  String? object;
  String? clientSecret;
  Components? components;
  int? created;
  String? customer;
  dynamic customerAccount;
  int? expiresAt;
  bool? livemode;

  CustomerSessions({
    this.object,
    this.clientSecret,
    this.components,
    this.created,
    this.customer,
    this.customerAccount,
    this.expiresAt,
    this.livemode,
  });

  factory CustomerSessions.fromJson(Map<String, dynamic> json) {
    return CustomerSessions(
      object: json['object'] as String?,
      clientSecret: json['client_secret'] as String?,
      components:
          json['components'] == null
              ? null
              : Components.fromJson(json['components'] as Map<String, dynamic>),
      created: json['created'] as int?,
      customer: json['customer'] as String?,
      customerAccount: json['customer_account'] as dynamic,
      expiresAt: json['expires_at'] as int?,
      livemode: json['livemode'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'object': object,
    'client_secret': clientSecret,
    'components': components?.toJson(),
    'created': created,
    'customer': customer,
    'customer_account': customerAccount,
    'expires_at': expiresAt,
    'livemode': livemode,
  };
}
