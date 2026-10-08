<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Translation Unified Form (entity_translation_unified_form) — agent index

Injects **every enabled language's translatable field widgets into the normal entity add/edit
form** so all translations are created/saved in one submission. Package `Multilingual`. Depends on
core **`content_translation`**. Core requirement `^11.3 || ^12` (composer allows `^10 || ^11 || ^12`).
License GPL-2.0-or-later. Version 2.0.17 (dir `2.0.x`). Configured from
`language.content_settings_page` (`/admin/config/regional/content-language`).

- **All settings** (content-language page + node-type form, the per-bundle setting keys, display
  modes, save-only, replace-node-edit) → [config/settings.md](config/settings.md)
- **How the unified form is built and how each translation is saved** (form_alter injection,
  field cloning, submit/preview/post-save handlers, moderation/revision/menu/pathauto/file/metatag
  handling, route replacement) → [architecture/form-build-save.md](architecture/form-build-save.md)
- **The `EntityTranslationUnifiedFormMode` plugin type** (Inline vs Tabbed, adding a mode, theme
  wrappers, libraries) → [plugins/form-modes.md](plugins/form-modes.md)

## What it actually is

- **No routes, no permissions, no config schema of its own.** All per-bundle settings are stored
  inside core Content Translation's *bundle translation settings*
  (`ContentTranslationManagerInterface::setBundleTranslationSettings()`), not in a config object.
  There is a `composer.json` `extra.drush.services` reference but **no `drush.services.yml` ships**,
  so no Drush commands.
- **Plugin type it provides:** `EntityTranslationUnifiedFormMode` — manager
  `plugin.manager.entity_translation_unified_form_mode`
  (`EntityTranslationUnifiedFormModePluginManager`), annotation
  `Annotation\EntityTranslationUnifiedFormMode`, interface
  `EntityTranslationUnifiedFormModeInterface`. Two plugins ship:
  `EntityTranslationUnifiedFormInlineMode` (default) and `EntityTranslationUnifiedFormTabbedMode`.
- **Services** (`*.services.yml`): the plugin manager above; `RouteSubscriber`
  (`Routing\RouteSubscriber`, event_subscriber); and two autowired hook classes
  `Hook\EntityTranslationUnifiedFormHooks` and `Hook\EntityTranslationUnifiedFormThemeHooks`
  (OOP hooks, with `#[LegacyHook]` procedural shims in the `.module`/`.theme.inc`).
- **Controller:** `Controller\ReplacementNodeEditController::getReplacementNodeEditPage()` — used
  only when the per-bundle "Replace node edit" option is on; `RouteSubscriber` then repoints the
  core `entity.node.edit_form` route's `_controller` at it (route access requirement is untouched).
- **Helper:** `EtufHelper` — static helpers (`getOtherTranslationLanguages`,
  `getOtherEnabledLanguages`, `getEtufFieldName($field, $langcode)` → `"{field}-etuf-{langcode}"`,
  menu-link auto-translate, logging).

## Mechanism in one paragraph (from source)

`EntityTranslationUnifiedFormHooks::formAlter()` runs late (moved to the end of `form_alter` by
`hook_module_implements_alter`) on any `EntityForm` whose bundle has ETUF enabled. It calls
`entity_translation_unified_form_add_fields()`, which for each translatable, non-hidden field
clones the widget for every *other* enabled language (via `EntityFormDisplay::getRenderer()`),
renames it `{field}-etuf-{langcode}`, and places it under `$form[$field_name][$langcode]`. It
splices `entity_translation_unified_form_node_form_submit` before core `::save` and
`entity_translation_unified_form_node_form_post_save` after it. On submit, that handler loops
`EtufHelper::getOtherTranslationLanguages()`, does `getTranslation()/addTranslation()` per language
and `->set($field, $values["{field}-etuf-{lang}"])`, so the single entity save writes all
enabled translations at once. Post-save handling covers moderation/revision/menu/pathauto — see the
architecture doc.

## Display modes / theming

- `hook_theme()` registers four wrappers: `…__inline__wrapper`, `…__inline__field_wrapper`,
  `…__a11y_accordion_tabs__wrapper`, `…__a11y_accordion_tabs__field_wrapper` (templates in
  `templates/`, preprocess in `EntityTranslationUnifiedFormThemeHooks` / `.theme.inc`).
- `hook_page_attachments()` attaches per-theme CSS libraries (`etuf`, `etuf-seven`,
  `etuf-business`, `ten-one-*-claro`) and JS (`etuf-moderation-sync` = `js/sync.js`,
  `etuf_preview` = `js/etuf_preview.js`) only on `/node/add/*` and `/node/*/edit`.
- `hook_library_info_alter()` strips `node/drupal.node.preview`'s JS.
- Tabbed mode needs the external **A11Y Accordion Tabs** JS at `/libraries/a11y-accordion-tabs/`
  (see README).
