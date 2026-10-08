# Diff hooks

Documented in `diff.api.php`. Both let you alter plugin definitions after discovery.

## hook_field_diff_builder_info_alter(array &$diff_builders)
Alter registered FieldDiffBuilder plugins, keyed by machine name.
```php
function mymodule_field_diff_builder_info_alter(array &$diff_builders): void {
  $diff_builders['text_field_diff_builder']['label'] = t('New label');
}
```

## hook_diff_layout_builder_info_alter(array &$diff_layouts)
Alter registered DiffLayoutBuilder plugins, keyed by machine name.
```php
function mymodule_diff_layout_builder_info_alter(array &$diff_layouts): void {
  $diff_layouts['my_layout']['label'] = t('New label');
}
```

To add (rather than alter) a builder or layout, create a plugin instead — see
[../plugins/plugins.md](../plugins/plugins.md).
