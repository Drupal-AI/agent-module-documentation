<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blackbird Translator (tmgmt_blackbird) — agent index

A TMGMT translator plugin for the **Blackbird** content-orchestration platform. Package `Translation
Management`. Depends on **`tmgmt`** and **`tmgmt_file`**. Core `^8.8 || ^9 || ^10 || ^11`, PHP `7.1+`.
License GPL-2.0-or-later. Version 1.1.1. Configure route: `entity.tmgmt_translator.collection`
(`/admin/tmgmt/translators`).

- **The translator plugin, its API key, and the config/schema** → [config/translator.md](config/translator.md)
- **The `/api/tmgmt/blackbird/*` REST endpoints Blackbird polls** → [api/endpoints.md](api/endpoints.md)

## What it actually is

- A **pull-based** connector. The module never calls Blackbird. When an editor submits a TMGMT job to
  the `blackbird` translator, the job is left `unprocessed` with a `blackbird_awaiting_acceptance`
  setting flag; Blackbird (holding the translator's API key) polls Drupal to fetch and complete it.
- One TMGMT translator plugin: `BlackbirdTranslator` (id **`blackbird`**, label *"Blackbird"*), in
  `src/Plugin/tmgmt/Translator/BlackbirdTranslator.php`, extending `TmgmtPluginBase`
  (`TranslatorPluginBase`) and implementing `MultipleCheckoutInterface`. `map_remote_languages = FALSE`,
  `ui = BlackbirdTranslatorUi`, `logo = icons/blackbird.svg`.
- One UI class: `BlackbirdTranslatorUi` (`src/BlackbirdTranslatorUi.php`, extends
  `TranslatorPluginUiBase`) — renders the API-key field + "Generate new API key" AJAX button, and the
  per-job checkout note display.
- One service + controller: `tmgmt_blackbird.api` → `Drupal\tmgmt_blackbird\Rest\BlackbirdApi`
  (`src/Rest/BlackbirdApi.php`), wired in `tmgmt_blackbird.services.yml` with `@request_stack`,
  `@entity_type.manager`, `@language_manager`, `@plugin.manager.tmgmt_file.format`,
  `@page_cache_kill_switch`.
- A compatibility shim: `src/Compatibility/MultipleCheckoutInterface.php`, `class_alias`-ed to
  `Drupal\tmgmt\MultipleCheckoutInterface` when that interface is absent in older TMGMT.
- **No** permissions, **no** Drush, **no** new plugin types, **no** hooks, **no** install file. Config
  schema only (`config/schema/tmgmt_blackbird.schema.yml`).

## Mechanism (from source)

- `requestTranslation()` / `requestTranslationMultiple()` set `settings.blackbird_awaiting_acceptance =
  TRUE` and force the job to `STATE_UNPROCESSED`. Multiple checkout produces one job per target
  language (no batch ID).
- All six routes (`tmgmt_blackbird.routing.yml`) declare `_access: 'TRUE'`; real authentication happens
  in the controller. `getTranslatorForRequest()` reads the `x-api-key` header and compares it to each
  `blackbird` translator's stored `api_key` with `hash_equals` (constant-time); `requireTranslator()`
  first calls `page_cache_kill_switch->trigger()` so responses are never cached across keys.
- Job HTML export/import goes through TMGMT File's `html` format (`@plugin.manager.tmgmt_file.format`).

## Entities / routes provided

- No content or config entities of its own. Operates on core TMGMT `tmgmt_job` and `tmgmt_translator`
  entities.
- Routes (all under `/api/tmgmt/blackbird`): `languages` (GET), `jobs` (GET), `job/{tmgmt_job}`
  (GET|POST), `job/{tmgmt_job}/accept` (POST), `job/{tmgmt_job}/note` (GET|POST),
  `job/{tmgmt_job}/reject` (POST). Full request/response contract in [api/endpoints.md](api/endpoints.md).
