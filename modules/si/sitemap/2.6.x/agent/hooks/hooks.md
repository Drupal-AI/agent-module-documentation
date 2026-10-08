# Sitemap — hooks

Defined in `sitemap.api.php`. Both alter the taxonomy term data the Vocabulary plugin is
about to render (see `Drupal\sitemap\Plugin\Sitemap\Vocabulary::view()`).

## `hook_sitemap_vocabulary_alter(array &$list, string $vid): void`
Runs for every vocabulary shown. `$list` is keyed by term id; each value is a render
array (flat vocab: `['data' => ...]`; hierarchical: `[0 => ..., 'children' => [...]]`).
Use it to hide terms, append markup, or reorder.

## `hook_sitemap_vocabulary_VID_alter(array &$list, string $vid): void`
Same shape, but targeted at a single vocabulary — replace `VID` with the vocabulary
machine name (e.g. `hook_sitemap_vocabulary_tags_alter`).

```php
function mymodule_sitemap_vocabulary_alter(array &$list, string $vid): void {
  if ($vid === 'tags' && isset($list[1234])) {
    unset($list[1234]); // hide a term
  }
}
```

To add a whole new section (rather than alter taxonomy), write a Sitemap plugin instead
→ [../plugins/sitemap.md](../plugins/sitemap.md).
