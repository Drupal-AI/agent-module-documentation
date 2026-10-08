<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GlobalLink Connect for Drupal (globallink) — agent index

A **TMGMT translator plugin** that submits Drupal translation jobs to **GlobalLink Project
Director** (translations.com) over its **SOAP API** and imports the completed XLIFF back. Package
*Translation Management*. Version **8.x-2.7** (doc dir `8.x-2.x`). Core `^8.8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later.

- **Dependencies:** Drupal modules `tmgmt` and `tmgmt_file`; Composer library
  `translations-com/globallink-connect-api-php` (pinned **4.18.6**); PHP **`ext-soap`** (enforced by
  `globallink_requirements()` in `globallink.install`).
- **No routes, no permissions, no config entities of its own** — it plugs into TMGMT's translator
  UI. `info.yml` declares `configure: globallink.admin` but the module ships **no routing.yml**, so
  configuration happens on the TMGMT translator add/edit form.

## Solution docs

- **Translator settings, config schema, the config form and its live validation** →
  [config/settings.md](config/settings.md)
- **The translator plugin, the SOAP adapter, job submission/retrieval, cron, continuous filters,
  email hook** → [plugins/translator.md](plugins/translator.md)

## What it provides (from source)

- **`GlobalLinkTranslator`** — the TMGMT translator plugin (`@TranslatorPlugin` id **`globallink`**,
  UI class `GlobalLinkTranslatorUi`), `src/Plugin/tmgmt/Translator/GlobalLinkTranslator.php`.
  Implements `ContinuousTranslatorInterface` and (BC-guarded) `MultipleCheckoutInterface`.
- **`GlExchangeAdapter`** — service `globallink.gl_exchange_adapter`, builds the vendor
  `\PDConfig` / `\GLExchange` / `\PDDocument` / `\PDSubmission` objects; `src/GlExchangeAdapter.php`.
- **`GlobalLinkTranslatorUi`** — config form, checkout settings form, continuous-filter form, the
  "Pull translations" action; `src/GlobalLinkTranslatorUi.php`.
- **`GloballinkContinuousEvents`** — event subscriber `globallink.should_create_job`, on TMGMT
  `ContinuousEvents::SHOULD_CREATE_JOB`, applies URL/id exclusion filters;
  `src/EventSubscriber/GloballinkContinuousEvents.php`.
- **Hooks** in `globallink.module`: `hook_cron()` (auto-pull completed translations),
  `hook_tmgmt_message_insert()` (email notify), `hook_mail()`, `hook_theme()`
  (`globallink_comments`). `hook_requirements()` in `globallink.install` checks `ext-soap`.
- **Config schema** `tmgmt.translator.settings.globallink` in `config/schema/globallink.schema.yml`
  (extends `tmgmt.translator_base`). Provides config schema; **no permissions, no Drush, no new
  plugin types**.

## How it works, in one line

An admin adds a "GlobalLink" TMGMT translator with API URL / username / password / project id /
classifier. On job request the plugin exports the job to XLIFF (`tmgmt_file` `xlf` format), opens a
GlobalLink submission via SOAP, uploads the document(s), and records a TMGMT remote mapping. Cron
(or the "Pull translations" button) downloads completed targets, imports the translated XLIFF, and
confirms the download back to GlobalLink.
