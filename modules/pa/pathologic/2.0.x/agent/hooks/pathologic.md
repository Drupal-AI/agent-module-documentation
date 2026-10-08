# Hooks — `pathologic.api.php`

## `hook_pathologic_alter(array &$url_params, array $parts, array $settings)`

Invoked after Pathologic has parsed a URL it intends to rewrite and just before it builds the new
URL. Lets a module change what Pathologic emits, or veto the rewrite entirely.

- `&$url_params` — the alterable array with `path` and `options` (mirrors the old `url()`
  `$path`/`$options`). `options` includes an extra `use_original` flag (default `FALSE`); set it to
  `TRUE` and Pathologic returns the **original, unaltered** URL instead of rebuilding it — the way
  to stop Pathologic from touching a URL it wrongly decided to rewrite.
- `$parts` — result of `parse_url()` on the found path (as adjusted by Pathologic), plus
  `$parts['original']`, the untouched original URL. Do not modify; alter `$url_params` instead.
- `$settings` — the settings Pathologic is using; the active filter settings live in
  `$settings['current_settings']`.

```php
function mymodule_pathologic_alter(array &$url_params, array $parts, array $settings) {
  // Veto: leave links under "bananas/" exactly as authored.
  if (preg_match('~^bananas(/.*)?$~', $url_params['path'])) {
    $url_params['options']['use_original'] = TRUE;
  }
  // Rewrite local images to a CDN host.
  if (preg_match('~\.(png|gif|jpe?g)$~', $url_params['path'])) {
    $url_params['path'] = 'http://cdn.example.com/' . $url_params['path'];
    $url_params['options']['external'] = TRUE;
  }
  // Add a query parameter.
  $url_params['options']['query']['foo'] = 'bar';
}
```

## Migration note

Pathologic implements `hook_migration_plugins_alter()` to map the Drupal 7 `pathologic` filter id to
`filter_pathologic` in the `d7_filter_format` migration, so D7 filter settings carry over on upgrade.
