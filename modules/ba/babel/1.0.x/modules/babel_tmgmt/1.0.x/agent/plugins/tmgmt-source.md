<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# babel_tmgmt — the 'babel' TMGMT source plugin & continuous jobs

## Source plugin `babel`
`Plugin\tmgmt\Source\BabelSource` (annotation `@SourcePlugin(id = "babel", ui = BabelSourceUi)`), implements
`ContinuousSourceInterface`. A TMGMT job item's `item_id` is a Babel source **hash**; item type is `default`.
- `getLabel($jobItem)` — reads `babel_source.sort_key` for the hash (parameterised query), trims trailing `:`.
- `getData($jobItem)` — loads the `StringTranslation` via `BabelStringsRepositoryInterface`, emits one TMGMT
  data element per plural variant. Placeholders matching `/([@!%][a-zA-Z0-9_-]+)/` are collected into each
  element's `#escape` so translators don't alter them. Target languages with more plural forms than the source
  are back-filled from the source's first plural variant.
- `BabelSourceUi` provides the TMGMT source overview/checkout UI.

## Settings / translator selection (`Hook\BabelTmgmtHooks`)
`babelTmgmtSettings()` (via `hook_form_babel_settings_form_alter`) adds a "TMGMT integration" details element
with a checkboxes list of available `tmgmt_translator` entities. The selected translator IDs are stored to
`babel_tmgmt.settings:translators` (schema: sequence of strings constrained `ConfigExists: tmgmt.translator.`)
using a `ConfigTarget` with `fromConfig`/`toConfig` transforms. **No provider credentials are handled here** —
TMGMT translator entities own the API endpoints/keys; Babel only records which translators to use.

## Continuous jobs (`hook_cron` + queue)
`BabelTmgmtHooks::cron()`:
1. Gets the `ContinuousJobItemCreationWorker` queue; if it still has items, returns (avoids duplicates).
2. For each continuous job (`ContinuousManager::getContinuousJobs('en')`): fetches all **untranslated, active,
   unlocked** string hashes for the job's target langcode (`stringsRepository->getStrings(translationStatus:
   FALSE, sourceStatus: TRUE, lockStatus: FALSE)`).
3. Deletes job items in dead-end states (aborted, in review); computes existing inactive job-item hashes via an
   aggregate query; enqueues `create` operations for the missing ones.

`ContinuousJobItemCreationWorker` processes the queue, calling
`BabelTmgmtIntegration::createContinuousJobItemForJob($job, $hash)` which skips disabled/locked strings,
removes any stale job item for the hash, and calls `ContinuousManager::addItem($job, 'babel', 'default', $hash)`
(TMGMT exceptions are logged, not fatal).

## Cleanup on state change (`EventSubscriber\BabelTmgmtSubscriber`)
- `SourceStringDisabled` → delete all `tmgmt_job_item`s with `plugin=babel, item_type=default, item_id=<hash>`.
- `TranslationLocked` → delete babel job items for the locked hash's target language.
This guarantees deactivated or manually-locked strings are not sent to (or left pending at) translators.

## Requirement
Needs `drupal/tmgmt` (declared `require-dev` in the project's composer.json; must be present to enable this
submodule). All DB access uses parameterised queries.
