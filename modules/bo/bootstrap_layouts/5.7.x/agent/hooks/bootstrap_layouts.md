# bootstrap_layouts — hooks

## `hook_bootstrap_layouts_class_options_alter(&$classes, &$groups)`

Declared in `bootstrap_layouts.api.php`. Alters the grouped list of CSS classes offered in the
layout/region **Classes** select (the list produced by
`BootstrapLayoutsManager::getClassOptions()`). Invoked for both modules and themes
(`$moduleHandler->alter(...)` and `$themeManager->alter(...)`).

- `$classes` — associative array keyed by group machine name; each value is an array of
  `class => human label` pairs.
- `$groups` — associative array of group machine name => group label (used as optgroup labels).

Existing groups: `utility`, `columns`, `hidden`, `visible`, `background`, `text_alignment`,
`text_color`, `text_transformation`.

```php
function hook_bootstrap_layouts_class_options_alter(&$classes, &$groups) {
  // Add theme specific classes.
  $groups['my_theme'] = t('My Theme');
  foreach (['top', 'middle', 'bottom'] as $style) {
    $classes['my_theme']["section-$style"] = t('Section: @style', ['@style' => Unicode::ucfirst($style)]);
  }
}
```

Add a new group, or push extra classes into an existing group (e.g. more `columns` or Bootstrap 5
utility classes), and they become selectable per layout and per region.

## Related alter hooks (invoked, not documented in api.php)

- `hook_bootstrap_layouts_handler_info_alter(&$definitions)` — alter discovered
  `BootstrapLayoutsHandler` plugin definitions (`alterInfo('bootstrap_layouts_handler_info')`).
- `hook_ds_pre_render_alter(&$content, $context, $variables)` — core Display Suite hook invoked
  from the layout preprocess when rendering through DS.
