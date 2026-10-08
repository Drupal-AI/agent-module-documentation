# Sortable Views — Views plugins & save flow

The module registers Views plugins/handlers; it defines no plugin *types* of its own.

## Style plugins (pick one as the view's Format)

| Plugin id | Label | Notes |
|---|---|---|
| `sortable_default` | Sortable unformatted list | Like core "Unformatted list". Option: `weight_field`. |
| `sortable_html_list` | Sortable HTML List | Ordered/unordered list. Options: `type`, `wrapper_class`, `class`, `weight_field`. |
| `sortable_table` | Sortable table | Like core "Table" (columns, sorting, sticky, caption…) plus `weight_field`. |

The `weight_field` style option is the **id of the view field** that stores each row's weight
(it must map to a real integer field on the entity). It is read by the access check and by
`AjaxController` to know which field to write.

## Handlers added to every entity base table

Added via `hook_views_data_alter()` for each entity type's data/base table:

| Handler | Views id | Add it as | Purpose |
|---|---|---|---|
| Drag handle | `sortable_views_handle` | a **field** ("Sortableviews: Drag and drop handle.") | Renders the tabledrag grip users drag. `click sortable = FALSE`. |
| Save button | `save_sortable_changes` | a **header or footer area** ("Save Sortableviews changes") | Renders the Save button; appears only after rows move. |

## Save flow

1. JS (`js/sortable.js`, library `sortableviews.sortable`, deps `core/drupal.ajax`,
   `core/sortable`) tracks drag order and, on Save, POSTs to route `sortableviews.ajax`
   (`/sortableviews/ajax`) with `view_name`, `display_name`, `current_order`, pager info, etc.
2. The `_sortableviews` access check (`SortableviewsAccess`) loads the view, resolves the
   base entity type, reads `weight_field` from the display's style options, and requires the
   current user to have `update` access to **each** entity and to its weight field. On
   success it stashes `entity_type` and `weight_field` on the request.
3. `AjaxController::ajaxSave()` loads the entities in the (pager-adjusted) order and writes
   each entity's array index into its `weight_field`, then `save()`s it. Returns an AJAX
   response confirming "Changes have been saved." and clears the unsaved-change highlight.

## Theming

Theme hook `sortableviews_handle` (template `sortableviews-handle.html.twig`) renders the
handle; it attaches `core/drupal.tabledrag`.

## Gotchas

- The entity type must have a **spare integer field/base field** to hold the weight.
- Sorting **overwrites** whatever weight an entity had; weight conflicts can occur if two
  sortable views target the same entity type/bundle.
- The theme's `views-view.html.twig` must include the `.view-content` wrapper (Stable-based
  themes may need it added) for the JS to find the rows.
