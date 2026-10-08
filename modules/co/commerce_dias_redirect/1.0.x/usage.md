<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce DIAS adds an off-site Drupal Commerce payment gateway that redirects shoppers to the Greek DIAS bank environment to enter card data and returns them to the site to finalize the order.

---

The gateway plugin (`dias_redirect`) registers the order with the DIAS order-registration API from the offsite redirect form, storing the returned DIAS `orderId` and gateway id in the order's `DiasGatewayData` data key, then POST-redirects the buyer to the bank `formUrl`. On return, an anonymous callback route `/commerce_dias_redirect/callback/{commerce_order}` re-queries the DIAS get-order-status API (`DiasApiService::getOrderStatus`) and only creates a completed `commerce_payment` when `errorCode == 0`, `orderStatus == 2` and `actionCode == 0`. The payment amount is taken server-side from `$order->getBalance()`, not from the request. A `hook_cron` implementation clears the checkout step of draft DIAS orders older than 15 minutes whose status is not paid.

Operational notes: merchant API urls, username and password are stored in the gateway plugin configuration. Currency is hard-coded to `978` (EUR) and amount is computed as an integer number of euros times 100.

---
- Install the module and enable it (depends on commerce_payment).
- Add a payment gateway at Commerce > Configuration > Payment > Payment gateways and pick DIAS Payment Redirect.
- Enter the DIAS order-registration API url from your bank agreement.
- Enter the DIAS get-order-status API url.
- Enter the merchant username supplied by the bank.
- Enter the merchant password supplied by the bank.
- Place a test order and choose the DIAS payment method at checkout.
- Verify the buyer is POST-redirected to the bank formUrl.
- Confirm a completed payment is created on successful return.
- Check the DiasGatewayData stored on the order after registration.
- Inspect dblog channel `commerce_dias_redirect` for success/failure entries.
- Confirm failed/cancelled payments redirect back to the cart.
- Rely on cron to reset stale draft orders stuck in the payment step.
- Implement `hook_commerce_dias_redirect_failure_url_alter` to change the failure redirect target.
- Review the order data field `DiasGatewayData` for rrn, approvalCode and card pan.
- Set the store default language, which is passed to DIAS as the payment language.
- Reconcile DIAS remote order status against Commerce payment records.
