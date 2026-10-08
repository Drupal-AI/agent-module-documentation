<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DROWL Trademark appends a registered-trademark sign (a superscript ®) after a configurable list of words wherever they appear on rendered front-end pages, applied client-side by JavaScript at runtime.

---

The module is tiny: one settings form, one permission, one config object, and one JavaScript behavior. On every non-admin page request, `drowl_trademark_page_attachments()` (in `drowl_trademark.module`) reads the config object `drowl_trademark.settings`, takes the comma-separated word list `drowl_trademark_replacements` (parsed with `Tags::explode()` and joined with `|`), and — only if the list is non-empty — attaches the `drowl_trademark/drowl_trademark` library and passes two values into `drupalSettings.drowl_trademark`: `replacepattern` (the pipe-joined words) and `filter` (a jQuery exclusion selector, `drowl_trademark_filter`). The behavior in `js/drowl_trademark.js` builds a case-insensitive word-boundary regex `\b(pattern)(?!<sup)\b`, selects page elements (scoped with `core/once`), drops elements matching the `filter` selector, and uses a bundled jQuery `replaceText` plugin to wrap each matched word with `$1<sup>®</sup>`. The injected markup is a fixed literal; the captured `$1` is the page's own existing text. The default `filter` excludes `.no-drowl-trademark` (and descendants), mailto/`itemprop=email` links, and `.spamspan` output, so email addresses and opted-out regions are left alone. The script is deliberately skipped on admin routes (it would break the WYSIWYG) and on `*/js` paths. The settings form (`DrowlTrademarkSettingsForm`, a `ConfigFormBase`) lives at `/admin/config/user-interface/drowl_trademark`, is gated by the `administer drowl trademark` permission, and exposes exactly two required text fields: the words and the jQuery filter. Because marking is done in the browser and not stored, it never alters saved content. This checkout is a development branch (no `version:` in info.yml) — treat it as pre-release.

---

- Append a superscript ® after your brand or product names sitewide without editing content.
- Mark trademarked terms that appear in menus, blocks, and other output that bypasses input filters.
- Keep trademark marking consistent across many nodes without hand-editing each one.
- Add the ® at runtime so it never gets baked into stored content or exports.
- List several terms at once as a comma-separated word list (e.g. `Acme, Widgetify, ExampleBrand`).
- Match terms case-insensitively so `acme` and `Acme` both get marked.
- Rely on word-boundary matching so only whole words (not substrings) are marked.
- Avoid double-marking already-marked words (the regex skips a word already followed by `<sup>`).
- Exclude specific regions from marking by adding the `no-drowl-trademark` CSS class to a container.
- Keep email addresses unmarked (default filter skips mailto and `itemprop=email` links).
- Leave spamspan-obfuscated addresses untouched via the default `.spamspan` filter entry.
- Customise the exclusion selector with any regular jQuery filter notation.
- Include parents for modules like spamspan using a filter such as `.spamspan > *`.
- Have marking re-applied to AJAX-loaded content automatically (the behavior runs on AJAX context).
- Prevent the script from running on admin pages so it can't interfere with the editor UI.
- Provide a client-side alternative when a server-side input-filter approach would miss menu/system text.
- Restrict who can define trademark words with the dedicated `administer drowl trademark` permission.
- Turn marking off entirely by clearing the word list (the library then never loads).
- Add or remove marked terms at any time from one settings form, effective on the next page load.
- Run on Drupal 8.9 through 11 with no module dependencies and no external libraries.
- Ship a self-contained solution that uses only core jQuery, `core/once`, and `drupalSettings`.
