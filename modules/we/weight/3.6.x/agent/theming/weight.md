# Drag-and-drop reorder in a Views table

Weight ships a Views integration that turns an ordinary **table** View into a draggable
reorder form and writes the new weights back to each entity.

## How to build it

1. Add the weight field to the bundle you want to order (see [../configure/weight.md](../configure/weight.md)).
2. Create a View of those entities with the **Table** format.
3. Add the field to the View and choose the **Weight Selector** field handler — in the field
   list it appears as *"<label> Selector (<field_name>)"*. Its Views plugin id is
   `weight_selector`, its handler class `Drupal\weight\Plugin\views\field\WeightSelector`.
4. The handler exposes its own **Range** option (default `20`), independent of the field's
   own range setting.

## What makes it draggable

- `weight_field_views_data()` (`weight.views.inc`) swaps the field's default Views handler for
  the `weight_selector` handler.
- The handler renders a `<select>` (class `weight-selector`) per row inside a Views form, and
  on submit (`viewsFormSubmit`) sets the weight on each row's entity — using the row's
  translation when a langcode is present — and saves it, showing "Your changes have been saved."
- `hook_preprocess_views_view_table()` (`weight.module`) detects the `weight_selector` column
  and calls `drupal_attach_tabledrag()` with `action: order`, `relationship: sibling`,
  `group: weight-selector`, adding the `draggable` class to each row. If the selector is the
  first column it is moved to the last column so the drag handle renders correctly.
- Grouped tables get a unique `table_id` per group (`weight-table-<dom_id>-row-<key>`), so each
  group is independently draggable.

## Theming surface

- No custom Twig templates or theme hooks are declared; the module hooks core's existing
  `views-view-table` template via preprocess and reuses core's tabledrag JS/CSS.
- Views config schema for the handler: `views.field.weight_selector` (adds a `range` mapping).
