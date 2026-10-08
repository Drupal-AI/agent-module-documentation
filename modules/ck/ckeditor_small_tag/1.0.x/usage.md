<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Small Tag adds a CKEditor 5 toolbar button that wraps the selected text in an HTML `<small>` element, working like the built-in Bold, Italic, or Strikethrough buttons.

---

The module is a thin CKEditor 5 plugin integration: it declares one CKEditor 5 plugin
(`ckeditor_small_tag.ckeditor5.yml` → `smallPlugin.Small`) exposing a single toolbar item, `small`,
labelled "Small", and it registers `<small>` as an element the plugin provides. The JavaScript
(`js/build/smallPlugin.js`, source under `js/ckeditor5_plugins/smallPlugin/src/`) defines a
`SmallEditing` plugin that extends the editor schema with a `small` text attribute mapped to the
`<small>` view element, a `SmallCommand` toggle command modelled on CKEditor's basic-styles, and a
`SmallUI` plugin that adds a toggleable toolbar button using the shipped `icons/small.svg`. It
depends on Drupal core's `ckeditor5` module only, has no PHP beyond the plugin YAML, no settings
form (`configure` is null), no permissions, no config schema, and no Drush commands. To use it you
drag the **Small** button into a text format's active CKEditor 5 toolbar; because the plugin
declares `<small>` in `elements`, Drupal's CKEditor 5 filter integration automatically allows that
tag in formats where the button is enabled.

---

- Add a **Small** button to a CKEditor 5 toolbar for marking fine print.
- Let editors wrap legal disclaimers or copyright lines in `<small>`.
- Mark footnote-style or secondary text as smaller than body copy.
- Provide de-emphasized side notes within rich-text content.
- Toggle the `<small>` styling on and off over a text selection, like Bold/Italic.
- Apply small text to a collapsed cursor position so subsequently typed text is small.
- Add semantically correct `<small>` markup (rather than a font-size hack) for accessibility.
- Style captions or attributions under images/quotes as small print.
- Give "terms and conditions" snippets a smaller, semantic wrapper.
- Enable `<small>` on only the text formats/roles that should have it, via toolbar config.
- Automatically allow the `<small>` tag in a format by adding the button (no manual filter tweak).
- Keep the small-text control consistent across all CKEditor 5 formats on the site.
- Offer authors a familiar one-click control for de-emphasized text.
- Mark pricing footnotes ("*prices exclude tax") as small text.
- Add small print to newsletter/landing-page bodies edited in CKEditor 5.
- Provide a lightweight alternative to custom CKEditor style dropdowns for `<small>`.
- Ensure pasted or typed fine print carries a proper `<small>` element on save.
