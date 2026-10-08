Adds the native CKEditor 5 Find and Replace feature to Drupal's CKEditor 5, giving editors an in-editor panel to search text and replace single or all matches.

---

This is a thin integration module: it registers the upstream CKEditor 5 `findAndReplace.FindAndReplace` plugin (bundled as the compiled `js/build/find-and-replace.js`) as a Drupal CKEditor 5 plugin and exposes a **Find and replace** toolbar button. There is no PHP logic, no settings, no permissions, and no config entities — the empty `.module` file and the `ckeditor5_findandreplace.ckeditor5.yml` plugin definition are the whole module. Setup is entirely per text format: add the toolbar button on *Configuration → Content authoring → Text formats and editors* for the format you want. Because the plugin declares `elements: false`, it adds no new HTML elements or attributes to stored content — it is a pure editor utility (find, replace, replace-all, match-case, whole-words, match navigation, `Ctrl/⌘+F` shortcut). All assets are bundled locally; no CDN or external library. Requires Drupal 11 and PHP 8.1+.

---

- Give editors an in-editor Find panel to locate text without leaving the field.
- Replace a single highlighted match in the body content.
- Replace all occurrences of a term in one action.
- Toggle case-sensitive searching ("Match case").
- Restrict matches to whole words only.
- Step through matches with Previous/Next and a "X of N" counter.
- Open the panel with the `Ctrl+F` / `⌘F` keyboard shortcut.
- Add the Find-and-replace button only to specific text formats (e.g. Full HTML).
- Provide find/replace on any CKEditor 5 field (body, formatted text fields, etc.).
- Standardise terminology across long articles by bulk-replacing a phrase.
- Fix a repeated typo across a large document quickly.
- Keep the feature entirely local (no external CDN assets loaded).
- Ensure no markup/tokens are written to content (the feature is editor-only, `elements: false`).
- Enable a familiar word-processor-style find/replace UX for content authors.
- Add the button to multiple formats independently via each format's toolbar config.
