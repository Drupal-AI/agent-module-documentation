<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Heading Size (ckeditor_heading_size) — agent index

A CKEditor 5 plugin that lets an editor set a **font size on a heading** by applying a **CSS class**
to the correctly-nested heading (e.g. `h2.heading-size-24px`) — it does **not** change the tag and
does **not** write an inline `style="font-size:…"`. Package `Custom`. Depends on core **`ckeditor5`**.
Core requirement `^9 || ^10 || ^11` (composer.json requires core `^10.4.0 || ^11`). License
GPL-2.0-or-later. Version 1.0.6.

- **Install/enable, adding it to a format, settings keys, exact markup, and the allowed-HTML
  override** → [ckeditor5/heading-size.md](ckeditor5/heading-size.md)

## What it actually is

- A CKEditor 5 plugin registered in `ckeditor_heading_size.ckeditor5.yml` as
  `ckeditor_heading_size_plugin`: CKEditor5 plugin **`ckeditorHeadingSize.HeadingSize`**, Drupal
  label **"Heading Size"**, library `ckeditor_heading_size/plugin`, `elements: false`.
- **There is no toolbar button.** The plugin has no `toolbar_items`; its only
  `conditions` is `plugins: [ckeditor5_heading]`, so it is enabled automatically on any text
  format whose CKEditor 5 has the core **Heading** dropdown enabled. The size control appears as a
  **contextual balloon** when the editor clicks a heading.
- No permissions, no Drush, no submodules. Provides one settings form and one config-override
  service.

## JS plugin (`js/ckeditor5_plugins/ckeditorHeadingSize/src/`)

- `index.js` exports `{ HeadingSize }`; `headingsize.js` is the `HeadingSize` plugin, requiring
  `HeadingSizeUi` and `HeadingSizeEditing`. Built to `js/build/ckeditorHeadingSize.js`.
- `headingsizeediting.js` — for each `heading.*` model, `schema.extend(..., {allowAttributes:
  'fontSize'})`; **upcast** maps a heading's size class → model `fontSize`; **downcast** maps
  `fontSize` → the `class` attribute on the view element. So the size is a **class**, chosen from
  `editor.config.get('headingSizes')`.
- `headingsizeui.js` — on click over a heading (`getSelectedHeadingElement()`), opens a
  `ContextualBalloon` with a `LabeledFieldView` dropdown built from `headingSizes`; selecting a
  size does `writer.setAttribute('fontSize', headingSizes[value], block)`. Requires the core
  `HeadingUI` plugin to be enabled.
- `utils/symbolshims.js` shims `ViewModel` for older CKEditor 5 versions.

## Where `headingSizes` and the CSS come from (`ckeditor_heading_size.module`)

- `hook_ckeditor5_plugin_info_alter()` reads config `ckeditor_heading_size.settings` and builds
  `ckeditor5.config.headingSizes` as `{ label: className }`. `className` comes from
  `_get_size_class_name()`: in **`sizes`** mode → `heading-size-<size>` (constant
  `HEADING_SIZE_CLASS = 'heading-size'`); in **`classes`** mode → the value after `|` in each
  `label|class` option.
- `hook_preprocess_html()` — only in **`sizes`** mode — emits a `<style>` in `html_head` with a
  rule `h2.heading-size-24px { font-size: 24px [!important]; }` for every enabled heading tag ×
  size, honoring the `important` and `extra_specificity` settings. In `classes` mode the theme
  supplies the CSS.
- `_get_enabled_heading_tags()` reads the core `ckeditor5_heading` plugin's `heading.options` and
  returns the view tags (`h2`, `h3`, …) that are actually enabled.

## Settings form & config

- `SettingsForm` (`src/Form/SettingsForm.php`, `ConfigFormBase`) at route
  `ckeditor_heading_size.settings_form` → **`/admin/config/content/ckeditor-heading-size`**,
  permission **`administer filters`** (menu link under *Configuration → Content* via
  `.links.menu.yml`). Fields: `type` (radios `sizes`/`classes`, AJAX-refreshed), `size_options`
  (textarea, one per line), `important` (checkbox), `extra_specificity` (textfield).
- Config object **`ckeditor_heading_size.settings`** — install defaults (`config/install/`):
  `size_options` = `14px 16px 18px 20px 24px 28px 32px 40px 48px`, `type: sizes`. Schema
  (`config/schema/`) declares `size_options` (sequence of strings) and `type` (string) — note it
  does **not** declare `important` or `extra_specificity`, though the form saves them.

## The allowed-HTML override (`src/Config/AllowedHtmlOverride.php`)

- Service `ckeditor_heading_size.allowed_html_override`, a `config.factory.override` (priority 5).
  For each `filter.format.*` config with a `filter_html` filter, it parses the `allowed_html`
  string, finds the enabled heading tags, and **adds the specific `heading-size-*` (or theme)
  class tokens to those tags' allowed `class` list** — appending to an existing `class="…"` spec or
  adding one — so an editor's chosen size class is not stripped by the filter. It only ever touches
  the `class` attribute of heading tags (never `style`, never a wildcard). Skips work until
  `install_task === 'done'` and guards against recursion with `loadingOverrides`.

## Notes

- Only affects formats that (a) use CKEditor 5 with the **Heading** dropdown enabled and (b) have
  `filter_html` (for the class to survive filtering). No Heading dropdown → the control never shows.
- The `important` / `extra_specificity` settings exist to defeat theme rules; they have no config
  schema entry (expect a schema-validation notice).
