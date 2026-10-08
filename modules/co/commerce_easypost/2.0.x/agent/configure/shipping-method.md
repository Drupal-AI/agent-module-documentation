<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the EasyPost shipping method

## Prerequisites
- Commerce with Shipping and `commerce_shipping_label` enabled.
- A shipping-enabled store and shipment type.
- An EasyPost account + API key.

## Add the method
1. Commerce → Shipping methods → Add.
2. Choose plugin **EasyPost**.
3. Under **API information**: paste the **API key** and pick **mode** (test/production).
4. Under **enabled services**: tick the carrier services to expose; optionally allow a customer carrier account per carrier.
5. Under **customs**: set send-customs toggle, tax id, description, HS tariff number, customs signer (for international).
6. Under **options**: dropoff type, incoterm, include order number, sender phone, insurance, rate multiplier, rounding.

## Runtime surface (EasyPostManager)
- `getRates()` — live rate lookup (filtered to enabled services, multiplier/rounding applied).
- `createEasyPostShipment()` / `buyShipment()` — create and buy a label.
- `shipment->refund()` — void/refund a label (`EasyPost.php:544`).
- `getTrackingUrl()` — tracking link.
- `getPickupRates()` / `schedulePickup()` / `cancelPickup()` — scheduled pickups.

## Security notes
- The API key lives in the shipping-method configuration in plaintext (the standard Commerce gateway approach). Limit "administer commerce shipping methods" to trusted roles; consider environment separation for test vs production keys.
- All traffic uses the official `EasyPost\EasyPostClient` SDK over HTTPS; TLS verification is not modified.
- No public/anonymous endpoints — every privileged action is an authenticated admin/fulfilment operation.
