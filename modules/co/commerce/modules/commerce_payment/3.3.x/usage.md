Commerce Payment provides the pluggable payment layer for Drupal Commerce: payment gateways, payment methods, stored payment instruments and the payment entities that record transactions.

---

Payment in Commerce is built on three plugin types. A **payment gateway** (`commerce_payment.payment_gateway`) integrates a processor (Stripe, PayPal, etc.) and comes in on-site (card details entered on your site) and off-site (redirect to the provider) variants, with optional support for refunds, voids, authorizations and stored cards. A **payment method type** (`commerce_payment.payment_method_type`) describes a kind of stored instrument (credit card, PayPal account). A **payment type** (`commerce_payment.payment_type`) categorizes the resulting payments. The module defines the `commerce_payment` entity (a recorded payment against an order) and the `commerce_payment_method` entity (a reusable, tokenized instrument tied to a customer). A checkout payment pane collects or selects a method and drives the gateway. Gateways are configured as `commerce_payment_gateway` config entities (per store/site), including test vs. live mode and credentials. It depends on Commerce, Order, Entity Reference Revisions and Filter. Manage gateways at Admin → Commerce → Configuration → Payment gateways (`commerce_payment.configuration`). The base module ships the framework; concrete integrations (Stripe, Braintree, etc.) are separate contrib modules, and `commerce_payment_example` demonstrates the API.

---

- Accept credit-card payments through an on-site gateway.
- Redirect customers to an off-site processor (e.g. PayPal) and back.
- Configure multiple payment gateways per store.
- Toggle a gateway between test and live mode.
- Store customer payment methods for repeat/one-click purchases.
- Record payments against orders as payment entities.
- Authorize now and capture later.
- Refund a payment fully or partially.
- Void an uncaptured authorization.
- Add a payment step (pane) to checkout.
- Let customers choose a saved card at checkout.
- Support recurring/tokenized card charges.
- Integrate a regional payment processor via a custom gateway plugin.
- Define a custom payment method type for a new instrument.
- Gate gateway availability with conditions (order total, currency).
- Track payment state (authorization, completed, refunded) per order.
- Show payment history in the back office.
- Handle asynchronous payment notifications (IPN/webhooks) via gateway routes.
- Reconcile order balance against recorded payments.
- Provide manual/offline payment (cash on delivery, bank transfer).
- Comply with SCA/3DS flows through gateway integrations.
