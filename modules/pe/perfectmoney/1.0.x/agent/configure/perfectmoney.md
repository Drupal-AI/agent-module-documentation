<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Perfect Money

1. Install the Basket (AlternativeCommerce) module — Perfect Money plugs into it as a payment method.
2. Enable `perfectmoney`.
3. At `/admin/basket/settings-payment` create a payment point and select the "Perfect Money" service.
4. Open the gateway settings at `/admin/config/development/perfectmoney` (permission `access perfectmoney settings`) and enter your Perfect Money payee account and passphrase; enable test mode to trial the flow first.

Payment flow: shoppers are redirected to perfect.money and returned to `/perfectmoney/{page_type}` (`Pages::pages`). The status callback is validated before the order is marked paid: the controller recomputes `md5(...:ALTERNATE_PHRASE_HASH)` over the returned fields (including the amount) and requires it to equal the gateway-supplied `V2_HASH`. Keep the passphrase secret — it is the shared secret that makes the callback unforgeable.
