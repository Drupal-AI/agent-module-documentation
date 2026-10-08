<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AdInsight Clarity (adinsight_clarity) — agent index

Integrates the **AdInsight Clarity** (now **ResponseTap**) subscription **call-tracking** service:
attaches the vendor's dynamic-number JavaScript to every page and gives four ways to place a
tracked telephone number in markup. Package `Tracking`. **No module dependencies** (Token is an
optional integration). Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version
1.0.0-beta1 (version dir 1.0.x). This is **not** Microsoft Clarity — it is AdInsight/ResponseTap
phone-call analytics.

- **Install, settings form, config object/schema, routes & permission, and all four placement
  methods** → [config/settings.md](config/settings.md)

## What it actually is

- One config object **`adinsight_clarity.settings`** with three string keys: `account`, `pool`,
  `base_phone` (schema in `config/schema/adinsight_clarity.schema.yml`, install defaults empty in
  `config/install/adinsight_clarity.settings.yml`).
- Admin form `Drupal\adinsight_clarity\Form\AdminSettingsForm` (`ConfigFormBase`) at route
  **`adinsight_clarity.admin_settings_form`** → `/admin/config/tracking/adinsight_clarity`,
  gated by permission **`administer adinsight clarity`** (menu link under *Configuration →
  Development/Services*, `system.admin_config_services`).
- `hook_page_attachments()` in `adinsight_clarity.module`: when `account` is set, attaches library
  `adinsight_clarity/adinsight_clarity` and `drupalSettings.adinsight_clarity.account`.
- `js/adinsight_clarity.js` (`Drupal.behaviors.adinsight_clarity`, via `core/once`) reads the
  account from `drupalSettings` into `window.adiInit` and injects the vendor script
  `rTapTrack.min.js` from `static-ssl.responsetap.com` (HTTPS) / `static-cdn.responsetap.com`
  (HTTP).

## The four placement methods (all render the same `<span>`)

- **Block**: `Plugin\Block\AdinsightClarityBlock` (id `adinsight_clarity_block`, label *"AdInsight
  Clarity Telephone Number"*) → returns `_adinsight_clarity_build_tag()`.
- **Filter**: `Plugin\Filter\AdinsightClarityFilterTag` (id `adinsight_clarity_filter_tag`,
  TYPE_TRANSFORM_IRREVERSIBLE) — replaces the literal `<adinsight />` tag with the rendered span.
- **Token** (needs contrib `token` for the UI): `adinsight_clarity.tokens.inc` provides tokens
  `account`, `pool`, `base-number`, `tag` under type `adinsight_clarity`.
- **Manual HTML**: paste the `<span>` shown on the settings page into a template/content.

## Mechanism (from source)

- `_adinsight_clarity_build_tag()` (in `.module`, `drupal_static`-cached) builds a render array
  `#theme => 'adinsight_clarity_tag'` from `pool` + `base_phone` (returns nothing until both are
  set). `hook_theme()` declares the theme; `template_preprocess_adinsight_clarity_tag()` adds
  classes `tel-number` and `adinsightNumber{pool}`, and for `tag == 'a'` sets `href = tel:{base}`.
  Template `templates/adinsight-clarity-tag.html.twig`: `<{{ tag }}{{ attributes }}>{{ base }}</{{ tag }}><span>*</span>`.
- `AdminSettingsForm::validateForm()` enforces numeric `account`, numeric `pool`, and
  numbers-and-spaces `base_phone` before save, and resets the tag static.
- `hook_uninstall()` deletes `adinsight_clarity.settings`.

No entities, no services, no Drush, no submodules. Provides plugin *instances* (a block + a filter),
not plugin types.
