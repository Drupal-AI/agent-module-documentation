# The LayoutBuilderRestriction plugin type

Namespace `Plugin/LayoutBuilderRestriction`, interface
`Drupal\layout_builder_restrictions\Plugin\LayoutBuilderRestrictionInterface`, base
`LayoutBuilderRestrictionBase`, annotation `@LayoutBuilderRestriction`, manager
`plugin.manager.layout_builder_restriction`
(alter hook `hook_layout_builder_restrictions_layout_builder_restriction_info_alter()`).

The ships-with plugin is `entity_view_mode_restriction` (per-view-mode block/layout control).

## Skeleton
```php
namespace Drupal\my_module\Plugin\LayoutBuilderRestriction;

use Drupal\layout_builder_restrictions\Plugin\LayoutBuilderRestrictionBase;

/**
 * @LayoutBuilderRestriction(
 *   id = "my_restriction",
 *   title = @Translation("My restriction"),
 *   description = @Translation("Custom rules"),
 * )
 */
class MyRestriction extends LayoutBuilderRestrictionBase {
  public function alterBlockDefinitions(array $definitions, array $context) { /* filter */ return $definitions; }
  public function alterSectionDefinitions(array $definitions, array $context) { return $definitions; }
  public function blockAllowedinContext($section_storage, $delta_from, $delta_to, $region_to, $block_uuid, $preceding_block_uuid = NULL) { return TRUE; }
  public function inlineBlocksAllowedinContext($section_storage, $delta, $region) { return []; }
}
```

## Interface methods
- `alterBlockDefinitions(array $definitions, array $context)` — remove blocks the editor may not
  place. `$context` has at least `entity`, `view_mode`, `layout`, `region`.
- `alterSectionDefinitions(array $definitions, array $context)` — filter available layouts.
- `blockAllowedinContext($section_storage, $delta_from, $delta_to, $region_to, $block_uuid, $preceding_block_uuid = NULL)`
  — return TRUE to allow a move, or a string error message to deny it.
- `inlineBlocksAllowedinContext($section_storage, $delta, $region)` — return the allowed inline
  block type ids for that region.

Enable your plugin (and set its weight) on the global admin page; multiple enabled plugins are
applied in weight order, so each can further narrow the allowed set.
