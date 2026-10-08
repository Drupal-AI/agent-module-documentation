<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel TMGMT (babel_tmgmt) — agent index

Babel submodule. Depends on **babel** and **tmgmt** (`drupal/tmgmt`, dev-required by the project).
Core `^10.4 || ^11.1 || ^12`.

Bridges Babel's curated source strings to TMGMT translation providers, including continuous jobs. TMGMT owns
translator connections/credentials; this module stores only the enabled translator IDs.

## Provides
- **TMGMT source plugin `babel`** — `Plugin\tmgmt\Source\BabelSource` (implements `ContinuousSourceInterface`),
  UI `Plugin\tmgmt\Source\BabelSourceUi`. Item type `default`; item id = Babel source hash. `getData()`
  returns per-plural-variant source text with placeholder escaping; `getLabel()` reads `babel_source.sort_key`.
- **Config** `babel_tmgmt.settings` — `translators` (sequence of `tmgmt.translator.*` IDs). Added to the Babel
  settings form by `Hook\BabelTmgmtHooks::babelTmgmtSettings` (checkboxes of available TMGMT translators).
- **Continuous jobs**: `Hook\BabelTmgmtHooks::cron` (`hook_cron`) enqueues creation of missing job items for
  every untranslated, active, unlocked string per continuous job; `Plugin\QueueWorker\ContinuousJobItemCreationWorker`
  creates them; `BabelTmgmtIntegration::createContinuousJobItemForJob()` / `deleteContinuousJobItems()`.
- **Event subscriber** `EventSubscriber\BabelTmgmtSubscriber` — on `SourceStringDisabled` and
  `TranslationLocked`, deletes the matching `tmgmt_job_item`s so locked/disabled strings are not (re)sent.

## Solution docs
- `agent/plugins/tmgmt-source.md` — the source plugin, settings, continuous-job flow, credential handling.
