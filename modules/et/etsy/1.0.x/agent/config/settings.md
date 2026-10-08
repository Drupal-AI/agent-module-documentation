<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, routes, permission, test form, block, hooks

## Install / enable

`composer require drupal/etsy` (pulls `drupal/oauth2_client:^4.0.3` and `drupal/imagecache_external:^3.0`), then `drush en etsy`. Enabling installs config `etsy.settings` and the oauth2_client config entity `oauth2_client.oauth2_client.etsy`.

## Config object `etsy.settings`

`config/install/etsy.settings.yml` (no `config/schema/` ships in this module):

- `cache_lifetime` (int seconds; install default **42300**) — how long API responses are cached; `0` disables caching.
- `shop_id` (string; install default `''`) — the Etsy shop id all shop-scoped calls use.

Credentials (keystring / shared secret / tokens) are **not** in this object — see [../api/oauth.md](../api/oauth.md).

## Settings form — `EtsySettingsForm`

`src/Form/EtsySettingsForm.php`, extends `ConfigFormBase`, form id `etsy_settings_form`, editable config `etsy.settings`. Fields:

- `shop_id` — textfield, **required**.
- `cache_lifetime` — select: Disabled(0)/1h(3600)/2h(7200)/6h(21600)/12h(43200)/24h(86400).

Injects `etsy.api` (unused in build). Route `etsy.settings` = `/admin/config/services/etsy`, `_admin_route: true`.

## Test form — `EtsyTestForm`

`src/Form/EtsyTestForm.php` (`FormBase`, id `etsy_test_form`). Route `etsy.test_form` = `/admin/config/services/etsy/testing-form`. A select chooses an API call (ping / me / shop_info / listings / listing / listing_properties / listing_transactions / receipts / seller_taxonomy / buyer_taxonomy / sections / error) plus contextual id fields; `ajaxSubmit()` calls the matching `etsy.api` method and renders the response (`print_r` in `<pre>`, or the `->error` string). Attaches library `etsy/etsy_test_form` (css only). Admin-only.

## Routes & permission

`etsy.routing.yml`: both `etsy.settings` and `etsy.test_form` require `_permission: 'administer etsy settings'` and are `_admin_route`. Permission `administer etsy settings` (`etsy.permissions.yml`, `restrict access: true`). Menu link `etsy.settings` under `system.admin_config_services`; local tasks "Settings" + "Testing" (`etsy.links.task.yml`).

## Block — `etsy_trademark_block`

`src/Plugin/Block/EtsyTrademarkNoticeBlock.php`: outputs the fixed trademark notice required by the Etsy API ToS ("The term 'Etsy' is a trademark of Etsy, Inc. This application uses the Etsy API but is not endorsed or certified by Etsy.").

## Hooks / helpers (`etsy.module`)

- `etsy_cron()` — `etsy.api::ping()` to keep the OAuth2 token alive.
- `etsy_requirements('runtime')` — pings the API and reports OK / warning (no client) / error (connection failed) on the status report; shows the Etsy application id on success.
- `etsy_uninstall()` — deletes `etsy.settings` and `oauth2_client.oauth2_client.etsy`, invalidates caches.
- `etsy_help()` — placeholder help text.
- `etsy_supported_currencies()` — currency-code → symbol/label map (also used by the price field formatter/widget).

## Rate limits / caching

Etsy limits requests (~5,000/24h). Set `cache_lifetime` above `0` so `shopInfo`/`getListingById`/`getShopSections`/`getListingProperties` responses are cached; see [../api/service.md](../api/service.md) for exact cache ids and the `getListingsByShop` caching quirk.
