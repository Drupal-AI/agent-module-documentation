<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Opayo (Pi) payment gateway

**Depends on:** `commerce:commerce_payment`, `phone_international`, `queue_unique`.
**Generic settings:** `OpayoPiSettingsForm` — `/admin/commerce/config/opayo_pi/settings` (permission `administer opayo transactions`): Opayo vendor name, live/test integration keys & passwords, expired-record retention.

## Routes (checkout-flow endpoints)
| Route | Path | Permission |
|-------|------|-----------|
| `commerce_opayo_pi.3d_secure_page` | `/commerce_opayo_pi/3dSecure/{order}` | `access content` |
| `commerce_opayo_pi.3d_secure_result` | `/commerce_opayo_pi/3dSecure_result/{opayo_transaction_id}` | `access content` |
| `commerce_opayo_pi.merchantsessionkey` | `/commerce_opayo_pi/merchantsessionkey/{commerce_order}/{instruction}` | `access content` |
| `commerce_opayo_pi.merchantsessionkey2` | `/commerce_opayo_pi/merchantsessionkeyforgateway/{gw_id}/{instruction}` | `access content` |

All four are `no_cache: true`. They are the browser-side Opayo Pi checkout flow: the merchant-session-key endpoints mint a short-lived MSK used by the client-side JS to tokenize the card in the shopper's browser (the back-end never sees the PAN), and the 3D-Secure endpoints handle the ACS redirect/result. The MSK is a public-flow token, not order-owner-sensitive data — see the security note in start.md.

## Payment flow
Card details are tokenized client-side (Opayo drop-in **or** the module's custom form) → server creates the transaction → optional 3D-Secure step (iframe or standalone page) → result processed. `Cron` + `queue_unique` reconcile/expire `opayo_transaction` records. Core service `OpayoPi` wraps the Pi REST API.

## Setup
1. Set generic Opayo credentials on the settings form.
2. Add a Commerce payment gateway using plugin **Opayo (Pi integration)**; enable *Collect billing information*.
3. Use the **Opayo checkout flow** (adds the 3D Secure pane); ensure orders' order types use it.
4. Provide a customer phone in international format (plain-text or Phone International field).
