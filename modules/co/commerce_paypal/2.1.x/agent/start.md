<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_paypal — agent start

Adds **PayPal payment gateways** to **Drupal Commerce**. Depends on `commerce_payment`.
It ships `commerce_payment_gateway` plugin implementations (not new plugin *types*): each
is configured as a `commerce_payment.commerce_payment_gateway.*` config entity with a
`mode` (`test` = Sandbox / `live`) plus product-specific credentials.

There is **no dedicated settings route** for the gateways — they are created and edited on
Commerce's own Payment gateways admin at `/admin/commerce/config/payment-gateways`
(permission `administer commerce payment gateway`). The only module route form is the
PayPal Credit messaging settings (`/admin/commerce/config/payment/paypal-credit`).

- **Payment gateway plugin ids, credentials, and how they register** → [plugins/payment-gateways.md](plugins/payment-gateways.md)
- **Configure a gateway (mode + credentials) via UI, config, or Drush** → [configure/gateways.md](configure/gateways.md)
- **Call the PayPal REST SDK layer programmatically / alter requests** → [api/sdk.md](api/sdk.md)

**Limitation:** live PayPal calls need real credentials and outbound network access. In a
sandbox/dev environment you can still create and introspect the gateway **config entities**
(plugin id + mode + credentials) — that is what the eval suite is grounded in — but you
cannot complete a real transaction.
