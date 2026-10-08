# API — services

Two services build clouds; use them from a controller/block/custom code instead of hitting the DB.

## `tagclouds.tag` — `TagService` (`TagServiceInterface`)

Args: `config.factory`, `language_manager`, `cache.data`, `request_stack`, `database`,
`?content_translation.manager`.

- `getTags(array $vids, int $steps = 6, int $size = 60, ?string $display = NULL): array`
  Returns an **unordered** array of weighted term objects (each carries a `->weight` used for the
  `levelN` class) for the given vocabulary ids. `$steps` = number of weight levels; `$size` = max
  tags. Reads usage from the database; does not order the result.
- `sortTags(array $tags, string $sort_order = 'default'): array`
  Orders tags. `$sort_order` is one of `title,asc` `title,desc` `count,asc` `count,desc`
  `random,none` (or `default` to use the global `tagclouds.settings` sort).
- `getSortingOptions(): array` — the human-readable label map for the sort options.

## `tagclouds.cloud_builder` — `CloudBuilder` (`CloudBuilderInterface`)

Args: `config.factory`, `language_manager`, `entity_type.manager`.

- `build(array $terms): array` — returns a render array for a list of (already sorted) weighted
  term objects.

## Typical usage

```php
$tagService   = \Drupal::service('tagclouds.tag');
$cloudBuilder = \Drupal::service('tagclouds.cloud_builder');
$levels = \Drupal::config('tagclouds.settings')->get('levels');

$tags = $tagService->getTags(['tags'], $levels, 60);   // unordered, weighted
$tags = $tagService->sortTags($tags, 'count,desc');    // order them
$render = $cloudBuilder->build($tags);                 // render array
$render['#attached']['library'][] = 'tagclouds/clouds';
```

The module registers no plugin types and no hooks of its own beyond core hooks
(`hook_help`, `hook_theme`); extend behaviour by decorating these services or theming their output.
