<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel — storage, strings repository, locking, events, hooks

## Storage service — `BabelStorageInterface` (`BabelStorage`)
Owns the three index tables (`babel_source`, `babel_source_instance`, `babel_source_lock`). Tagged
`backend_overridable`. Key operations:
- `update(string $pluginId, Source[] $sources)` — upsert the index rows for a plugin's sources.
- `delete(string $pluginId, ?string $idPrefix = null)` / `delete(pluginId, ids)` — remove instances, then
  garbage-collect orphaned `babel_source` and `babel_source_lock` rows (parameterised `DELETE … WHERE hash
  IN (:hashes[])`).
- `getSourceStringInstances(string $hash): array` — `pluginId => [id, …]`; used when saving a translation to
  fan it out to every backend occurrence.
- `updateStatusForHash(hash, bool $status)`, `hashExists(hash)`, `getBaseQuery(pluginId)`.

## Strings repository — `BabelStringsRepositoryInterface` (`BabelStringsRepository`)
Aggregates strings across all translation-type plugins for the UI/export/TMGMT. Main method:
`getStrings(langcode, ?translationStatus, ?sourceStatus, ?lockStatus, search)` returning
`StringTranslation[]` keyed by hash. `translationStatus`/`sourceStatus`/`lockStatus` are tri-state
(`TRUE`/`FALSE`/`NULL`). `getStringTranslationByHash(langcode, hash)` fetches one.

## Lock service — `BabelLockServiceInterface` (`BabelLockService`)
`lock(hash, langcode)` / `unlock(hash, langcode)` manage `babel_source_lock`. Editing a translation in the
UI auto-locks it (or unlocks when cleared) — `BabelTranslateForm::updateTranslation`. Locking dispatches
`TranslationLocked`; unlocking `TranslationUnlocked`. Locked translations are excluded from export and from
TMGMT continuous jobs, so manual work is never overwritten by imports/automation.

## Events (`Drupal\babel\Event`)
- `SourceStringInserted`, `SourceStringEnabled`, `SourceStringDisabled` (extend `SourceStringStatusChangedBase`).
- `TranslationLocked`, `TranslationUnlocked` (extend `TranslationLockChangedBase`).
Each carries the source `hash` (and `langcode` for lock events). `babel_tmgmt` subscribes to
`SourceStringDisabled` and `TranslationLocked` to drop the matching TMGMT job items.

## Keeping the index in sync
- `EventSubscriber\ConfigSubscriber` (tagged `needs_destruction`) reacts to config CRUD and re-collects
  config translatables via `BabelConfigTranslatables` + `StringsCollectorFactory`.
- `EventSubscriber\LocaleSubscriber` reacts to locale source/translation changes.
- `StringsCollectorFactory` runs at destruction with priority `-20` (after the above), batching index writes.

## Hooks & theming (`Hook\BabelHooks`, legacy shims in `babel.module`)
- `hook_toolbar` — "Translate" toolbar tab → `babel.ui` modal (gated by `translate interface`).
- `hook_js_alter` — reordered after `locale_js_alter` via `hook_module_implements_alter`; adjusts JS
  translation data.
- `hook_theme` — registers the `pager` template (`templates/pager.html.twig`) used by the `pager_babel`
  render element (`Element\BabelPager`) with AJAX pager links (route `babel.ui_pager`, `Controller\UiPager`).
- Cache context `babel_translate_form_route` (`Cache\Context\BabelTranslateFormRoute`) — varies the toolbar
  tab so it is hidden while already on the translate form.
- Cache bin `cache.babel`, channel `logger.channel.babel`.

## API alter hooks (`babel.api.php`)
`hook_babel_translation_type_info(&$definitions)` and `hook_babel_data_transfer_info(&$definitions)` — alter
discovered plugin definitions (e.g. swap a plugin class).
