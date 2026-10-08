# Render-alter hooks (`entity_type_behaviors.api.php`)

At entity view time, `hook_entity_view_alter` runs each enabled behavior's `view()`, stores the collected
values in `$build['#entity_type_behaviors']`, then fires a **cascade** of alter hooks (via
`entity_type_behaviors_hook_callbacks()`), from most-general to most-specific. Every hook is also invoked
as a **theme function** (prefix the hook name with your active/base theme name).

## The three hook variants

| Hook | Fires for |
|---|---|
| `hook_entity_type_behaviors_alter__BEHAVIOR(&$build, EntityTypeBehaviorInterface $behavior)` | Any entity with behavior `BEHAVIOR` enabled, any entity type/bundle. |
| `hook_entity_type_behaviors_alter__BEHAVIOR__ENTITY_TYPE(&$build, $behavior)` | …restricted to entity type `ENTITY_TYPE`. |
| `hook_entity_type_behaviors_alter__BEHAVIOR__ENTITY_TYPE__BUNDLE(&$build, $behavior)` | …restricted to that entity type + `BUNDLE`. |

`BEHAVIOR` is the plugin `id`. All three fire (when applicable) for the same entity; the second/third
argument is the instantiated behavior plugin, so you can call `$behavior->getValues()` /
`getValueByKey()`.

## Example (module implementation)

```php
/**
 * Implements hook_entity_type_behaviors_alter__BEHAVIOR() for behavior "bg_color".
 */
function mymodule_entity_type_behaviors_alter__bg_color(array &$build, \Drupal\entity_type_behaviors\EntityTypeBehaviorInterface $behavior) {
  if ($color = $behavior->getValueByKey('bg_color')) {
    $build['#attributes']['style'][] = 'background-color:' . $color . ';';
  }
}

/** Same, but only for nodes of bundle "article". */
function mymodule_entity_type_behaviors_alter__bg_color__node__article(array &$build, $behavior) {
  $build['#attributes']['class'][] = 'article-has-bg';
}
```

## Theme-function form

The same names work in a theme's `.theme` file with the theme name prefixed, e.g.
`mytheme_entity_type_behaviors_alter__bg_color(&$build, $behavior)`. The module resolves the active theme
and its base themes and calls any matching function (`function_exists` guard).

## Notes

- Hook/function **names are built from the behavior id, entity type id, and bundle** — all developer- and
  admin-defined, not request input.
- Prefer these hooks (or the plugin's own `view()`) over re-reading storage; `$build` already carries
  `#entity_type_behaviors` = `[behavior_id => values]`.
