# Configure highlight.js Input Filter

## Enable the filter on a text format

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`admin/config/content/formats`) and edit a format (e.g. Full HTML).
2. Under **Enabled filters**, check **Highlight code using highlight.js**.
3. Save. Content in that format now attaches highlight.js when it contains
   `<pre><code class="language-*">` blocks.

The filter (`filter_highlightjs`, `TYPE_TRANSFORM_REVERSIBLE`, class
`Plugin/Filter/HighlightJs.php`) does **not** modify the code markup. `process()`:
- regex-scans for `<pre>\s*<code class="…(lang|language)-([\w-]+)…">`,
- collects each language, resolving aliases (`cs`→`csharp`; `js`/`jsx`→`javascript`;
  `html`/`xhtml`/`rss`/`atom`/`svg`/`xsl`/…→`xml`) via `resolveAlias()`,
- attaches libraries `highlightjs_input_filter/highlightjs` (+ `.styles`) and, if the copy
  button is on, `highlightjs-copy` (+ `.styles`),
- attaches `drupalSettings.enableCopyButton`, `.highlightJsLanguages`, `.highlightJsBaseUrl`.

The client script `js/highlightjs_input_filter.js` (loaded as an ES `module`) reads those
settings and initializes highlighting. Because highlighting is client-side and language ids are
constrained to `[\w-]` and emitted through JSON-encoded `drupalSettings`, no code content is
re-emitted as markup by the filter. Ordering tip: place this filter so it runs after HTML
filtering; the `<pre><code class>` markup must survive the format's allowed-HTML rules.

## Settings form

Route `highlightjs_input_filter.settings.form` → `admin/config/content/highlightjs_input_filter`.
Permission: **`administer highlightjs_input_filter settings`**. Config object
`highlightjs_input_filter.settings` (schema `config/schema/…`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enable_copy_button` | bool | `true` | Show a hover copy-to-clipboard button (loads the highlightjs-copy plugin). |
| `theme` | string | `atom-one-dark` | highlight.js CSS theme. 200+ options (form remaps `base16-*` to `base16/*`). |
| `use_local` | bool | `false` | Load assets from a local `libraries/` copy instead of the CDN. |
| `local_path` | string | `/libraries/highlightjs` | Path to the highlight.js ES-module build (needs `es/` and `styles/`). |
| `local_path_copy` | string | `/libraries/highlightjs-copy/dist` | Path to the highlightjs-copy assets. |

## CDN vs self-hosted

- **CDN (default):** highlight.js **11.11.1** and highlightjs-copy **1.0.6** load from
  `unpkg.com`. `highlightJsBaseUrl` = `https://unpkg.com/@highlightjs/cdn-assets@11.11.1`.
- **Self-hosted:** set `use_local: true` and the paths. The theme CSS is registered dynamically
  by `hook_library_info_build` (`HighlightjsInputFilterHooks::libraryInfoBuild`), which points at
  either the unpkg styles URL or `<local_path>/styles/<theme>.min.css`.
  `hook_library_info_alter` swaps the copy-plugin JS/CSS to the local paths.
  `hook_runtime_requirements` raises a **status-report error** if `use_local` is on but
  `<local_path>/es/core.min.js` (or the copy plugin's `.min.js`) is missing. The settings form
  `validateForm()` performs the same file-existence checks on save.
- Requires the **ES-module** distribution of highlight.js — the single-file custom builds from
  highlightjs.org/download are not compatible. See the module README for the Composer +
  Asset Packagist setup that installs `@highlightjs/cdn-assets` into `web/libraries/highlightjs`.

## Set it up with Drush

```php
// drush php:eval — enable copy button, dark theme, self-host.
$c = \Drupal::configFactory()->getEditable('highlightjs_input_filter.settings');
$c->set('theme', 'github-dark')->set('enable_copy_button', TRUE)
  ->set('use_local', TRUE)->set('local_path', '/libraries/highlightjs')->save();
// Changing theme/paths invalidates the 'library_info' cache tag (submitForm does this in the UI).
\Drupal::service('cache_tags.invalidator')->invalidateTags(['library_info']);
```
