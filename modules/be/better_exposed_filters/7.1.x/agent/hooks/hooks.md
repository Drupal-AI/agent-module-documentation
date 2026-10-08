# Hooks

Declared in `better_exposed_filters.api.php`.

## `hook_better_exposed_filters_options_alter(array &$options, ViewExecutable $view, DisplayPluginBase $displayHandler)`
Alter the assembled BEF options array before the exposed form widgets are built — e.g.
force a slider's min/max regardless of the stored config.

```php
function mymodule_better_exposed_filters_options_alter(array &$options, $view, $displayHandler) {
  $options['field_price_value']['slider_options']['bef_slider_min'] = 500;
  $options['field_price_value']['slider_options']['bef_slider_max'] = 5000;
}
```

## Plugin-info alter hooks (from the widget managers)
For each widget type the manager invokes an alter hook on its discovered definitions:
- `hook_better_exposed_filters_better_exposed_filters_filter_widget_info_alter(array &$info)`
- `hook_better_exposed_filters_better_exposed_filters_pager_widget_info_alter(array &$info)`
- `hook_better_exposed_filters_better_exposed_filters_sort_widget_info_alter(array &$info)`

Use these to add, remove or modify available widget plugin definitions.
