# Hooks — alter the active / default sort

Defined in `search_api_sorts.api.php`. Both receive a mutable
`Drupal\search_api_sorts\SortsField` value object (`getFieldName()/setFieldName()`,
`getOrder()/setOrder()` where order is normalised to `asc`/`desc`) and the Search API
`DisplayInterface`.

## `hook_search_api_sorts_active_sort_alter(SortsField $sort, DisplayInterface $display)`

Called only when there **is** an active sort (a `?sort=` in the request), from
`SearchApiSortsManager::getActiveSort()`. Rewrite the field/order the visitor selected.

```php
function mymodule_search_api_sorts_active_sort_alter(SortsField $sort, DisplayInterface $display) {
  // Anonymous users sort on a different price field.
  if ($sort->getFieldName() === 'price' && \Drupal::currentUser()->isAnonymous()) {
    $sort->setFieldName('price_anonymous');
    $sort->setOrder('desc');
  }
}
```

## `hook_search_api_sorts_default_sort_alter(SortsField $sort, DisplayInterface $display)`

Called from `getDefaultSort()` to alter the fallback sort used when no explicit sort is chosen.
If your active-sort logic should also apply to the default, implement both.

```php
function mymodule_search_api_sorts_default_sort_alter(SortsField $sort, DisplayInterface $display) {
  $sort->setFieldName('title');
  $sort->setOrder('desc');
}
```
