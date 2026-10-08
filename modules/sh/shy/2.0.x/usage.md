CKEditor Soft hyphen (shy) adds a CKEditor 5 button (and Ctrl+Hyphen shortcut) that inserts an invisible soft hyphen (`&shy;`) at the cursor, giving editors control over where long words may break across lines, plus a text-format filter that converts the stored markup into the real soft-hyphen character on output.

---

The module ships two coordinated plugins. A CKEditor 5 plugin (`shy.ckeditor5.yml` → `shy_shy`, toolbar item "Soft hyphen") lets an author insert a soft hyphen with the toolbar button or Ctrl+Hyphen; in the editor the character is stored as a `<shy>` element (the plugin registers `<shy>` as an allowed element). A filter plugin, `shy_cleaner_filter` ("Cleanup SHY markup", a `TYPE_TRANSFORM_IRREVERSIBLE` filter), runs on output and replaces every `<shy></shy>` tag (and the legacy `<span class="shy">`) with the UTF-8 soft-hyphen byte sequence `\xC2\xAD`, using `Html::load()` + `DOMXPath` for parsing. There is no admin settings page (`configure` is null), no permissions, no config schema, and no Drush. Setup is entirely per text format: add the "Soft hyphen" button to that format's CKEditor 5 toolbar and enable the "Cleanup SHY markup" filter. The CKEditor 5 plugin declares a `conditions: filter: shy_cleaner_filter` dependency, so the button only appears on formats where the filter is enabled. If the "Limit allowed HTML tags" filter is active, `<span class>` must be allowed for legacy content. There is also a legacy CKEditor 4 plugin class (`src/Plugin/CKEditorPlugin/Shy.php`) kept for older editor integrations.

---

- Let editors mark where a long word (e.g. a URL, compound noun, or product code) may break.
- Improve justified-text layouts by controlling hyphenation points manually.
- Insert a soft hyphen with a CKEditor toolbar button.
- Insert a soft hyphen with the Ctrl+Hyphen keyboard shortcut.
- Prevent awkward line breaks in narrow columns or responsive layouts.
- Convert stored `<shy>` markup into real soft-hyphen characters on render via the filter.
- Keep backward compatibility with content authored using the old `<span class="shy">` markup.
- Add fine-grained hyphenation to specific text formats without affecting others.
- Avoid overflow of long unbreakable strings in tables or cards.
- Provide hyphenation control in multilingual content where automatic hyphenation is unavailable.
- Enable the feature only on trusted formats by toggling the button + filter per format.
- Help editors produce cleaner typography in headings and pull quotes.
- Support German/Dutch-style long compound words that need explicit break points.
- Insert invisible break hints that do not show a visible hyphen unless a break actually occurs.
- Combine with "Limit allowed HTML tags" by allowing `<span class>` for legacy soft hyphens.
