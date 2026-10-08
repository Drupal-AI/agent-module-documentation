<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Culqi (commerce_culqi) — agent index

**Culqi (Peru) payment integration for Drupal Commerce: card charges + cash/PagoEfectivo, with AJAX charge/order endpoints.**

- **Version:** 3.0.x
- **Core:** ^11
- **Requires:** commerce_payment, basic_auth
- **Gateways:** `CulqiPaymentGateway` (card), `CulqiCashPaymentGateway` (cash) + `CulqiCashMessagePane`
- **Routes:** `commerce_culqi/create_charge`, `commerce_culqi/create_order` (`CulqiController`, **_access: TRUE**); `commerce_culqi/order_event` (basic_auth + logged-in)
- **Service:** `commerce_culqi.culqi` → `CulqiService`

**Security:** RECORDED Danger 3 — `create_charge` is anonymous (`_access: 'TRUE'`, routing.yml:5-6) and `CulqiService::createCharge()` charges the **request-supplied `amount`** instead of the order total → price manipulation. Documented, not re-investigated. See [configure/gateway.md](configure/gateway.md).
