<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipping method plugin & configuration

## Install / enable

`drush en commerce_boxnow` (pulls in `commerce_shipping`). Then at
**Commerce → Configuration → Shipping methods** (`/admin/commerce/config/shipping-methods`)
add a shipping method and choose plugin **BOXNOW Shipping**. There is one shipping-method
plugin and the module assumes a single BOX NOW method exists site-wide
(`CommerceBoxNowService::getBoxNowShippingMethodId()` loads all methods and returns the
first whose plugin id is `boxnow_shipping`).

## The plugin

`Plugin/Commerce/ShippingMethod/CommerceBoxNowShipping` —
`@CommerceShippingMethod(id = "boxnow_shipping", label = "BOXNOW Shipping")`, **extends**
`Drupal\commerce_shipping\Plugin\Commerce\ShippingMethod\FlatRate`. The constructor adds a
single `default` shipping service labelled from the parent's `rate_label` config, so it
behaves as a flat-rate method plus BOX NOW settings.

> Note: `commerce_boxnow.services.yml` also declares a service
> `commerce_boxnow.boxnow_shipping` whose `class` is `...\ShippingMethod\BoxNowShipping`
> (no such class — the real class is `CommerceBoxNowShipping`). The plugin is discovered
> by its annotation, not that service, so the stray service definition is inert.

## Config form fields

`buildConfigurationForm()` adds these to the standard FlatRate form; all are
`#type => textfield`, `#required => TRUE`. Defaults from `defaultConfiguration()`:

| key | default | purpose |
|-----|---------|---------|
| `api_url` | `''` | BOX NOW API base URL (paths `/api/v1/auth-sessions`, `/api/v1/delivery-requests` are appended) |
| `client_id` | `''` | OAuth2 client id (`client_credentials` grant) |
| `client_secret` | `''` | OAuth2 client secret |
| `partner_id` | `''` | Map-widget partner id (sent to the browser as `drupalSettings.boxNow.partnerId`) |
| `notify_on_accepted` | `''` | Email BOX NOW notifies when a parcel is accepted (validated as email) |
| `contact_number` | `''` | Origin (sender) contact phone |
| `contact_email` | `''` | Origin contact email (validated as email) |
| `contact_name` | `''` | Origin contact name |
| `contact_location` | `'2'` | BOX NOW origin **location id**; defaults to `2` for existing installs |

Plus the inherited FlatRate `rate_label` / `rate_amount`.

`validateConfigurationForm()` runs `filter_var(..., FILTER_VALIDATE_EMAIL)` on
`notify_on_accepted` and `contact_email`, setting form errors on invalid addresses.
`submitConfigurationForm()` copies each value into `$this->configuration[...]` only when
there are no form errors. All of these values are persisted inside the
`commerce_shipping_method` config entity's `plugin.target_plugin_configuration.boxnow_shipping`.
Store the OAuth credentials via your site's secret-management approach (a Key entity /
environment variable) rather than committing them.

## Install / update hook

`.install` provides `commerce_boxnow_post_update_add_contact_location_default`: entity-queries
all `commerce_shipping_method` entities that have a `boxnow_shipping` config, and for any
missing `contact_location` sets it to `'2'` and re-saves. This is the migration that
introduced the `contact_location` field for pre-existing methods.
