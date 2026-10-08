<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Boncard integrates the Boncard gift-card / prepaid-card system into Drupal Commerce as a redeemable balance applied during checkout.

---
Checkout panes let a shopper enter a card number/CVC; `BoncardClient` calls the Boncard REST API (`/api/v1/balance`, `/payment`, `/submission`, `/credit`, `/reversal`) to check balance, authorize, capture, refund and cancel. Each outbound request is signed with an HMAC-SHA256 signature computed from the operation payload plus the configured `password` (`calculateSignature()`), and card transactions are stored as `commerce_boncard` entities that participate in a workflow and an order adjustment (applied last, priority -1000). Admin/order operations run through the `/admin/commerce/orders/{order}/giftcards/{boncard}/operation/{operation}` route guarded by `BoncardOperationAccessCheck`, which delegates to the entity's per-operation `access()`, plus granular permissions (create/view/edit/cancel/refund/delete boncard transaction).

Security posture: this is an outbound-only integration (no inbound webhook to forge); requests are HMAC-signed, operations are entity-access-checked, and the HTTP client uses default TLS. Note that card number/CVC are stored on the transaction entity. Setup: enter Boncard user/terminal/merchant IDs and API password at `/admin/commerce/config/boncard`, add the redemption pane to checkout, then manage transactions from the order.
---
- Configure Boncard credentials at `/admin/commerce/config/boncard`.
- Let customers redeem a Boncard gift card at checkout.
- Check a card's remaining balance.
- Authorize a payment against a gift card.
- Capture (submit) a previously authorized amount.
- Refund an amount back to a card.
- Cancel/void an authorization.
- Apply the gift-card balance as an order adjustment.
- Track transactions as `commerce_boncard` entities.
- Move transactions through a workflow.
- Grant `create/view/edit boncard transaction` permissions.
- Restrict refunds via `refund boncard transaction`.
- Sign API calls with HMAC-SHA256.
- View the Boncard transaction overview page.
- Handle partial approvals and partial refunds.
- Localise merchant name/ID per store.
