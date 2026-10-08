<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ckeditor 5 Inline Styles (ckeditor5_inline_styles) — agent index

A CKEditor 5 plugin **and** a text-format filter that let an editor attach a free-text inline-style
string to an embedded **Drupal media** element. The editor stores the value as a `data-inline-style`
attribute; the filter copies that value onto the rendered element's `style` attribute. Works with
**media embeds only** (`drupal-media` / Media Library). Depends on core **`ckeditor5`** (and core
Media in practice). Core requirement `^10 || ^11`. License GPL-2.0-or-later.
Installed as **1.x-dev** (git commit `de56989`, 2024-04-12). No settings form, no permissions.

- **The filter, the CKEditor plugin, install/enable order, and how it renders** →
  [plugins/inline-style.md](plugins/inline-style.md)

## What it actually provides

- **Filter plugin** `FilterInlinePadding` (id **`filter_inline_style`**, title *"Inline Style"*,
  type `TYPE_TRANSFORM_REVERSIBLE`), in `src/Plugin/Filter/FilterInlinePadding.php`. On render it
  loads the HTML, finds `//*[@data-inline-style]`, removes the attribute, and sets `style` to its
  value. No config, no schema, no `defaultConfiguration()`.
- **CKEditor 5 plugin** `InlineStyle` (JS), declared in `ckeditor5_inline_styles.ckeditor5.yml`
  (`ckeditor5_inline_styles_inline_style`). Toolbar item **`inlineStylePadding`** (label
  *"Media Inline Styles"*). Only usable when the format also enables the `filter_inline_style`
  filter and has the `media_media` plugin (Media). Adds `<drupal-media data-inline-style>` to the
  format's allowed elements.
- **Library** `ckeditor5_inline_styles/inline_style` → `js/build/inlineStyle.js`
  (`ckeditor5_inline_styles.libraries.yml`), depends on `core/ckeditor5`.
- No `*.routing.yml`, no `*.services.yml`, no `*.permissions.yml`, no `*.module`, no `*.install`,
  no `config/` directory. `provides_config_schema: false`.

## JS structure (`js/ckeditor5_plugins/inlineStyle/src/`)

- `inlinestyle.js` — plugin, requires `InlineStyleEditing` + `InlineStyleUI`.
- `inlinestyleediting.js` — extends the `drupalMedia` schema with `dataInlineStyle`; registers
  upcast/downcast `attributeToAttribute` between model `dataInlineStyle` and view
  `<drupal-media data-inline-style>`; adds the `addInlineStyle` command.
- `inlinestylecommand.js` — `InlineStyleCommand`; enabled only when a `drupalMedia` element of
  entity type `media` is selected; `execute()` sets/removes `dataInlineStyle` from the balloon input.
- `inlinestyleui.js` / `inlinestyleview.js` — the toolbar button and the single-field balloon form.
- `utils.js` — media-selection helpers; `getInlineStyle()` reads the current `data-inline-style`.

## How to operate (from source + module README)

1. `drush en ckeditor5_inline_styles` (core `ckeditor5` + `media` must be enabled).
2. *Configuration → Content authoring → Text formats and editors* → edit a CKEditor 5 format.
3. Drag the **Media Inline Styles** button into the active toolbar.
4. Enable the **Inline Style** filter, and order it **before** *Embed media* in filter processing.
5. Select an embedded media item, click the button, type a style string, Save.
