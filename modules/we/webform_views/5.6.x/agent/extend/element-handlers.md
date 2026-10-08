# Element → Views handler system

Each webform element is mapped to a set of Views handlers so its value can be shown/filtered/
sorted. The classes live in `src/WebformElementViews/` (e.g. `WebformSelectViews`,
`WebformDateTimeViews`, `WebformCompositeViews`, `WebformEntityReferenceViews`,
`WebformManagedFileViews`, `WebformDefaultViews` as the fallback), each implementing
`WebformElementViewsInterface`.

## Default mapping
`webform_views.module` registers defaults in `hook_webform_element_info_alter()`
(`webform_views_webform_element_info_alter()`): it stamps each element definition with the
handler class to use. **To set the default handler for a new/custom element type**, implement
`hook_webform_element_info_alter()` in your module and add the same property pointing at your
`WebformElementViewsInterface` class.

## Per-element / per-webform override
Documented in `webform_views.api.php`:

```php
/**
 * Implements hook_webform_views_element_views_handler().
 * Override the views handler class for a specific element on a specific webform.
 */
function mymodule_webform_views_element_views_handler(&$views_handler_class, $element, \Drupal\webform\WebformInterface $webform) {
  if ($webform->id() === 'my_special_webform' && $element['#webform_key'] === 'my_element') {
    $views_handler_class = '\Drupal\mymodule\WebformElementViews\MySpecialHandler';
  }
}
```

- Use `hook_webform_element_info_alter()` to change the default for an element *type*
  everywhere.
- Use `hook_webform_views_element_views_handler()` to override for a *single* element/webform
  without affecting others.
- A handler class declares which Views field/filter/sort plugins the element exposes and how
  its (possibly multi-valued or composite) data is joined; model new ones on the existing
  `src/WebformElementViews/*` classes.
