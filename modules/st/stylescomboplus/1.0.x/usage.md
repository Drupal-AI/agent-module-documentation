<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Styles Combo Plus** is a CKEditor 4 plugin that provides a *Styles +* dropdown like core's Styles combo, but with a workaround so that styles targeting `img` also apply to CKEditor image widgets — letting editors add CSS classes to images reliably.

---

The `CKEditorPlugin` plugin `StylesComboPlus` (id `stylescomboplus`, button `StylesPlus` labelled *Styles +*) is a non-internal, configurable plugin loading `js/plugins/ckeditor/stylescomboplus/plugin.js`. Its settings form provides a textarea where an admin lists styles one per line in `element.classA.classB|Label` format (e.g. `h1.title|Title`); `validateStylesValue()` enforces the syntax via regex and requires unique labels, and `generateStylesSetSetting()` parses each line into CKEditor's `stylesSet` structure. The key enhancement: when a rule's element is `img`, it additionally emits a `type: widget, widget: image` variant so the class is applied to the image widget (a workaround for CKEditor4 issue #1674). Styles are injected into the editor via `getConfig()`. The module also ships `ckeditor_stylesheets` (`css/stylescomboplus.css`) and attaches its stylesheet on every page via `hook_preprocess_html`. Depends on core `ckeditor` (CKEditor 4). Because the style list is admin-configured text editor settings, there is no untrusted-input surface here.

---

- Provide a *Styles +* dropdown in the CKEditor 4 toolbar.
- Apply CSS classes to images through the styles dropdown reliably.
- Define styles as `element.class|Label` lines in the editor config.
- Add multiple classes to a single style entry.
- Give editors named presets (e.g. *Fancy title*) for markup.
- Apply a widget-style variant automatically for `img` rules.
- Validate style syntax and enforce unique labels in the config form.
- Load a stylesheet so styled classes preview inside the editor.
- Configure the dropdown per text format / editor.
- Style headings, blockquotes or callouts consistently.
- Work around CKEditor4 image-widget class limitations.
- Keep style options centrally managed by administrators.
- Offer accessible aria-labelled toolbar button markup.
- Attach the module CSS to front-end pages for matching output.
- Reuse the same class presets across content types.
- Replace the core Styles combo where image styling is needed.
- Ship theme-defined classes to editors without custom code.
