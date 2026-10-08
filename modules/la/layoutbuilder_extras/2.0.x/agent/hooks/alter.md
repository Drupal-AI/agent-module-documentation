# Hooks

The module invites one alter hook (no `.api.php` ships; it is invoked in
`LayoutBuilderExtrasLayout::getLayouts()`).

## `hook_layoutbuilder_extras_allowed_layouts_alter(array &$definitions)`

Filter or reorder the layouts offered in the "Change layout" list of a section. `$definitions` is the
array of layout plugin definitions (keyed by plugin id) already filtered by core's
`getFilteredDefinitions('layout_builder', $contexts, ['section_storage' => …])`. Unset entries to hide
those layouts from the swap UI.

```php
/**
 * Implements hook_layoutbuilder_extras_allowed_layouts_alter().
 */
function mymodule_layoutbuilder_extras_allowed_layouts_alter(array &$definitions) {
  // Only allow swapping to one- and two-column layouts.
  foreach (array_keys($definitions) as $plugin_id) {
    if (!in_array($plugin_id, ['layout_onecol', 'layout_twocol_section'], TRUE)) {
      unset($definitions[$plugin_id]);
    }
  }
}
```

Invoked as `\Drupal::moduleHandler()->alter('layoutbuilder_extras_allowed_layouts', $definitions)`.
This only affects which layouts appear in the swap list; it does not restrict layouts elsewhere in
Layout Builder.
