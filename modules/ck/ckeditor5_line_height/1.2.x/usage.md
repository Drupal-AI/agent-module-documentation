<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor5 Line Height adds a "Line Height" dropdown toolbar button to CKEditor 5 that lets content authors apply a `line-height` CSS value to selected text or blocks. The list of offered values is configurable per text format.

---

The module ships a single CKEditor 5 plugin (`ckeditor5_line_height_line_height`) that registers a `lineHeight` toolbar item wired to a bundled JavaScript build (based on the p0thi ckeditor5-line-height-plugin). It is configured entirely through Drupal's text-format/editor UI at *Administration > Configuration > Content authoring > Text formats and editors*: drag the "Line Height" button into a CKEditor 5 toolbar for a format that uses the CKEditor 5 editor, and a settings vertical-tab appears where you enter the allowed options as a space-separated list. Defaults are `0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5`; on validation any value `>= 10` is dropped, duplicates are removed, and clearing the field restores the defaults. The chosen options are persisted as `line_height_options` inside the editor config entity (`editor.editor.<format>` → `settings.plugins.ckeditor5_line_height_line_height.line_height_options`), and passed to the editor at runtime via `getDynamicPluginConfig()` as `lineHeight.options`. The plugin declares `elements: false`, so it does not itself add allowed-tag restrictions; the applied inline styles need a format whose filters permit them (e.g. avoid stripping `style` attributes). The module has no admin settings route, no permissions, no services, and no Drush of its own — its only persistent state is the per-format plugin configuration.

---

- Give editors a "Line Height" toolbar button to loosen or tighten line spacing on selected paragraphs.
- Offer a curated set of line-height values (e.g. `1 1.5 2`) on a specific text format.
- Apply CSS `line-height` to headings or blockquotes directly from the WYSIWYG toolbar.
- Standardise vertical rhythm options across content by configuring one shared list of values.
- Add the button only to the Full HTML format while leaving Restricted HTML untouched.
- Reset a format's line-height list back to the module defaults by clearing the options field and saving.
- Restrict the maximum selectable line height (the module drops any value of 10 or more on save).
- Improve readability of dense body copy by letting authors bump line spacing without custom CSS.
- Provide accessibility-friendly spacing controls to editorial teams inside the editor.
- Configure different line-height option sets for different text formats.
- Deploy the line-height configuration through exported config (`editor.editor.<format>.yml`).
- Present unitless line-height multipliers (e.g. `1.5`) that scale with font size.
- Let authors zero out line height (`0`) for tightly stacked decorative text.
- Combine with other CKEditor 5 typography plugins (font size, font family) for full text styling.
- Enable consistent spacing in email/newsletter body fields edited with CKEditor 5.
- Add fine-grained half-step values (`0.5`, `1.5`, `2.5`) for precise spacing control.
- Roll the button out to a webform's rich-text field that uses a CKEditor 5 format.
- Remove the button from a format simply by dragging it out of the toolbar and saving.
- Author landing-page copy with adjustable leading without leaving the content form.
- Support multilingual sites where certain scripts read better with larger line spacing.
