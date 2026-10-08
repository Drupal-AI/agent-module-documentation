<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `block_list_override.list` service

Service id **`block_list_override.list`** → `Drupal\block_list_override\BlockListOverride`
(constructor arg: `@entity_type.manager`). The module's two alter hooks use it; you can reuse
it to apply the same block-filtering logic yourself.

```php
$list = \Drupal::service('block_list_override.list');
$list->setUp([
  'match'  => "system_powered_by_block\nsystem_branding_block", // newline list
  'prefix' => "field_block",   // matches ids starting "field_block:"
  'regex'  => "/^views_block:/",
  'negate' => FALSE,            // FALSE = Remove matched; TRUE = Allow only matched
]);

if ($list->hasSettings()) {
  $keep = $list->blockIsAllowed('system_powered_by_block'); // bool
}
```

## Methods
- `setUp(array $settings): void` — accepts `match`, `prefix`, `regex` (each a newline-separated
  string) and `negate` (bool). Trims each; sets `hasSettings` true if any of match/prefix/regex
  is non-empty.
- `hasSettings(): bool` — whether any pattern was provided (if false, filtering is a no-op).
- `blockIsAllowed($plugin_id): bool` — TRUE if the block should be **kept**:
  - a block "is listed" when it prefix-matches (`"<prefix>:"`), exactly matches, or regex-matches;
  - **negate FALSE:** keep when NOT listed; **negate TRUE:** keep when listed;
  - blocks already used in any Layout Builder section (read once from all `entity_view_display`
    third-party `layout_builder.sections`) are always kept.

## How the module wires it (for reference)
```php
// hook_block_alter() and hook_plugin_filter_block__layout_builder_alter():
$list->setUp(['match'=>system_match, 'prefix'=>system_prefix, 'regex'=>system_regex,
              'negate'=> system_negate | layout_negate]);
if ($list->hasSettings()) {
  $definitions = array_filter($definitions, [$list,'blockIsAllowed'], ARRAY_FILTER_USE_KEY);
}
```
There is no `*.api.php` and no Drush; this service is the only public surface.
