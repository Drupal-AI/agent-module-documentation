<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Sezzle Pay integrates Sezzle's buy-now-pay-later checkout with Drupal Commerce as an offsite gateway. Shoppers are sent to Sezzle to arrange instalments; on return the module authenticates to the Sezzle API and reads the order's captured/approved status to complete the Commerce payment. It also offers an optional review-skip checkout pane.

---

Install with Composer (`drupal/commerce_sezzle_pay`) and enable it (depends on commerce_payment). Create a Sezzle Pay payment gateway and enter the public and private API keys, mode, and options (shipping info sync, merchant-completes, skip-review, logging); saving the gateway registers the Sezzle webhook. On return the module calls the Sezzle order-details API with a fresh token and only completes the payment when Sezzle reports the order captured/approved. Store the API keys as secrets.

---

- Offer Sezzle buy-now-pay-later at checkout.
- Redirect shoppers to Sezzle offsite.
- Authenticate to the Sezzle API with public/private keys.
- Re-fetch order details from Sezzle on return.
- Complete payment only when Sezzle reports captured/approved.
- Register the Sezzle webhook on gateway save.
- Optionally sync Sezzle shipping address to the order.
- Provide an optional skip-review checkout pane.
- Support refunds and partial refunds.
- Configure a merchant-completes mode.
- Log API/webhook messages for debugging.
- Set the Commerce payment to the order total.
- Create a Sezzle payment method entity.
- Support live and sandbox modes.
- Store Sezzle API keys as secrets.
- Integrate with Commerce payment workflow.
