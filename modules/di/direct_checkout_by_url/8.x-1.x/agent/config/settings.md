<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Form: `SettingsForm` at `/admin/commerce/config/orders/direct-checkout-by-url`
(route `direct_checkout_by_url.settings`, permission `administer direct checkout by url`,
menu link under `commerce_order.configuration`).

Config object: `direct_checkout_by_url.settings` (schema `config_object`).

| Key | Type | Default | Effect |
| --- | --- | --- | --- |
| `allow_unknown_skus` | integer (checkbox) | `0` | Off: an unknown SKU in the URL throws a 404. On: unknown SKUs are silently skipped, so an archived/stale link still adds whatever products still exist. |
| `reset_cart` | integer (checkbox) | `0` | Off: linked items are added on top of the visitor's existing cart. On: the cart is emptied first, so the visitor reaches checkout with exactly the linked items (and loses anything they already had). |

Both settings are read at request time by `CheckoutByUrlController` — `allow_unknown_skus`
in the SKU-loading branch and `reset_cart` before `addEntity()`.

Default config (`config/install/direct_checkout_by_url.settings.yml`):

```yaml
reset_cart: 0
allow_unknown_skus: 0
```

Drush example (read-only inspection):

```
drush config:get direct_checkout_by_url.settings
```
