<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Payin-Payout adds an off-site Drupal Commerce payment gateway that POST-redirects the buyer to the Payin-Payout hosted payment form and completes the order from a signed server-to-server notification.

---

The offsite form (`PayinPayoutForm`) builds a signed POST to the live (`https://lk.payin-payout.net/api/shop`) or test endpoint, sending agent id/name, order id, amount, email, formatted customer phone, currency and a `sign`. The sign is `md5(implode('#', $data) . '#' . md5($api_token))` (`PayinPayoutHelper::generateSign`, md5 required by the gateway). The gateway's `onNotify(Request)` handler validates that all expected fields are present, ignores failed-status notifications, loads the order by `orderId`, recomputes the sign over the notification fields and compares it with `hash_equals()` against the request `sign`, and only then creates a `completed` payment using the notification `amount`/`currency`. It replies with the XML ack `<response><result>0</result></response>`.

Operational notes: the gateway requires a customer profile phone field (selected in config) because Payin-Payout needs a phone number. The API token is stored in plaintext gateway plugin config (no Key entity). The notification endpoint is the standard Commerce `onNotify` route, which is anonymous by design, but fulfillment is gated by the `hash_equals` signature check over token-derived data, so an unsigned/forged callback is rejected. Note the created payment amount and currency come from the (signed) request rather than being re-fetched from Payin-Payout; the signature is the integrity control.

---
- Enable the module (depends on commerce_payment) and add a Payin-Payout gateway.
- Choose test or live payment mode.
- Enter the Payin-Payout API token.
- Enter the agent (store) id and display name.
- Optionally set an order id prefix shown to the buyer.
- Select the customer profile field that stores the phone number.
- Toggle API logging to debug request payloads to dblog.
- Ensure the customer profile type has a phone field before use.
- Place a test order and select Payin-Payout at checkout.
- Confirm the buyer is POST-redirected to the hosted form.
- Verify the signed notification creates a completed payment.
- Confirm forged/unsigned notifications are rejected by hash_equals.
- Check the XML ack response tells the gateway to stop retrying.
- Map RUB/RUR currency codes automatically via the helper.
- Reconcile remote payment status (1 success, 2 failed, 3 partial).
- Review dblog channel `commerce_payin_payout` when logging is on.
