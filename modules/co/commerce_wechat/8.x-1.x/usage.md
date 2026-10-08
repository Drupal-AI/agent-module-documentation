<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce WeChat Pay integrates **WeChat Pay (APIv3)** as a payment gateway for Drupal Commerce. It supports
Native (PC QR code), H5 (mobile browser), and JSAPI (in-WeChat) ordering, plus refunds, using WeChat's v3
signed + AES-GCM-encrypted notification protocol.

Use it to accept WeChat Pay in a China-market Commerce store. It depends on `yunke_qrcode` for the PC payment QR
code and requires the merchant's APIv3 key, private key, and certificate serial number.
---
- Requires `commerce_payment` and `yunke_qrcode`; enable with `ddev drush en commerce_wechat`.
- Add a gateway at `/admin/commerce/config/payment-gateways` → **wechat pay**.
- Configure App ID, Merchant ID, API v3 secret key, merchant serial number, and the merchant private key.
- On save the module fetches and caches the WeChat **platform certificate** (refreshed ~every 12h).
- Async notifications arrive at Commerce's `commerce_payment.notify` route and are signature-verified + decrypted.
- Store all keys as secrets; serve over HTTPS.
---
- Accept WeChat Pay via Native (PC QR), H5, and JSAPI flows.
- Verify each async notification's **signature** against the WeChat platform certificate (5-min timestamp window).
- Decrypt the AES-GCM notification payload with the APIv3 key.
- Bind the payment to the local entity via `out_trade_no` and **check amount + currency** before completing.
- Complete the Commerce payment only on `trade_state == SUCCESS` with a matching amount.
- Actively re-query WeChat on the return page and verify the paid amount (does not trust the browser).
- Verify the returned payment entity belongs to the order (blocks cross-order return attacks).
- Support full and partial **refunds** with lock-guarded refund notifications.
- Track refund state in order data (NEW/SUCCESS/FAIL).
- Show a PC QR code with configurable color/size via yunke_qrcode.
- Provide an anon `paymentCheck` endpoint returning only a SUCCESS/FAIL state for polling.
- Auto-redirect the mobile return page once payment is confirmed.
- Distinguish payment vs refund notifications by `event_type`.
- Deduplicate repeated success notifications idempotently.
- Namespace orders with a `systemId` to avoid collisions across multiple installs.
- Test the full order + notify + refund loop before production.
