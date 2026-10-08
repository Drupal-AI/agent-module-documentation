<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `EntityTranslationUnifiedFormMode` plugin type (display modes)

ETUF provides one plugin type that controls **how** the cloned per-language fields are laid out and
labelled. The chosen plugin id is stored per bundle in the `entity_translation_unified_form_theme`
bundle-translation setting (see [../config/settings.md](../config/settings.md)).

## The plugin type

- **Manager:** `EntityTranslationUnifiedFormModePluginManager`, service
  `plugin.manager.entity_translation_unified_form_mode` (parent `default_plugin_manager`). Discovers
  `Plugin/EntityTranslationUnifiedFormMode/*`, caches under `entity_translation_unified_form_plugins`.
- **Annotation:** `Annotation\EntityTranslationUnifiedFormMode` — properties `id` and `admin_label`
  (a `@Translation`). (Annotation-based discovery; no PHP attribute variant.)
- **Interface:** `EntityTranslationUnifiedFormModeInterface`, three methods:
  - `fieldFormAlter($form, $form_state, &$field, $field_name, $language)` — alter a built field.
  - `getFieldGroupThemeWrapper($form, $form_state, $field, $field_name)` — wrapper for the group of
    all languages of one field.
  - `getFieldThemeWrapper($form, $form_state, $field, $field_name, $language)` — wrapper for one
    language's field.
- **Lookup helpers** (`.module`): `entity_translation_unified_form_get_mode_options()` (id →
  `admin_label`, used to populate the settings select) and
  `entity_translation_unified_form_get_mode_plugin($id)` (instantiate by id).

## Shipped plugins

### `EntityTranslationUnifiedFormInlineMode` (default)

`Plugin/EntityTranslationUnifiedFormMode/EntityTranslationUnifiedFormInlineMode.php`.
- `fieldFormAlter()` → `alterTitle()`: appends the language to each widget `#title`
  (`Title (English)` / native name / `(fr)` depending on the `…_language` setting) by recursively
  walking FAPI title elements (`addTranslatabilityClue()`).
- Theme wrappers: `entity_translation_unified_form__inline__wrapper` (group) and
  `…__inline__field_wrapper` (per field). Each other-language field renders **after** the source
  field.

### `EntityTranslationUnifiedFormTabbedMode`

`…/EntityTranslationUnifiedFormTabbedMode.php`, **extends** the Inline plugin.
- Uses wrappers `…__a11y_accordion_tabs__wrapper` / `…__a11y_accordion_tabs__field_wrapper` (falls
  back to the inline wrappers for the `path` field, which "doesn't work well with tabs").
- `fieldFormAlter()` only adds the language-title suffix for the `path` field; the rest is presented
  as accordion tabs.
- Requires the external **A11Y Accordion Tabs** JS library at `/libraries/a11y-accordion-tabs/`
  (library `a11y-accordion-tabs`, attached by
  `EntityTranslationUnifiedFormThemeHooks::templatePreprocess…A11yAccordionTabsWrapper()`). Adapted
  from the *A11Y Paragraphs Tabs* module. See the README for install (manual or composer
  drupal-library) and the note that side-by-side forces Inline mode.

## Theme wrappers & preprocess

`hook_theme()` registers the four wrappers (render element `element`, implemented in
`entity_translation_unified_form.theme.inc`). `EntityTranslationUnifiedFormThemeHooks` (autowired,
OOP `#[Hook('preprocess_…')]`) preprocesses them; the a11y-accordion-tabs wrapper builds a `fields`
variable keyed by element id carrying `language_name`, `label`, and pre-rendered `markup` for each
language, and attaches the accordion library. Templates live in `templates/`.

## Adding a custom mode

Copy one of the shipped plugin classes into your module's
`src/Plugin/EntityTranslationUnifiedFormMode/`, give it a unique annotation `id` + `admin_label`,
implement (or extend Inline and override) the three interface methods, add any templates via your
own `hook_theme`, and clear caches. It then appears in the *inline display mode* select on the
content-language settings form. (README: "copy and extend a class from
`src/Plugin/EntityTranslationUnifiedFormMode`".)

## Front-end libraries (`*.libraries.yml`)

`a11y-accordion-tabs` (tabbed mode), `etuf` / `etuf-seven` / `etuf-business` /
`ten-one-sbs-claro` / `ten-one-inline-claro` (per-theme side-by-side & inline CSS),
`etuf-moderation-sync` (`js/sync.js`), `etuf_preview` (`js/etuf_preview.js`). Attached only on
`/node/add/*` and `/node/*/edit` by `hook_page_attachments()`, theme-selected there.
