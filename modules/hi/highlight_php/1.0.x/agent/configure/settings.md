# Configure — settings & enabling the filter

## Enable highlighting on a text format
Highlighting only happens for formats where the filter is enabled:
1. `/admin/config/content/formats` → edit a format (e.g. Full HTML).
2. Tick **"Highlight &lt;code&gt; tags in HTML."** (filter id `filter_highlight_php`).
3. Order it so it runs after tags are assembled; ensure the format's "Limit allowed HTML tags"
   filter permits `<code>`, `<pre>`, and the `class` attribute on `<code>` (needed for manual mode).
4. Save. The filter is `TYPE_TRANSFORM_IRREVERSIBLE`, so highlighted markup is what gets cached/stored
   in the render cache.

Drush/config: the enabled filter lives in `filter.format.<id>.yml` under
`filters.filter_highlight_php: { status: true, weight: 10 }`.

## Global settings form
Route `highlight_php.settings` → `/admin/config/content/highlight-php`
(permission `administer site configuration`). Config object `highlight_php.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `mode` | string | `auto` | `auto` = guess language via `highlightAuto()`; `manual` = read language from the `<code>` tag. |
| `auto_languages` | string | `html php javascript css twig yaml go protobuf sql` | Space-separated whitelist passed to `setAutodetectLanguages()`; only used in `auto` mode. |
| `manual_regex` | string | `language-([a-zA-Z1-9]*)` | Regex run against the `<code>` tag's serialized HTML; **capture group 1** is the language name. No delimiters — the module wraps it in `|...|`. Only used in `manual` mode. |

Set via drush:
```
ddev drush cset highlight_php.settings mode manual -y
ddev drush cset highlight_php.settings manual_regex 'language-([a-zA-Z1-9]*)' -y
```

## How processing works (`highlight_php_highlight()`)
- Loads the HTML with `Html::load()`, iterates `//code` nodes with `DOMXPath`.
- `auto`: `highlightAuto($node->textContent)` limited to the whitelist.
- `manual`: matches `manual_regex` against `$document->saveHTML($node)`; if group 1 is present,
  calls `highlight($language, $node->textContent)`.
- On success, replaces the node's text with the highlighter's escaped span markup (as a document
  fragment) and appends `hljs` + the detected language to the tag's `class`.
- Returns `FALSE` if no `<code>` node was highlighted (filter then returns the text unchanged).
- Unknown/failed languages are caught and skipped silently.

## Notes
- Manual mode's default regex matches CKEditor's `class="language-php"` convention.
- No per-format settings — `mode`/languages/regex are global for the whole site.
- To restyle, override `.hljs` and the `hljs-*` token classes; the bundled theme is a11y-light.
