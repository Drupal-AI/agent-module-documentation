# Client-side plugin, library & regex execution

This is where the actual cleanup happens — in the browser, inside CKEditor 5.

## Registration

- **Plugin definition:** `ckeditor5_paste_filter.ckeditor5.yml` declares
  `ckeditor5_paste_filter_pasteFilter`, which loads CKEditor 5 plugin `pasteFilter.PasteFilter`,
  attaches Drupal library `ckeditor5_paste_filter/paste_filter`, sets `elements: false`
  (adds no new HTML elements), and maps to PHP class
  `Drupal\ckeditor5_paste_filter\Plugin\CKEditor5Plugin\PasteFilter`.
- **Library:** `ckeditor5_paste_filter.libraries.yml` → `paste_filter` loads the minified
  `js/build/pasteFilter.js` and depends on `core/ckeditor5`.
- **Source:** `js/ckeditor5_plugins/pasteFilter/src/pastefilter.js` (built via webpack/yarn;
  `js/build/pasteFilter.js` is the compiled artifact).

## How paste is intercepted

The JS `PasteFilter` plugin `requires` CKEditor 5's `ClipboardPipeline` and listens on its
`inputTransformation` event. On each paste it:

1. Reads the filter list from editor config: `editor.config.get('pasteFilter')`.
   If falsy (plugin disabled or no filters), it returns immediately — paste is untouched.
2. Serializes the pasted content to HTML: `editor.data.htmlProcessor.toData(data.content)`.
3. For each filter, runs `html.replace(new RegExp(filter.search, 'gimsu'), filter.replace)`.
4. Writes the cleaned HTML back: `data.content = editor.data.htmlProcessor.toView(html)`.

So filters operate on the **HTML string** of the pasted fragment, in order, before CKEditor
converts it into the editor model.

## PHP → JS config bridge

`PasteFilter::getDynamicPluginConfig()` builds the `pasteFilter` config value sent to the
browser:

- If the plugin is **disabled** or has **no filters**, it returns `['pasteFilter' => FALSE]`
  → the JS bails out and does nothing.
- Otherwise it returns only the **enabled** filters, **sorted by weight**
  (`SortArray::sortByWeightElement`), as `['pasteFilter' => $enabled_filters]`.

## Regex flags & error handling

- Every search expression is compiled with the flags **`gimsu`** — global, ignoreCase,
  multiline, dotAll, unicode. Do not add your own delimiters.
- Replacements may reference capture groups (`$1`, `$2`, …).
- An **invalid regex** is caught in a `try/catch`: the error is logged to the browser console
  (`CKEditor 5 Paste Filter: Invalid regular expression "..."`) and that filter is skipped, so
  a bad rule never breaks the paste.
