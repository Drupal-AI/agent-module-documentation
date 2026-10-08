<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce EasyTransac (commerce_easytransac) — agent index
**Drupal Commerce offsite payment gateway for EasyTransac (cards, Pay by bank, installments, OneClick).**

- **Version:** 1.0.x  •  **Core:** ^9 || ^10 || ^11  •  **Requires:** commerce_payment, address; SDK `easytransac/easytransac`
- **Settings route:** `commerce_easytransac.settings` `/admin/commerce/config/easytransac` (`administer commerce easytransac`)
- **Gateways:** `easytransac` (cards) and `paybybank`, extending `OffsitePaymentGatewayBase`
- **Callbacks:** `onReturn` (browser) and `onNotify` (`commerce_payment.notify`, POST-only) — both verify the EasyTransac signature via `PaymentNotification::getContent(payload, apiKey)`
- **Ops:** capture / void / refund / sync / status; `EasyTransacRequestEvent` to alter requests
- **Security:** notification/return payloads are signature-verified with the account API key; `onReturn` matches order id and `matchCustomer()` matches the user id; payment amount/state come from the verified response, not client input; test/live derived from key prefix. API key stored in gateway config. No unverified callback, client-set amount, disabled TLS or hardcoded secret observed.

See [configure/gateway.md](configure/gateway.md).