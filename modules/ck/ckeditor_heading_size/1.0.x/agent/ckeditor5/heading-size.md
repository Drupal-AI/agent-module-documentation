<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Heading size control (CKEditor 5)

Give editors a font size for headings that varies the **appearance** while keeping the correct
heading **level**. The size is stored as a CSS **class** on the heading (e.g.
`h2.heading-size-24px`), never as an inline `style` and never by changing the tag.

## Install & enable

```
composer require drupal/ckeditor_heading_size
drush en ckeditor_heading_size -y
```

Depends on core `ckeditor5` (info.yml `dependencies: drupal:ckeditor5`).

## Add it to a text format

There is **no toolbar button to drag**. The plugin (`ckeditor_heading_size.ckeditor5.yml`) declares
`conditions: plugins: [ckeditor5_heading]` and no `toolbar_items`, so it turns on automatically for
any format whose CKEditor 5 has the core **Heading** dropdown enabled.

1. *Structure → Text formats and editors* (`/admin/config/content/formats`) → edit a
   CKEditor 5 format.
2. Make sure the **Heading** item is in the *Active toolbar* (this is core's `ckeditor5_heading`).
3. Save. In that editor, **click a heading** — a contextual balloon appears with a dropdown of the
   configured sizes. Picking one applies the size class to the heading.

For the class to survive text filtering the format should include the **Limit allowed HTML tags**
(`filter_html`) filter — the module's override then whitelists the size classes on heading tags
automatically (see below). A format with no `filter_html` (unrestricted) needs no whitelisting.

## Configure the sizes

Settings form at **`/admin/config/content/ckeditor-heading-size`** (route
`ckeditor_heading_size.settings_form`, permission **`administer filters`**; menu link under
*Configuration → Content*). It writes config object **`ckeditor_heading_size.settings`**:

- **`type`** (`sizes` | `classes`) — the mode. Toggling it via AJAX clears the textarea.
- **`size_options`** — a sequence of strings, one per line in the textarea.
  - In **`sizes`** mode each line is a literal font size (`24px`, `1.5em`). The editor label is the
    size itself and the class becomes `heading-size-<size>` (`_get_size_class_name()` +
    `HEADING_SIZE_CLASS = 'heading-size'`).
  - In **`classes`** mode each line is `Label|theme-class` (e.g. `My H2 Style|my-h2-style`); the
    label is shown to the editor and `theme-class` is the class applied. The value after `|` is used
    verbatim.
- **`important`** (checkbox) and **`extra_specificity`** (textfield) — only used in `sizes` mode,
  to strengthen the generated CSS (see next section). These two keys are saved by
  `SettingsForm::submitForm()` but are **not** in `config/schema/ckeditor_heading_size.schema.yml`
  (which only declares `size_options` and `type`), so expect a schema-validation notice.

Install defaults (`config/install/ckeditor_heading_size.settings.yml`): `type: sizes`,
`size_options: [14px, 16px, 18px, 20px, 24px, 28px, 32px, 40px, 48px]`.

Example export:

```yaml
# ckeditor_heading_size.settings.yml
type: sizes
size_options:
  - 16px
  - 24px
  - 48px
important: true
extra_specificity: '.main-container'
```

## What markup it produces, and how the size is rendered

- **In the content** the heading gets a plain class, e.g. `<h2 class="heading-size-24px">…</h2>`.
  This is the CKEditor 5 model `fontSize` attribute downcast to a `class`
  (`headingsizeediting.js` — `editor.conversion.for('downcast').attributeToAttribute({ model:
  'fontSize', view: … key:'class' })`; upcast maps a known size class back to `fontSize`).
  No inline `style` attribute is written.
- **The actual `font-size`** is supplied by CSS, two ways depending on `type`:
  - **`sizes` mode** — `ckeditor_heading_size_preprocess_html()` injects a `<style>` into
    `html_head` with, for every *enabled heading tag* × *size*, a rule like
    `h2.heading-size-24px { font-size: 24px; }`. `important: true` appends `!important`;
    `extra_specificity: '.main-container'` also emits
    `.main-container h2.heading-size-24px { … }` to out-specify a theme rule. Enabled tags come
    from the core Heading plugin's `heading.options` via `_get_enabled_heading_tags()`.
  - **`classes` mode** — no CSS is generated; the applied class (e.g. `my-h2-style`) must be styled
    by your **theme**.

## How the classes survive `filter_html`

`src/Config/AllowedHtmlOverride.php` (service `ckeditor_heading_size.allowed_html_override`, a
`config.factory.override`, priority 5) makes the size classes pass the *Limit allowed HTML tags*
filter without you editing each format by hand:

- `loadOverrides()` runs only after `install_task === 'done'`, matches config names against
  `^filter\.format`, and for each format with a non-empty `filter_html`:
- it loads that format's `allowed_html` string, walks the enabled heading tags (`h2`, `h3`, …), and
  **adds the module's size class tokens to the heading tag's allowed `class` list** — appending to an
  existing `<h2 class="…">` spec, or adding `class="heading-size-… heading-size-…"` when the tag had
  none. Result: `filter_html` now permits exactly those size classes on those heading tags.
- It only ever edits the `class` attribute of **heading** tags. It never adds `style`, never adds a
  wildcard `class` value, and never touches non-heading tags — so an editor of that format can apply
  the configured size classes and nothing else new.

Because this is a runtime override (not saved config), the format's stored `allowed_html` is
unchanged on disk; the extra classes appear in the effective, filtered output. If you switch `type`
or change `size_options`, rebuild caches so the override and generated CSS pick up the new class
names.

## Gotchas

- No **Heading** dropdown in the toolbar ⇒ no size control (the plugin's `conditions` aren't met).
- The size control is triggered by **clicking a heading**, not by a button — editors need to know
  that.
- `classes` mode delegates all styling to the theme; the module emits no CSS in that mode.
- Cite points: `ckeditor_heading_size.ckeditor5.yml`, `.module`
  (`hook_ckeditor5_plugin_info_alter`, `hook_preprocess_html`, `_get_size_class_name`,
  `_get_enabled_heading_tags`), `src/Form/SettingsForm.php`, `src/Config/AllowedHtmlOverride.php`,
  and JS `headingsizeediting.js` / `headingsizeui.js`.
