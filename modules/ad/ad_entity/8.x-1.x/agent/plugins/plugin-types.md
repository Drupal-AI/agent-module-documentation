<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: AdType, AdView, AdContext

`ad_entity` defines three annotation-based plugin types. Provider submodules implement AdType +
AdView; the parent ships only the two AdContext plugins.

## AdType — the ad provider/format

- Manager `AdTypeManager` (service `ad_entity.type_manager`), dir `Plugin/ad_entity/AdType`,
  interface `AdTypeInterface`, base `AdTypeBase`, annotation `@AdType` (`src/Annotation/AdType.php`).
- An AdType describes a provider (e.g. `dfp`, `adtech_factory`, `adtech_v2_factory`, `generic`).
  Contributes: `globalSettingsForm/Validate/Submit(Config)` (a tab on the global settings form) and
  `entityConfigForm/Validate/Submit(AdEntityInterface)` (per-ad settings, usually stored as the
  entity's third-party settings under the provider name).
- `AdTypeBase` provides no-op defaults and injects `string_translation`.

## AdView — the container / view handler

- Manager `AdViewManager` (service `ad_entity.view_manager`), dir `Plugin/ad_entity/AdView`,
  interface `AdViewInterface`, base `AdViewBase`, annotation `@AdView` (`src/Annotation/AdView.php`).
- Annotation fields observed in submodules: `id`, `label`, `library` (JS to attach),
  `requiresDomready` (bool; `FALSE` also pulls the built `ad_entity/viewready` library),
  `container` (`html` / `iframe` / `fia` / `amp`), `allowedTypes` (which AdType ids it serves).
- `build(AdEntityInterface): array` returns the inner render array (its own `#theme`).
  `entityConfigForm()` typically adds the `disable_initialization` checkbox and container-specific
  settings (iframe width/height, etc.).
- `ad_entity_library_info_build()` synthesizes a `viewready` library from AdView definitions whose
  `requiresDomready === FALSE`; `AdEntityUsage::getCurrentlyUsedAdViewPlugins()` decides which
  provider libraries/preload tags to attach on the current page.

## AdContext — targeting / behavior data

- Manager `AdContextManager` (service `ad_entity.context_manager`, implements
  `TrustedCallbackInterface`), dir `Plugin/ad_entity/AdContext`, interface `AdContextInterface`,
  base `AdContextBase`, annotation `@AdContext` (`src/Annotation/AdContext.php`).
- **In-repo plugins:** `targeting` (`TargetingContext`, library `ad_entity/targeting_context`) and
  `turnoff` (`TurnoffContext`, library `ad_entity/turnoff_context`).
- `AdContextBase::getJsonEncode()/getJsonDecode()` (`JSON_HEX_*` flags). `TargetingContext`
  overrides `getJsonEncode()` to run `TargetingCollection::filter()` first, and implements
  `settingsForm()`/`massageSettings()` to turn `pos: top, category: a` user input into a collection.
- The **manager** collects backend context data during rendering: `addContextData()`,
  `getContextDataForEntity()`, `collectContextDataFrom(FieldableEntity)`, and the reset/restore
  cycle (`resetContextDataForEntity/Route()`, `resetToPreviousContextData()`,
  `postRenderResetToPreviousContextData()` — the only trusted post-render callback). `hook_entity_prepare_view`
  / `hook_entity_view` in `ad_entity.module` drive the per-entity reset so an ad shown on an entity
  page only inherits that entity's context.

## Writing a provider (sketch)

1. New module depending on `ad_entity`.
2. An `@AdType` plugin in `Plugin/ad_entity/AdType/` with the provider's per-ad settings.
3. One or more `@AdView` plugins in `Plugin/ad_entity/AdView/` (`container`, `allowedTypes`,
   optional `library`) whose `build()` returns the ad-tag render array + a `hook_theme` template.
4. Optionally `hook_ad_entity_module_info()` to declare `personalization` / `consent_aware`, and
   `hook_config_schema_info_alter()` + `hook_page_attachments()` to add global settings and load
   the provider's external JS.
