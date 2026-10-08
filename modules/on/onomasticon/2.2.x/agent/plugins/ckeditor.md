<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor "exclude from glossary" plugin

Onomasticon ships an editor button that lets authors mark a passage so the glossary filter leaves it
alone. It wraps the selection in a custom `<nonomasticon>` inline element. That element is added to
the filter's disabled-tags list automatically, and any `<nonomasticon>` tags are stripped from the
final rendered output (`FilterOnomasticon::removeCustomTag()`), so it only affects processing and
never reaches the page.

Both editor generations are supported.

## CKEditor 5 (current)

- Definition: `onomasticon.ckeditor5.yml`.
  - Plugin id: **`onomasticon_glossary_exclude`**.
  - JS plugin class: `glossaryExclude.GlossaryExclude`.
  - Toolbar item: **`glossaryExclude`** (label "Exclude from glossary" / "Glossary exclude").
  - `drupal.library`: `onomasticon/glossary_exclude`; `drupal.admin_library`:
    `onomasticon/admin.glossary_exclude`.
  - Allowed element: **`<nonomasticon>`** (declared under `elements:`), so the text format's HTML
    filter must permit it.
- JS source (`js/ckeditor5_plugins/glossaryExclude/src/`, built to `js/build/glossaryExclude.js`):
  - `glossaryexcludeediting.js` — extends `$text` with the **`nonomasticon`** model attribute
    (`isFormatting: true`, `copyOnEnter: true`), registers an `attributeToElement` converter
    (model `nonomasticon` ⇄ view `<nonomasticon>`), and adds an `AttributeCommand` named
    `nonomasticon`.
  - `glossaryexcludeui.js` — registers the `glossaryExclude` toolbar `ButtonView` (toggleable, icon
    `assets/icons/nonomasticon.svg`); executing it runs the `nonomasticon` command.
  - Because it relies on CKEditor's Advanced Content Filter allowing `<nonomasticon>`, in practice
    this works reliably only on **Full HTML**-style formats.

## CKEditor 4 (legacy) + upgrade path

- `src/Plugin/CKEditorPlugin/OnomasticonExcludeCkeditorButton.php` —
  `@CKEditorPlugin(id = "nonomasticon", label = "Nonomasticon")`, button `nonomasticon` (icon
  `js/plugins/nonomasticon/icons/nonomasticon.png`, file `js/plugins/nonomasticon/plugin.js`),
  `isInternal() = FALSE`, no config/deps/libraries.
- `src/Plugin/CKEditor4To5Upgrade/OnomasticonExcludeCkeditorButton.php` —
  `@CKEditor4To5Upgrade(id = "nonomasticon", cke4_buttons = {"nonomasticon"})`. Maps the CKEditor 4
  toolbar button `nonomasticon` → CKEditor 5 toolbar item `glossaryExclude`
  (`mapCKEditor4ToolbarButtonToCKEditor5ToolbarItem`). The settings/subset mapping methods throw
  `\OutOfBoundsException` (nothing to migrate).

## Libraries (`onomasticon.libraries.yml`)

- `onomasticon/glossary_exclude` — `js/build/glossaryExclude.js` (minified) +
  `css/glossary_exclude.css`; depends on `core/ckeditor5`.
- `onomasticon/admin.glossary_exclude` — `css/glossary_exclude.admin.css` (editor-only styling).
