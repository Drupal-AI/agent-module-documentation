<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Translate — services, stores, hooks, entity

Services are declared in `canvas_translate.services.yml` (`autowire: true`, all `public: true`).

## Draft & approval stores (the core design choice)

- `canvas_translate.draft_store` / `canvas_translate.approval_store` are keyvalue collections
  (`canvas_translate.drafts` / `canvas_translate.approvals`) built via the `keyvalue` factory.
- `TranslationDraftStore` (`src/Service/TranslationDraftStore.php`) wraps the draft collection. A
  draft is a flat map of dotted row key → target string (e.g. `title`, `components.0.text`,
  `component_tree.<uuid>.label`). Keys are `"{subject}:{langcode}"`; subject is
  `"{entity_type}:{id}"` for pages (`contentSubject()`) or the config dependency name for layouts.
  `allKeys()` returns all keys for O(1) status lookups and prefix cleanup.
- **Why a private store, not Canvas auto-save:** Canvas's publish flow (`ApiAutoSaveController::post`)
  publishes *every* pending auto-save of an entity, with no per-entry opt-out — so a draft in that
  store would go live the moment someone publishes the default-language content. Keeping drafts here
  isolates translators from Canvas's "publish all". (The class docblock records the exact upstream
  change that would let it fold back into `AutoSaveManager`.)
- `ApprovalStore` (`src/Service/ApprovalStore.php`) is a parallel flag store keyed identically. An
  approval is cleared whenever its draft changes, is discarded, or is published, so it always refers
  to the exact reviewed draft.

## Translatable-string glue

- `TranslatableFieldGlue` (`src/Service/TranslatableFieldGlue.php`) extracts (`extractTranslatableData()`)
  and writes back (`applyValuesToComponents()` / `setTranslations()`) translatable strings of a
  `component_tree` field. It's a tmgmt-free **fork** of Canvas's `ComponentTreeFieldProcessor`
  (which `extends` a tmgmt_content class and can't load without tmgmt); it delegates the real work to
  Canvas's `ComponentInputsTranslatablesExtractor` + `TypedConfigManager`. Only translatable leaves
  are written — structure is preserved, so applying an old draft never regresses a newer layout.
- `ConfigTranslatableGlue` (`src/Service/ConfigTranslatableGlue.php`) is the config-path counterpart.
  Config "translations" are **language config overrides** (`language.config.<lc>.*`), not entity
  translations. It enumerates a ContentTemplate / PageRegion's `component_tree` strings
  (`sourceStringsByKey()`), stages edits as a draft (`save()`), and on `publish()` writes them into
  the live `LanguageConfigOverride` (via `@language.config_factory_override`) — the active source
  config is never touched. Reads overlay a pending draft onto the live override.

## Status

- `TranslationStatus` (`src/Service/TranslationStatus.php`) computes per-language status from three
  cheap sources joined in memory: existing translations, core's `content_translation_outdated`, and
  the draft store. Status constants: `source`, `not_translated`, `draft`, `up_to_date`, `outdated`.
  Precedence: draft > outdated > up_to_date.

## Hooks (`src/Hook/`, `#[Hook(...)]` attribute classes)

- `OutdatedFlagHooks` — `entity_presave` on a `canvas_page`: if the source translation's
  *translatable* strings changed (compared via an `xxh64` source hash), set
  `content_translation_outdated = TRUE` on every translation. This replaces the manual "flag other
  translations as outdated" checkbox that the Canvas editor never surfaces. Non-translatable field
  changes do NOT flag.
- `DraftCleanupHooks` — `entity_delete` on a Page or `ComponentTreeConfigEntityBase`: deletes every
  language-scoped draft for the deleted entity (prefix match), including draft-only languages.
- `RequirementsHooks` — `runtime_requirements`: reports when page translation isn't enabled (would
  overwrite the source). Error once the site is multilingual, otherwise a warning.
- `canvas_translate.install` `hook_requirements` — blocks install (and warns at runtime) when
  `canvas_multilingual` is present; the two provide competing Canvas translation workflows.

## Config baseline entity

- `ConfigBaseline` (`src/Entity/ConfigBaseline.php`, id `canvas_translate_baseline`, config prefix
  `baseline`) snapshots the published source strings a config override was last reviewed against.
  It's a **config** entity (not keyvalue) on purpose: it exports with the site, so after a deploy an
  override doesn't falsely read up-to-date. ID is `"{langcode}.{config_name}"`; a config dependency
  on `{config_name}` removes it automatically when the layout is deleted. Schema:
  `config/schema/canvas_translate.schema.yml` (`canvas_translate.baseline.*`, a `source` sequence of
  `{key, text}` pairs — a LIST because row keys contain dots that config object keys can't).

## Routing & extension

- `TranslateRouteSubscriber` (`src/Routing/`) alters `entity.canvas_page.content_translation_overview`
  to `TranslateRedirectController::overview()` (runs at priority -220, after content_translation), so
  the "Translate" task opens the extension; access checks are unchanged. The controller redirects to
  `canvas.boot.app` with `extension_id=canvas_translate`.
- `PreviewController::preview()` renders the target (with the in-memory draft applied) through the
  entity view builder + `bare_html_page_renderer` (content + component assets, no site chrome),
  `max-age = 0`. Rendering goes through Drupal's normal render pipeline (proper escaping); nothing is
  persisted.
- The UI is a bundled React SPA under `extension/` (tsup build; `extension/dist/`), registered by
  `canvas_translate.canvas_extension.yml` as a `page` extension requiring `translate canvas content`.
