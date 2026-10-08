<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# amazon_pa — configuration, routes & permission

## Permission & routes (`amazon_pa.routing.yml`, `amazon_pa.permissions.yml`)

One permission: **`administer amazon pa settings`** (`restrict access: true`). All four routes are
`_admin_route` and gated by it:

| Route | Path | Form |
|---|---|---|
| `amazon_pa.admin_settings` (the `configure` link, menu under *Config → Services*) | `/admin/config/services/amazon` | `Form\AmazonPaSettings` |
| `amazon_pa.admin_settings_storage` | `/admin/config/services/amazon/storage` | `Form\AmazonPaStorage` |
| `amazon_pa.admin_settings_test` | `/admin/config/services/amazon/test` | `Form\AmazonPaTest` |
| `amazon_pa.admin_settings_database` | `/admin/config/services/amazon/database` | `Form\AmazonPaDatabase` |

Local tasks (tabs) are defined in `amazon_pa.links.task.yml`; the menu link in `amazon_pa.links.menu.yml`.

## Config object `amazon_pa.settings`

Single `config_object` (schema `config/schema/amazon_pa.schema.yml`, install defaults
`config/install/amazon_pa.settings.yml`). Keys:

- **Credentials** (top level, plain strings): `amazon_credential_id`, `amazon_credential_secret`,
  `amazon_credential_version` (e.g. `2.1` NA / `2.2` EU / `2.3` far east), `amazon_default_locale`.
- **Per-locale associate IDs** (dynamic keys, one per locale): `amazon_locale_<LOCALE>_associate_id`
  for `US, UK, DE, FR, IT, ES, CA, JP, CN` (locales come from `includes/amazon_pa.locales.inc` via
  `AmazonPaUtils::amazon_pa_data_cache()`). These are **not** in the schema's static mapping — they
  are written directly by `AmazonPaSettings::submitForm()`.
- **`details`** mapping: `amazon_refresh_schedule` (int seconds, default 7200), `amazon_refresh_cron_limit`
  (int, default 50, # ASINs per cron run), `amazon_invalid_asin_alt` (string, fallback link for dead
  ASINs), `amazon_core_data` (sequence checkboxes: `images`, `creators` — gate whether image/contributor
  child rows are stored in `amazon_pa_item_insert()`).
- **`debug`** mapping: `amazon_request_delay` (int; `sleep()` before every request in
  `amazon_pa_api_request()`), `amazon_request_amount` + `amazon_request_amount_checkbox` (request
  counter), `amazon_token_request_delay` (used by the filter between 10-ASIN chunks),
  `amazon_only_nodes` (bool; skip API calls unless the current route is a node), `amazon_request_enabled`
  (bool; master switch — `amazon_pa_item_lookup_from_web()` and `amazon_pa_cron()` return early when off).
- **`update`** mapping: `amazon_update_on_node_edit`, `amazon_update_on_node_view`,
  `amazon_update_on_node_hook_save` (booleans; trigger a fresh web lookup on node save/view/update —
  see `amazon_pa_node_view()` / `amazon_pa_node_update()` / the `asin` widget validator).

## The four forms

- **`AmazonPaSettings`** (`ConfigFormBase`, id `amazon_pa_admin_settings`) — credential fields + a
  collapsible fieldset of per-locale associate IDs. `submitForm()` writes each locale key explicitly.
- **`AmazonPaStorage`** (id `amazon_pa_admin_storage_settings`) — refresh schedule/limit, extended-data
  checkboxes, invalid-ASIN fallback URL, the node-update triggers, and all `debug`/`tokens` options.
- **`AmazonPaTest`** (id `amazon_pa_admin_test_settings`) — enter one ASIN + locale; `validateForm()`
  calls `amazon_pa_item_lookup_from_web([$asin], $locale)`, `submitForm()` deletes+re-inserts the item
  and rebuilds the form to show the themed result (`amazon_item_test`) plus a `print_r` dump. Locale
  options are limited to locales that already have an associate ID set.
- **`AmazonPaDatabase`** (id `amazon_pa_admin_database_settings`) — two custom submit handlers:
  `amazon_pa_database_form_submit()` deletes one ASIN row (`DELETE FROM amazon_item WHERE asin = :asin`,
  parameterised), and `amazon_pa_delete_invalid_all_asins_submit()` deletes all rows where
  `invalid_asin = 1`.

Known upstream issue (from the project page / DEV notes): 3.x can WSOD on some admin pages; frontend is
unaffected.
