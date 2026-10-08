<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_valitor — gateway configuration

## Add the gateway
Standard Commerce payment gateway (`configure: commerce_payment.configuration`). Plugin `Valitor` (with `ValitorMock` for tests). Enter Valitor API credentials and select the mode; the plugin delegates HTTP to `ValitorPayApi` / `ValitorPayApiInterface`.

## Plugin forms
- `PluginForm/PaymentMethodAddForm` — tokenise/store a card.
- `PluginForm/PaymentMethodEditForm` — edit a stored method.
- `PluginForm/PaymentRefundForm` — refund a captured payment.

## 3-D Secure flow (`Controller/ValitorPay`)
| Route | Method | Purpose |
|-------|--------|---------|
| `/valitor/{commerce_payment_gateway}/verify` | POST | `createVirtualCardWithVerification` → calls `gateway->verifyCard(...)`, opens the 3DS window on success (AJAX `WindowOpenCommand`). |
| `/valitor/3ds` | GET | `redirect3ds` renders `valitor_redirect3ds` intermediate page. |
| `/valitor/webhook` | POST/OPTIONS | `webhook` reads `mdStatus`; on 1/2/4 renders success + 3DS params (`cavv`,`eci`,`xid`,`dsTransId`), otherwise logs `mdErrorMsg`/`iReqCode` and shows an error. Renders only. |

These routes are `_access: 'TRUE'` because they are called by the shopper's browser and the 3DS processor mid-checkout. Settlement/capture amounts come from the order's payment entity, not the request.
