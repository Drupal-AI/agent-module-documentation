# Active Filters hooks

## `hook_active_filters_alter(array &$active_filters, ViewExecutable $view)`

Invoked in `ActiveFilters::render()` right before the active filters are handed to the render-array
builder. `$active_filters` is a flat list of value objects — `ActiveFilter` and (when grouped)
`ActiveFilterGroup`, both extending `ActiveFilterBase`. Use it to relabel, reorder, remove, or replace
chips for a specific view/display.

```php
function mymodule_active_filters_alter(array &$active_filters, \Drupal\views\ViewExecutable $view): void {
  if ($view->id() !== 'my_view') {
    return;
  }
  foreach ($active_filters as $i => $af) {
    if ($af instanceof \Drupal\active_filters\ActiveFilter\ActiveFilter && $af->getName() === 'topic') {
      // Value objects are readonly — rebuild via the factory to change them.
      $active_filters[$i] = \Drupal::service('active_filters.factory')->createActiveFilter(
        t('Topic: @t', ['@t' => (string) $af->getLabel()]),
        $af->getName(),
        $af->getValue(),
        $af->isRemovable(),
        $af->getConfiguration(),
        $af->getFilter(),
        $af->getView(),
      );
    }
  }
}
```

## Value object API (readonly)

`ActiveFilterBase`: `getLabel()`, `getName()`, `getConfiguration()`, `getFilter()` (the
`FilterPluginBase`), `getView()`.
`ActiveFilter` adds: `getValue()`, `isRemovable()`.
`ActiveFilterGroup` adds: `getActiveFilters()` (its child `ActiveFilter[]`).

Objects are immutable — to modify, create a new one with `active_filters.factory`
(`createActiveFilter(...)` / `createActiveFilterGroup(...)`), matching the constructor argument order
above.
