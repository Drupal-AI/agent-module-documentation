<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Libraries, the CDN URL, and the `locale` 500 bug

`openapi_ui_redoc.libraries.yml` in full:

```yaml
redoc:
  js:
    'https://rebilly.github.io/ReDoc/releases/latest/redoc.min.js': {}
redoc_attr:
  js:
    'js/redoc.js': {}
  dependencies: [core/jquery, core/drupal, openapi_ui_redoc/redoc]
```

`openapi_ui_redoc/redoc` is always attached by `ReDoc::build()`; `redoc_attr` only when
`#openapi_schema` was an array. `js/redoc.js` waits for document ready, reads the `<redoc>`
element's `spec-url`; if absent it JSON-parses the `spec` attribute and calls `Redoc.init(...)`,
else logs *"Redoc spec not provided. UI not loaded."*

## Bug: the CDN URL is missing `type: external`

The entry is an absolute `https://` URL declared without `type: external`, so
`LibraryDiscoveryParser` records it as `type: file`:

```bash
drush php:eval 'print json_encode(\Drupal::service("library.discovery")->getLibraryByName("openapi_ui_redoc","redoc")["js"]);'
# [{"group":-100,"type":"file","data":"https://rebilly.github.io/ReDoc/releases/latest/redoc.min.js",...}]
```

Consequences:

1. **Core `locale` enabled → HTTP 500 on every ReDoc page.** `locale`'s `hook_js_alter()`
   passes every `type: file` asset to `_locale_parse_js_file()`, which throws
   `Only local files should be passed to _locale_parse_js_file().` The page dies; this is not a
   warning.
2. `latest` is unpinned, and it is a hard third-party CDN dependency (CSP / air-gapped sites
   cannot load it).

### Fix — declare it external (and optionally pin / self-host)

```php
/**
 * Implements hook_library_info_alter().
 */
function mymodule_library_info_alter(array &$libraries, $extension): void {
  if ($extension !== 'openapi_ui_redoc' || empty($libraries['redoc']['js'])) {
    return;
  }
  foreach ($libraries['redoc']['js'] as $path => $options) {
    if (str_starts_with($path, 'http')) {
      $libraries['redoc']['js'][$path]['type'] = 'external';
      $libraries['redoc']['js'][$path]['minified'] = TRUE;
    }
  }
}
```

At alter time the `js` array is still **keyed by the source path**, so mutate
`$libraries['redoc']['js'][$path]`, not a numeric index. `drush cr` afterwards; the page then
returns 200 and emits `<script src="https://rebilly.github.io/…/redoc.min.js?…">`.

Pin a version — same hook, replace the key:

```php
unset($libraries['redoc']['js']['https://rebilly.github.io/ReDoc/releases/latest/redoc.min.js']);
$libraries['redoc']['js']['https://cdn.redoc.ly/redoc/v2.1.3/bundles/redoc.standalone.js']
  = ['type' => 'external', 'minified' => TRUE];
```

Self-host (CSP-safe): drop the bundle at `libraries/redoc/redoc.standalone.js` and use the key
`/libraries/redoc/redoc.standalone.js` — a leading slash means docroot-relative, `type` stays
`file`, and `locale` is happy because it really is local.

## Theming

No template, no theme hook: the output is a bare `#type => 'html_tag'` `<redoc>` custom element
styled entirely by the ReDoc bundle. To restyle, wrap it in your own container/template in the
controller, or replace `ReDoc::build()` via
`hook_openapi_ui_alter()` → `$definitions['redoc']['class']`. `id="redoc-ui"` is hardcoded, so
two ReDoc elements on one page collide.
