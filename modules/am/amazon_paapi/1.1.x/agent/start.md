<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon Product Advertising API (amazon_paapi) — agent index

A **lean developer wrapper** that wires the Amazon Product Advertising API 5.0 PHP SDK
(`thewirecutter/paapi5-php-sdk`, Composer `require` only — not a Drupal module dep) into Drupal
and hands back a **credential-configured SDK client**. It ships **no product-display features** of
its own; you assemble requests with the SDK classes. Package `Amazon`. Core `^10.1 || ^11`.
License GPL-2.0-or-later. Version 1.1.7.

## What it actually provides

- **One service** `amazon_paapi.amazon_paapi` → `Drupal\amazon_paapi\AmazonPaapi`
  (`src/AmazonPaapi.php`, no constructor args). `getApi(?ClientInterface $client = NULL)` returns a
  configured SDK `DefaultApi` (`Amazon\ProductAdvertisingAPI\v1\com\amazon\paapi5\v1\api\DefaultApi`).
- **A trait** `Drupal\amazon_paapi\AmazonPaapiTrait` (`src/AmazonPaapiTrait.php`) with
  `getAmazonPaapi()` that lazily pulls the service — mix it into your own forms/controllers/services.
- **One config object** `amazon_paapi.settings` holding five string keys: `access_key`,
  `access_secret`, `host`, `region`, `partner_tag`. **No** `config/install` defaults and **no**
  `config/schema` ship with the module (the form writes the object at first save).
- **Env-var overrides**: each key can be sourced from `AMAZON_PAAPI_ACCESS_KEY`,
  `AMAZON_PAAPI_ACCESS_SECRET`, `AMAZON_PAAPI_HOST`, `AMAZON_PAAPI_REGION`,
  `AMAZON_PAAPI_PARTNER_TAG` — env wins over stored config (`AmazonPaapi::getSetting()`).
- **Two admin routes** (`amazon_paapi.routing.yml`), both `_permission: 'administer amazon paapi'`,
  both `_admin_route`, under `/admin/config/services/amazon-paapi/…`:
  - `amazon_paapi.settings_form` → `Form\SettingsForm` (`.../settings`) — the credential form.
  - `amazon_paapi.test_asin_form` → `Form\TestAsinForm` (`.../test-asin`) — live GetItems debug page.
- **One permission** `administer amazon paapi` (`restrict access: true`).
- **No** entities, plugins, plugin types, hooks (`.module` is empty), Drush, or blocks.

## Solution docs

- **The service, `getApi()`, the trait, credential resolution, env overrides, exception logging,
  and how to write your own GetItems/SearchItems request** →
  [api/service.md](api/service.md)
- **The settings form, the `amazon_paapi.settings` config object, the Test ASIN page, routes &
  permission** → [config/settings.md](config/settings.md)

## Notes

- Requests are **AWS SigV4-signed inside the SDK** using the configured access key + secret; the
  SDK forces the `https://` scheme on the configured host (`Configuration::setHost()`), and the
  module hands the SDK a default Guzzle `Client` (TLS verification at Guzzle defaults). The host is
  taken from **config**, not from request input.
- Credentials are stored/edited in the clear on the admin form; keep the `administer amazon paapi`
  permission restricted (it already sets `restrict access: true`) and prefer the env-var path for
  secret management.
