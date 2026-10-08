<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce PayUMoney integrates the PayU / PayUMoney hosted checkout (popular in India) with Drupal Commerce as an offsite redirect gateway. Shoppers are sent to PayU to pay, and PayU calls back to the site's notify/success/failure endpoints to report the outcome.

---

Install with Composer (`drupal/commerce_payumoney`) and enable it (depends on commerce and commerce_payment). Create a PayUMoney payment gateway from the payment gateways collection (/admin/commerce/config/payment-gateways) and enter your merchant key and salt. PayU posts results to /payment/notify/payumoney, /payment/success/payumoney and /payment/failure/payumoney.

---

- Accept PayU/PayUMoney payments in Commerce.
- Redirect shoppers to the PayU hosted page.
- Handle PayU notify, success and failure callbacks.
- Reconcile the Commerce payment after checkout.
- Parse the order id from the PayU productinfo field.
- Record transactions in a custom database table.
- Mark the Commerce payment completed on success.
- Void the payment on failure.
- Configure merchant key and salt per gateway.
- Redirect the customer to order confirmation.
- Log incoming webhook payloads.
- Support GET and POST return methods.
- Provide a POST-only server-to-server notify route.
- Integrate with Commerce order and payment entities.
- Store merchant credentials as secrets.
- Restrict payment-gateway administration to trusted roles.
