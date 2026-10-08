<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce GMO LinkTypePlus adds a Drupal Commerce off-site payment gateway for GMO Payment Gateway (Mul-Pay) using their LinkTypePlus hosted payment page (docs.mul-pay.jp/linkplus).

---

Checkout is redirected to GMO's hosted page via an off-site redirect plugin form and a custom checkout pane; the module ships a dedicated `order_linktypeplus_validation` order workflow (draft → pending → completed/canceled) that the store must select on the order type. GMO returns results to three routes handled by `GmoLinkTypePlusController`: `/payment/success/order` (the browser-facing `result` POST that decodes the payment status, loads the order, creates/updates the `commerce_payment` entity and drives the order transition), `/payment/response/save` (a server-to-server response saver), and `/reccuringcredit/response` (a recurring-credit webhook). Status mapping (`statusMapper`) translates GMO states (REQSUCCESS, PAYSTART, PAYSUCCESS, ERROR/EXPIRED/INVALID, …) into Commerce payment states and redirect targets, with success/pending/failure URLs and messages read from the gateway plugin configuration. Event subscribers (`LinkTypePlusEventSubscriber`, `OrderFulfillmentSubscriber`) react to the dispatched payment event for fulfilment.

Setup: add and configure the LinkTypePlus gateway at `/admin/commerce/config/payment-gateways` (GMO shop id/credentials, hosted-page settings, and the success/pending/failure URLs + messages), then assign the `linktypeplus order workflow` to the order type at `/admin/commerce/config/order-types`. The three response routes are internet-facing; the payment amount used when creating the payment is taken from the loaded order rather than the request, but the response-handling routes have a permissive access posture (see security notes) and should be reviewed before production use.

---

- Accept payments through GMO Payment Gateway (Mul-Pay) LinkTypePlus.
- Redirect shoppers to GMO's hosted LinkPlus payment page at checkout.
- Add and configure the LinkTypePlus gateway under payment gateways.
- Assign the `linktypeplus order workflow` to a Commerce order type.
- Configure success/pending/failure redirect URLs and messages.
- Handle GMO browser return results at `/payment/success/order`.
- Handle server-to-server responses at `/payment/response/save`.
- Handle recurring-credit notifications at `/reccuringcredit/response`.
- Map GMO payment states to Commerce payment states.
- Create or update a `commerce_payment` entity from the GMO response.
- Transition the order to completed on a successful payment.
- Cancel the order when GMO reports error/expired/invalid.
- Return the shopper to checkout when payment is not started.
- Support credit, CVS, Pay-easy and PayPay payment methods.
- Fulfil orders via the LinkTypePlus event subscribers.
- Store the raw GMO response on the order for auditing.
- Derive the charged amount from the order rather than the request.
- Swap in the GMO payment-information checkout pane automatically.