# Payment plugins

## commerce_payment.payment_gateway — processor integration
- Manager: `plugin.manager.commerce_payment_gateway`
  (`Drupal\commerce_payment\PaymentGatewayManager`).
- Attribute: `#[CommercePaymentGateway]` (id, label, display_label, forms,
  payment_method_types, payment_type, modes, requires_billing_information). Base classes in
  `src/Plugin/Commerce/PaymentGateway/` — `PaymentGatewayBase`, plus
  `OnsitePaymentGatewayInterface` (card entered on your site, supports stored methods) and
  `OffsitePaymentGatewayInterface` (redirect to provider). Optional capability interfaces:
  `SupportsRefundsInterface`, `SupportsVoidsInterface`, `SupportsAuthorizationsInterface`,
  `SupportsStoredPaymentMethodsInterface`, `SupportsNotificationsInterface`.
- Implement operations: `createPayment()`, `capturePayment()`, `refundPayment()`,
  `voidPayment()`, `createPaymentMethod()`, `deletePaymentMethod()`, and (off-site)
  `onReturn()`/`onCancel()`/`onNotify()`.

## commerce_payment.payment_method_type — stored instrument kind
- Manager: `plugin.manager.commerce_payment_method_type` (`PaymentMethodTypeManager`).
- Attribute `#[CommercePaymentMethodType]`; base `PaymentMethodTypeBase`. Defines label and
  how a stored method (e.g. `credit_card`, `paypal`) is built and labeled.

## commerce_payment.payment_type — payment category
- Manager: `plugin.manager.commerce_payment_type` (`PaymentTypeManager`).
- Attribute `#[CommercePaymentType]`; categorizes payments and the workflow they use.

To add a processor, write a gateway plugin (choosing on-site vs off-site + capability
interfaces) and, if needed, a payment method type. It becomes selectable when creating a
`commerce_payment_gateway` config entity.
