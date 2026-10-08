<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Perfect Money adds a Perfect Money payment method to the AlternativeCommerce (Basket) commerce module, embedding perfect.money's hosted payment flow.
---
The problem it solves: sites using the Basket (AlternativeCommerce) module need to accept payments through Perfect Money. This module registers Perfect Money as a Basket payment point and handles the redirect to the gateway and the return/status callback.

How it works: an admin configures the gateway at `/admin/config/development/perfectmoney` (permission `access perfectmoney settings`) with the payee account, passphrase and test-mode options, and creates a Basket payment point using the "Perfect Money" service. The `/perfectmoney/{page_type}` route (`Pages` controller) renders the payment pages and processes the gateway's callback. The status callback is signature-verified: the module computes `md5(...:ALTERNATE_PHRASE_HASH)` from the returned fields (including amount) and compares it to the gateway's `V2_HASH` before treating the payment as complete, so a forged callback without the correct passphrase hash is rejected.

Setup: install Basket, enable this module, go to `/admin/basket/settings-payment` to create a payment point with the Perfect Money service, then open the gateway settings to enter your Perfect Money credentials; optionally enable test mode first.
---
- Accept Perfect Money payments through the Basket module.
- Register Perfect Money as a Basket payment point/service.
- Configure the Perfect Money payee account and passphrase.
- Run the gateway in test mode before going live.
- Redirect shoppers to perfect.money to pay.
- Handle the payment return/status callback.
- Verify the callback signature (`V2_HASH` vs `md5(...:ALTERNATE_PHRASE_HASH)`) before completing an order.
- Confirm the paid amount as part of the signature check.
- Restrict gateway settings to the `access perfectmoney settings` permission.
- Localise the payment UI via the interface-translation project.
- Provide payment landing pages under `/perfectmoney/{page_type}`.
- Integrate Perfect Money into a Basket checkout flow.
- Set the payee Perfect Money account that receives funds.
- Reject forged payment callbacks lacking the correct passphrase hash.
- Translate the gateway UI into other languages via .po files.
- Switch between live and test gateways from the settings form.
- Complete a Basket order only after gateway confirmation.
- Restrict who can edit gateway credentials by permission.
