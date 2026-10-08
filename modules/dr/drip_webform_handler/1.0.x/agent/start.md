<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drip webform handler (drip_webform_handler) — agent index

A single **Webform handler plugin** that posts each Webform submission to **Drip.com** as a
subscriber record. Package `Webform`. Core requirement `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Installed version 1.0.2 (version dir 1.0.x).

- **The handler plugin, its config-form fields, the Drip API call, and field mapping** →
  [plugins/drip_webform_handler.md](plugins/drip_webform_handler.md)

## What it actually is

- One plugin: `DripWebformHandler` (`@WebformHandler` id **`drip_webform_handler`**, label
  *"Drip.com Webform Handler"*, category *Transaction*), in
  `src/Plugin/WebformHandler/DripWebformHandler.php`, extending webform's `WebformHandlerBase`.
  Cardinality **unlimited**, `RESULTS_PROCESSED`, `SUBMISSION_OPTIONAL`.
- It is **not** a new plugin type, field, formatter, block or route — it is one instance of
  Webform's own handler plugin type, added per-webform.

## Dependencies

- Drupal module: **`webform:webform`** (`^5.16 || ^6`).
- Composer PHP library: **`drewm/drip` `^0.9.0`** — the `DrewM\Drip\Drip` REST client and
  `DrewM\Drip\Dataset` are what actually talk to the Drip API. Must be installed via Composer.

## What it provides / does not

- **No** `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `*.install`, `*.module`,
  `config/install/*` or `config/schema/*` — the module ships only the info file, README and the
  one plugin class. So: **no permissions, no Drush, no config schema, no settings route.**
- All configuration lives in the **handler settings** stored on the host webform's config entity
  (edited at *Structure → Webforms → [form] → Settings → Emails/Handlers*). Requires the core
  *administer webform* / webform-edit permissions to configure.

## Mechanism (from source)

- `buildConfigurationForm()` renders an *API settings* fieldset: `api_key`, `account_id`,
  `tags`, `eu_consent` (select granted/denied/unknown), plus one select per Drip subscriber field
  mapping a webform element onto it.
- `submitForm()` reads `$webform_submission->getData()`, constructs
  `new Drip($api_key, $account_id)`, builds a `subscribers` `Dataset` from the tags, consent and
  mapped values, and calls `$client->post('subscribers', $dataset)` (drewm/drip → Guzzle HTTPS to
  Drip's REST API). A thrown `GuzzleHttp\Exception\RequestException` is caught and ignored.
- Mappable webform elements are limited to `textfield` and `email` types
  (`getMappingOptions()`); the Drip target properties come from `getSubscriberFields()`.

See [plugins/drip_webform_handler.md](plugins/drip_webform_handler.md) for the full field list,
config keys and how to attach the handler.
