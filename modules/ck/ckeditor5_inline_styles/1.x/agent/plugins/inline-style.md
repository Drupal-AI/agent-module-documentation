<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline Style filter + CKEditor 5 plugin

Two halves of one feature: a CKEditor 5 UI that **stores** an inline-style string on an embedded
media element, and a text-format filter that **renders** it. Both are required for the feature to
work end to end.

## The filter — `filter_inline_style`

`src/Plugin/Filter/FilterInlinePadding.php`, class `FilterInlinePadding extends FilterBase`.

- Annotation: id `filter_inline_style`, title *"Inline Style"*, description mentions
  `data-inline-style`, type `Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_REVERSIBLE`.
- `process($text, $langcode)`:
  - Fast-path: only acts if `stristr($text, 'data-inline-style') !== FALSE`.
  - `Html::load($text)` → `\DOMXPath`; iterates `//*[@data-inline-style]` (any element, not just
    `<drupal-media>`).
  - For each node: reads `data-inline-style`, calls `removeAttribute('data-inline-style')`, and if
    the value is non-empty calls `$node->setAttribute('style', $inline_padding)`.
  - Returns a `FilterProcessResult` with `Html::serialize($dom)`.
- No `settingsForm()`, no `defaultConfiguration()` — the filter has **no per-format settings**.
- Because the filter transforms `data-inline-style` → `style`, its **order matters**: the module
  README instructs placing *Inline Style* **before** *Embed media* in the filter processing order
  so the media embed is expanded correctly. In general place it after "Limit allowed HTML tags"
  considerations for the format; validate the rendered output on a non-trivial format.

## The CKEditor 5 plugin definition — `ckeditor5_inline_styles.ckeditor5.yml`

Plugin key `ckeditor5_inline_styles_inline_style`:

- `ckeditor5.plugins`: `drupalMedia.DrupalMedia`, `drupalMedia.DrupalElementStyle`,
  `inlineStyle.InlineStyle`.
- `drupal.label`: *Inline Style*; `drupal.library`: `ckeditor5_inline_styles/inline_style`.
- `drupal.toolbar_items.inlineStylePadding.label`: *Media Inline Styles* (the button you add).
- `drupal.elements`: `<drupal-media data-inline-style>` — the plugin widens the format's allowed
  elements to permit the `data-inline-style` attribute on `<drupal-media>`.
- `drupal.conditions`: `filter: filter_inline_style` and `plugins: [media_media]` — the toolbar
  button is only available when the format enables the Inline Style filter **and** the core Media
  (`media_media`) plugin.

## The JS behaviour (`js/ckeditor5_plugins/inlineStyle/src/`)

- **Editing** (`inlinestyleediting.js`): extends the `drupalMedia` model schema with
  `dataInlineStyle`; registers upcast + downcast `attributeToAttribute` mapping model
  `dataInlineStyle` ↔ view `<drupal-media data-inline-style>`; registers the `addInlineStyle`
  command.
- **Command** (`inlinestylecommand.js`): `refresh()` enables the command only when the closest
  selected element is a `drupalMedia` whose `drupalMediaEntityType === 'media'`; `value` is the
  current `dataInlineStyle`. `execute(options)` trims `options.padding` and either
  `setAttribute('dataInlineStyle', value, mediaEl)` (non-empty) or removes the attribute.
- **UI** (`inlinestyleui.js` + `inlinestyleview.js`): registers the `inlineStylePadding` button
  (label *"Media Inline Style"*, `icons/padding-icon.svg`), bound to the command's `isEnabled`;
  clicking opens a `ContextualBalloon` with a single **free-text** input ("Add Inline Style") and
  Save/Cancel. Save dispatches `addInlineStyle` with the raw field value; the field is
  pre-populated from `getInlineStyle()` (`utils.js`).
- **Compiled**: `js/build/inlineStyle.js` (webpack, `webpack.config.js`); source under
  `js/ckeditor5_plugins/`. Load path is the Drupal library `ckeditor5_inline_styles/inline_style`.

## Data flow (end to end)

1. Editor selects an embedded media element, clicks *Media Inline Styles*, types e.g.
   `margin: 1rem; float: right;`, Save.
2. Saved body markup contains `<drupal-media ... data-inline-style="margin: 1rem; float: right;">`.
3. On display, `filter_inline_style` rewrites that to
   `<drupal-media ... style="margin: 1rem; float: right;">` (attribute copied verbatim,
   `data-inline-style` dropped). `DOMDocument::setAttribute` HTML-encodes the value, so it stays
   inside the `style` attribute (no attribute/tag breakout).
4. Because the filter is `TYPE_TRANSFORM_REVERSIBLE`, the raw stored value round-trips back into
   the editor field when the content is reopened.

## Install / enable checklist

- Requires core `ckeditor5` and (for the button condition) core Media (`media_media`).
- Enable the module, add the *Media Inline Styles* toolbar button, enable the *Inline Style*
  filter, and place it before *Embed media* in the processing order (per README).
- Nothing else to configure — no settings form, no permissions, no config objects.
