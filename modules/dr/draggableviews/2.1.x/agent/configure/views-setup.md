# Set up a draggable, sortable view

DraggableViews has no admin settings page — you configure it entirely inside a View.

## The two handlers it provides
- **Field** `Draggableviews: Content` (`@ViewsField("draggable_views_field")`) — renders the
  drag handle / weight form element. Machine key on the display becomes `draggableviews`.
- **Sort** `Draggableviews: Weight` (`@ViewsSort("draggable_views_sort_default")`) — orders
  rows by the saved weight. It references the display that owns the saved order.

## Recommended setup
1. Create a View of your entity (Content, Media, Users, …), display format **Table**.
2. Add the field **Draggableviews: Content** to the display that editors will drag on.
   Add it to *this display only* (override) if you have multiple displays.
3. Add the sort **Draggableviews: Weight** (ascending) and make it the first sort criterion;
   remove default date/title sorts (or order them below it).
4. In the sort settings, "Display sort as" points at the view+display that stores the order —
   this lets a page and a block share (or not share) the same manual order.
5. Save. The table rows now show drag handles and a **Save order** button appears (for users
   with `access draggableviews`).

## How it renders / saves
- `draggableviews_form_alter()` attaches the `draggableviews/draggableviews` JS library,
  hides the default submit, and adds the **Save order** button.
- `draggableviews_preprocess_views_view_table()` adds the `draggable` class to rows and
  indents child rows using `DraggableViews::getDepth()`.
- On save, `draggableviews_views_submit()` deletes and re-inserts rows in
  `draggableviews_structure` keyed by `view_name` + `view_display` + `args` + `entity_id`,
  then invalidates the entity list cache tags plus `config:views.view.<name>[.<display>]`.
- Any entity type exposed to Views is supported automatically — `hook_views_data_alter()`
  joins every entity base table to `draggableviews_structure`.
- Ordering is per-arguments (`args` column), so the same content can hold different orders
  under different contextual-argument values.
