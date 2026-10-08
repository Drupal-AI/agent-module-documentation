<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce FedEx (commerce_fedex) — agent index

Adds a **FedEx** shipping-method plugin to Drupal Commerce Shipping that fetches **live rates**
from the FedEx REST API (via the `whatarmy/fedex-rest` library) at checkout. Rates are cached,
optionally multiplied/rounded, and a tracking-URL builder is provided. Two experimental submodules
add FedEx special services (dangerous goods, dry ice).

- Depends on `commerce_shipping:commerce_shipping`. Composer also requires `drupal/commerce`,
  `whatarmy/fedex-rest`, `ext-soap`, `php >=7.4`. Core `^10 || ^11`.
- **No module settings page** (`configure` = null). You configure it by creating a **FedEx
  shipping method** at `admin/commerce/shipping-methods`; all settings are third-party config on
  that `commerce_shipping_method` entity.
- Defines **no permissions** and **no drush commands**. Defines **one plugin type** (FedEx Service
  plugins) and **two events**. Ships **config schema**.
- Newest release on the `2.0.x` branch is **2.0.0-alpha2** (no stable release exists yet).

What you'd do:
- **Set up the FedEx shipping method (credentials, mode, packaging, pricing, logging)** → [configure/shipping_method.md](configure/shipping_method.md)
- **Understand the token/rate-request client and the rate-calculation flow** → [api/rate_request.md](api/rate_request.md)
- **Add a custom FedEx service plugin (special services / package splitting)** → [plugins/fedex_service.md](plugins/fedex_service.md)
- **Alter the rate request or the packed order items from another module** → [events/events.md](events/events.md)

Key facts:
- Shipping-method plugin id: `fedex` (`Drupal\commerce_fedex\Plugin\Commerce\ShippingMethod\FedEx`),
  implements `SupportsTrackingInterface`.
- Services: `commerce_fedex.fedex_request` (`FedExRequest`), `commerce_fedex.commerce_fedex_packer`
  (tagged `commerce_shipping.packer`), `plugin.manager.commerce_fedex_service`,
  `logger.channel.commerce_fedex`, `cache.fedex` (cache bin), `commerce_fedex.rate_request_subscriber`.
- FedEx Service plugin type: manager `plugin.manager.commerce_fedex_service`
  (`FedExPluginManager`), annotation `@CommerceFedExPlugin`, interface `FedExPluginInterface`,
  base `FedExPluginBase`, directory `Plugin/Commerce/FedEx`, alter hook `hook_commerce_fedex_info_alter()`.
- Events: `commerce_fedex.before_rate_request`, `commerce_fedex.before_pack`
  (constants on `CommerceFedExEvents`).
- Config keys (per shipping method): `api_information.{api_key,api_password,account_number,mode}`,
  `options.{packaging,rate_request_type,pickup_type,insurance,rate_multiplier,round,log,tracking_url}`,
  `plugins`.
- Submodules: `commerce_fedex_dangerous`, `commerce_fedex_dry_ice` (both flagged experimental).
