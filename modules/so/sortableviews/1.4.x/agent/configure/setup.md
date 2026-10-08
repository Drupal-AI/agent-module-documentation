# Make a View sortable

There is **no admin settings page** — you configure everything inside the View.

## Steps

1. **Ensure a spare integer field** exists on the entity type to store the weight (a normal
   integer field, e.g. `field_weight`, or an existing spare integer base field). This is
   where order is persisted.
2. **Set the View Format** to one of the sortable styles: *Sortable unformatted list*
   (`sortable_default`), *Sortable HTML List* (`sortable_html_list`), or *Sortable table*
   (`sortable_table`).
3. In the style **settings**, set **Weight field** (`weight_field`) to the view field that
   maps to your integer field.
4. **Add the weight field** to the view as a field (so `weight_field` can reference it) and
   **also add it as a Sort criterion** (ASC or DESC) so rows render in stored order.
5. **Add the drag-handle field**: *Sortableviews: Drag and drop handle.*
   (`sortable_views_handle`).
6. **Add the save area**: put *Save Sortableviews changes* (`save_sortable_changes`) in the
   view **header or footer**. This is the button users click to persist a new order.

The view is now sortable for any user with `update` access to the listed entities and their
weight field.

## Doing it in config (shape)

A display's `display_options` needs, at minimum, the sortable style with a `weight_field`:

```php
$view = \Drupal\views\Entity\View::load('my_view');
$display = $view->get('display');
$display['default']['display_options']['style'] = [
  'type' => 'sortable_default',
  'options' => ['weight_field' => 'field_weight'],   // the view field id
];
$view->set('display', $display)->save();
```

(Plus the `field_weight` field, the `sortable_views_handle` field, the `save_sortable_changes`
area, and a sort on `field_weight` for a working setup.)

## Behavior notes

- Saving a new order **overwrites** each entity's weight with its new index.
- Works across pagers (indices are adjusted server-side).
- Avoid two sortable views over the same entity type/bundle (weight conflicts).
