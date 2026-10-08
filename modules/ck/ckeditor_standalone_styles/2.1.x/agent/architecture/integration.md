<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integration: how styles reach the editor and survive filtering

The module has no routes of its own for output; it works entirely through four alter hooks
(`ckeditor_standalone_styles.module`) plus the helper service `CKEditorStylesHelper`.

## Helper service (`ckeditor_standalone_styles.helper`)

`CKEditorStylesHelper` (args: `entity_type.manager`, `module_handler`) loads all `ckeditor_style`
entities sorted by `weight` and produces two shapes:

- `generateStyleSetSettingData()` → CKE4 `stylesSet` array: `[{name, element, attributes.class}]`.
  Classes are split on newlines, trimmed, empties dropped; styles with no classes are skipped. Runs
  `hook_ckeditor_standalone_styles_alter(&$stylesSetConfig)` so other modules can alter the list.
- `generateStyleSetSettingsDataCkeditor5(array $allowedElements = NULL)` → CKE5 `[{name, element,
  classes[]}]`, optionally filtered to a whitelist of allowed element names.

## The four hooks

1. **`hook_ckeditor5_plugin_info_alter`** — swaps core's `ckeditor5_style` plugin class for
   `Plugin/CKEditor5Plugin/Style` (extends core `Style`). In `getDynamicPluginConfig()` it reads the
   editor's filter format `getHtmlRestrictions()`, takes the allowed element keys, and asks the helper for
   only those elements' style definitions — so the dropdown never offers a style for an element the format
   forbids. `getElementsSubset()` returns `<element class="...">` strings for the fundamental-compatibility
   machinery.
2. **`hook_editor_js_settings_alter`** — for CKE4-configured formats only (those with
   `editorSettings.stylesSet`), replaces `stylesSet` with the helper's data. CKE5 does not use this path.
3. **`hook_filter_info_alter`** — replaces core's `filter_html` class with `FilterHtmlCustom`.
4. **`hook_config_schema_info_alter`** — removes the `NotBlank` constraint on the core style plugin's
   `styles` mapping (so a format can be saved with no hardcoded styles) and removes the
   `CKEditor5FundamentalCompatibility` constraint on the format/editor pair (so a style for an element that
   isn't creatable by another enabled plugin doesn't block saving). The source itself flags the second as a
   broad relaxation of validation, not an ideal long-term fix.

## Allowed-HTML integration (`FilterHtmlCustom`)

Extends core `FilterHtml::getHTMLRestrictions()`. For each configured style it looks up the style's
`element` in the filter's `allowed` map and, **only if that element is already allowed**, adds each of the
style's classes to `allowed[element]['class']`. It never introduces a new element, and it respects an
existing `class => TRUE` (all-classes) wildcard. Effect: the CSS classes your styles use are whitelisted in
both the output filter and (because core syncs filter restrictions to CKEditor's ACF/GHS) the editor, so
the classes are not stripped on save or render — the module's headline behaviour over core.

This element-gating is the security-relevant boundary: a user who can create styles can add `class`
attributes to already-permitted elements, but cannot widen the set of allowed HTML elements or other
attributes through this module.
