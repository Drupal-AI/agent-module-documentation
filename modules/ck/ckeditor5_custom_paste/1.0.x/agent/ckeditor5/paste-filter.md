<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The PasteFilter CKEditor 5 plugin

## Registration
- `ckeditor5_custom_paste.ckeditor5.yml` maps id `ckeditor5_custom_paste_pasteFilter`:
  - `ckeditor5.plugins: [pasteFilter.PasteFilter]` (the JS plugin global).
  - `drupal.class: \Drupal\ckeditor5_custom_paste\Plugin\CKEditor5Plugin\PasteFilter`.
  - `drupal.library: ckeditor5_custom_paste/custom_paste_filter`.
  - `drupal.elements: false` — the plugin declares no additional allowed elements.
- `ckeditor5_custom_paste.libraries.yml` defines `custom_paste_filter` → `js/build/pasteFilter.js`
  (minified, preprocess: false), depending on `core/ckeditor5`.
- No toolbar item and no `conditions` in the definition, so the plugin is loaded on **every**
  CKEditor 5 text format and its configuration tab always shows.

## PHP: `src/Plugin/CKEditor5Plugin/PasteFilter.php`
- Extends `CKEditor5PluginDefault`, implements `CKEditor5PluginConfigurableInterface` and
  `CKEditor5PluginElementsSubsetInterface`.
- `defaultConfiguration()`: `enabled => FALSE`, `excluded_tags => ''`.
- `getElementsSubset()`: returns `['<p>']`.
- `buildConfigurationForm()`: a checkbox **Enable CKEditor5 custom paste** and a textfield
  **Excluded tags** ("comma-separated list of HTML tag names that should be preserved … For
  example: table, tr, td").
- `validateConfigurationForm()`: casts `enabled` to bool; normalises `excluded_tags` by splitting on
  commas, trimming, and keeping only entries matching `/^[a-zA-Z0-9-]+$/`, then re-joining with
  commas. So only simple tag-name tokens are stored — no attribute or angle-bracket injection into
  the stored config.
- `getDynamicPluginConfig()`: publishes editor config as
  `['pastefilter' => ['enabled' => <bool>, 'excluded_tags' => <array|FALSE>]]`. `excluded_tags` is
  `explode(',', …)` only when the stored string is non-empty, else `FALSE`.

## JS: `js/ckeditor5_plugins/pasteFilter/src/pastefilter.js`
- `PasteFilter extends Plugin`, `requires: [ClipboardPipeline]`.
- `init()`: returns immediately unless `editor.config.get('pastefilter').enabled === true`.
- Otherwise binds `ClipboardPipeline`'s `inputTransformation`:
  1. `html = editor.data.htmlProcessor.toData(data.content)` — pasted content to an HTML string.
  2. `html.replace(/<[^>]+>/gi, match => …)` on every tag:
     - if the tag name is in `excludedTags` → strip its attributes (`<(\w+)[^>]*>` → `<$1>`) but keep it;
     - else if it matches `<\/?br\s*\/?>` → keep the `<br>`;
     - else → replace with `</p><p>`.
  3. Collapse the `</p><p>` runs, wrap the whole thing in `<p>…</p>`, and delete empty `<p></p>`.
  4. `data.content = editor.data.htmlProcessor.toView(html)`.
- Net effect: the pasted text is split into paragraphs at every former tag; only `<br>` and
  (in principle) excluded tags survive.

## The excluded-tags caveat (1.0.3)
Line 22 of the JS reads the exclusion list as `this.editor.config.get('excluded_tags')`, i.e. a
**top-level** config key. But the PHP publishes it nested under `pastefilter` as
`pastefilter.excluded_tags`. The top-level key is never set, so `excludedTags` is always `[]` and
the `shouldExclude` branch is never taken. Consequence: in this release **every** tag is flattened
to a paragraph boundary regardless of the Excluded tags field — the exclusion feature is inert.
The `enabled` flag is read correctly (`pastefilter.enabled`), so the on/off toggle itself works.

## Practical guidance
- Treat this as a per-format "paste as plain paragraphs" toggle. Enable it on formats where you
  want clipboard content stripped to text; leave it off (default) elsewhere.
- Do not rely on Excluded tags to keep tables/lists intact in 1.0.3.
- Do not treat it as XSS protection — see the security note in `../start.md`; the server-side text
  format filters remain the control.
