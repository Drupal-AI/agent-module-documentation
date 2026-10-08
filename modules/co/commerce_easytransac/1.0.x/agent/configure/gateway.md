<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the EasyTransac gateway

## Prerequisites
- `composer require easytransac/easytransac` (PHP SDK) and Commerce with payments.

## Add the gateway
1. **Commerce → Configuration → Payment gateways → Add**, choose *EasyTransac* (or the
   Pay by bank variant).
2. Paste the **API Key**. The mode is derived automatically: keys starting `et_test_` = Demo,
   `et_live_` = Real (the manual mode selector is hidden).
3. Copy the read-only **Notification URL** (the Commerce `commerce_payment.notify` route for
   this gateway) into your EasyTransac application settings.
4. (EasyTransac gateway) toggle **OneClick payments**, **Multiple payments** and choose the
   allowed installment counts (2–12); optionally set a **Preauthorization duration** (1–30 days).

## Module settings
`/admin/commerce/config/easytransac` (`commerce_easytransac.settings`) — global EasyTransac
options (permission `administer commerce easytransac`).

## Flow & verification
Customer pays on EasyTransac's hosted form → returns to `onReturn` / server notify to `onNotify`.
Both call `PaymentNotification::getContent($request->request->all(), $apiKey)` to verify the
signature; `onReturn` checks order id, `matchCustomer()` checks user id. Payment amount/state are
read from the verified response and mapped to Commerce states
(captured→completed, authorized→authorization, refunded, pending, failed).

## Payment operations
Capture, Void, Refund (once, on completed), plus **Synchronize** and **Status** operations that
re-query EasyTransac. Outgoing requests can be altered by subscribing to `EasyTransacEvents`.