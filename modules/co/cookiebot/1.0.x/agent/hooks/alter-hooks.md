# Cookiebot alter hooks

Declared in `cookiebot.api.php`. Both are invoked from `hook_page_attachments_alter()` /
`hook_node_view_alter()`.

## `hook_cookiebot_path_match_alter(&$excluded, $path, $exclude_paths)`

Take control of whether the current path is excluded from Cookiebot. `$excluded` is the boolean
result of matching `$path` against the admin `exclude_paths` list; set it to `TRUE`/`FALSE` to
force. Runs only when `exclude_paths` is non-empty.

```php
function mymodule_cookiebot_path_match_alter(&$excluded, $path, $exclude_paths) {
  $node = \Drupal::routeMatch()->getParameter('node');
  if ($node && $node->bundle() === 'landing') {
    $excluded = TRUE; // never load Cookiebot on landing pages
  }
}
```

## `hook_cookiebot_culture_alter(&$cookiebot_culture)`

Alter the culture/langcode string passed to Cookiebot as `data-culture` (page attachments) or to
the declaration (node view). Only invoked when `cookiebot_drupal_culture` is enabled. Note the
implementation passes the culture **string** by reference (the docblock's `array` type is
inaccurate).

```php
function mymodule_cookiebot_culture_alter(&$cookiebot_culture) {
  if ($cookiebot_culture === 'nb') {
    $cookiebot_culture = 'no';
  }
}
```

No other hooks are invited; the module itself only *implements* core hooks
(`hook_page_attachments_alter`, `hook_node_view_alter`, `hook_theme`, `hook_preprocess_menu`, `hook_help`).
