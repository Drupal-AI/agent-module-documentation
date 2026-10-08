# Hooks

Declared in `tagify.api.php`.

## `hook_tagify_autocomplete_match_alter(?string &$label, ?string &$info_label, array $context)`
Alter a single autocomplete match. Set `$label` to `NULL` to exclude the match entirely.
`$context` always contains:
- `entity` — the matched entity object.
- `info_label` — the raw info label before token replacement.

```php
function mymodule_tagify_autocomplete_match_alter(?string &$label, ?string &$info_label, array $context): void {
  if ($context['entity']->bundle() === 'archived') {
    $label = NULL; // hide archived entities
  }
}
```

## `hook_tagify_autocomplete_matches_alter(array &$matches, array $options)` (deprecated)
Deprecated in tagify:8.x-1.0, removed in 2.0. Use
`hook_tagify_autocomplete_match_alter()` instead.
