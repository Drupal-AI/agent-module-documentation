<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Word Count (ckeditor5_wordcount) — agent index

A **client-side CKEditor 5 plugin** that shows a live **word and character count**
below a CKEditor 5 editor and, optionally, applies visual warning/exceeded feedback
against configurable limits. Everything is in the browser — there is no server-side
counting or enforcement. Package `CKEditor 5`. Core `^10.3 || ^11`. License
GPL-2.0-or-later. Installed **1.0.1** (version dir `1.0.x`). Security coverage:
not covered by the security advisory policy.

Content-editing/CKEditor feature; affects the editing UI only. No content entity,
no access role, no permissions of its own.

## Dependencies

- Drupal module: **`ckeditor5`** (core) — the only dependency (`.info.yml`).
- No PHP libraries (`composer.json` is empty). No declared PHP version requirement.

## What it provides (all from source)

- **CKEditor 5 plugin** `ckeditor5_wordcount_wordCount` (`ckeditor5_wordcount.ckeditor5.yml`)
  → JS plugin `wordCount.WordCount`, library `ckeditor5_wordcount/word_count`, drupal
  label "Word Count", `elements: false` (adds no HTML tags → no GHS widening),
  condition `ckeditor5_paragraph`. Default CKEditor config `displayWords: true`,
  `displayCharacters: true`.
- **JS plugin** `js/ckeditor5_plugins/wordCount/src/wordcount.js` (source) built to
  `js/build/wordCount.js` (webpack, CKEditor 5 as a `dll-reference` to core — served
  locally, no CDN). Counts words with a Unicode-aware regex (`\p{L}\p{N}` when
  supported, ASCII+Latin fallback), counts characters excluding newlines, throttles
  recount at ~250 ms on `change:data`, renders a `.ck-word-count` div into the
  editor's parent, and adds `ck-wordcount-warning` / `ck-wordcount-exceeded` classes
  to the editing root + output view. Supports an `onUpdate` config callback and fires
  an `update` event. Reads limits from `drupalSettings.ckeditor5_wordcount`.
- **Global settings form** `WordCountConfigForm` (`src/Form/WordCountConfigForm.php`,
  extends `ConfigFormBase`) at route `ckeditor5_wordcount.settings` →
  `/admin/config/content/ckeditor5-wordcount`, permission
  `administer site configuration`. Menu link under Configuration → Content authoring
  (`.links.menu.yml`). Fields: `enable_word_limit` (bool), `word_limit` (int, def 500),
  `enable_character_limit` (bool), `character_limit` (int, def 2000),
  `warning_threshold` (int %, def 90). On submit it saves config and calls
  `library.discovery` `clearCachedDefinitions()` so new limits reach the browser
  without a full cache clear.
- **`hook_library_info_alter`** (`ckeditor5_wordcount.module`) injects the five
  settings (cast to bool/int) into the `word_count` library's `drupalSettings`, and
  attaches a per-language translation library (`translations.<langcode>`) when one
  exists for the current UI language.
- **Config schema** `config/schema/ckeditor5_wordcount.schema.yml` — `config_object`
  fully typing the five settings. Also `hook_help` (help.page only).
- **Libraries** (`.libraries.yml`): `word_count` (JS+CSS, depends `core/ckeditor5`),
  `admin.wordcount` (CSS), and `translations.{fr,ar,es,de}`. CSS `css/wordcount.css`
  styles the counter and warning/exceeded states.

## No submodules, no permissions.yml, no services.yml, no update hooks, no Drush.

## How it works end to end

1. Editor selects the "Word Count" item in a CKEditor 5 text format's config.
2. `hook_library_info_alter` bakes the site-wide limits/threshold into
   `drupalSettings` on the plugin library.
3. On each throttled `change:data`, the JS recomputes word/character counts, updates
   the visible `Words: N [/ limit]` / `Characters: N [/ limit]` labels, and toggles
   warning (≥ threshold %) / exceeded (> limit) CSS classes. Limits are
   **advisory/visual only — never enforced server-side and never block submission.**
