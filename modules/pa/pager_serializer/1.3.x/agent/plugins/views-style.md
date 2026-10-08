# The `pager_serializer` Views style

`src/Plugin/views/style/PagerSerializer.php` — `@ViewsStyle(id = "pager_serializer",
title = "Pager serializer", display_types = {"data"})`, extending
`\Drupal\rest\Plugin\views\style\Serializer`. It is a **plugin instance** of core's Views style
plugin type; the module defines no new plugin type.

## Use it on a view

1. Create/edit a View with a **REST export** display (requires the core `rest` module).
2. In **Format**, set the style to **Pager serializer** (instead of "Serializer").
3. Choose accepted formats (json, xml, …) as usual.
4. Add a pager (Full, Mini, "Display a specified number", or "Display all items").

The endpoint then returns rows + pager metadata per `pager_serializer.settings`
(see [../configure/settings.md](../configure/settings.md)).

## render() behaviour

- Iterates `view->result`, renders each with the row plugin, and passes each output through
  `hook_pager_serializer_row_alter()` (see [../hooks/row-alter.md](../hooks/row-alter.md)).
- Builds the pager array from `view->pager`:
  `getItemsPerPage()`, `getTotalItems()`, `getPagerTotal()` (→ total_pages),
  `getCurrentPage()` (→ current_page).
- Assembles the result: `{ rows_label: rows, pager_label: pagination }` when
  `pager_object_enabled`, else merges the pager fields onto the top level and adds `rows_label`.
- Serializes with the display's content type (falls back to `json` in live preview).

## Pager-type normalisation

- Pager class `Drupal\views\Plugin\views\pager\None` ("Display all items") → `items_per_page`
  is set to the total item count.
- Pager class `Drupal\views\Plugin\views\pager\Some` ("Display a specified number") →
  `total_items` is set to the number of rendered rows.
- If the view has **no** pager object, `pagination()` returns NULL (no pager data).

Each pager field is only included when its `*_enabled` flag is true, under its `*_label`.
