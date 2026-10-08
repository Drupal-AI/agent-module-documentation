Sortable Views lets site users reorder the rows of a View by drag-and-drop and saves the new order straight into an integer field on each entity. It is a lighter alternative to Draggable Views that stores weights on the entity via the Field API instead of in its own table.

---

The module ships three Views **style plugins** — `sortable_default` (unformatted list), `sortable_html_list` (ordered/unordered list) and `sortable_table` — each of which exposes a `weight_field` style option naming the field where row order is stored. Via `hook_views_data_alter()` it also adds two handlers to every entity base table: a field handler `sortable_views_handle` ("Sortableviews: Drag and drop handle.") that renders the drag grip, and an area handler `save_sortable_changes` ("Save Sortableviews changes") that renders the Save button (which only appears once rows have been moved). The JavaScript (built on core `Sortable` and `drupal.ajax`) posts the new order to the `/sortableviews/ajax` route; `AjaxController::ajaxSave()` writes the new index into the configured weight field of each entity and saves them, adjusting indices for the view's pager. A custom access check (`_sortableviews`) verifies the request parameters, that the weight field is set on the display, and that the current user has `update` access to each entity and to its weight field — so it reuses core entity permissions rather than adding its own. To build a sortable view you: pick one of the three sortable styles, tell it which integer field stores the weight, add that weight field as a sort criterion, add the drag-handle field, and add the "Save Sortableviews changes" header/footer area. The module has no settings page, permissions, or Drush commands; all configuration lives in the View.

---

- Let editors drag-and-drop the rows of an admin content view into a custom order.
- Manually order a "Featured articles" list and persist the order on the nodes.
- Reorder taxonomy terms, media, or any entity that has a spare integer field.
- Replace Draggable Views while storing weights directly on entity fields (no extra table).
- Build a curated homepage list whose order editors control without touching config.
- Sort a menu-like list of promoted content by drag handle.
- Persist order across page loads by writing weights into an entity integer field.
- Provide a Save button that only appears after rows are moved.
- Reorder rows within a paginated view (indices are adjusted for the pager).
- Add drag-and-drop ordering to an existing table view via the `sortable_table` style.
- Use an unformatted sortable list (`sortable_default`) for card-style layouts.
- Use a sortable HTML list (`sortable_html_list`) for ordered/unordered list output.
- Control who can reorder by relying on core entity `update` access (no new permission).
- Order products in a catalog view by weight for storefront display.
- Let event organizers arrange sessions in a schedule view.
- Keep the sort order queryable/sortable elsewhere because it lives in a real field.
- Reorder image gallery items and store the position on each media entity.
- Give content teams a no-code way to reorder listings.
- Combine the weight field as both storage and a view sort criterion for stable ordering.
- Reorder rows and immediately AJAX-save without a full page reload.
- Apply drag ordering to multiple entity types (each with its own weight field).
- Prototype ordering UIs quickly using the shipped style plugins.
- Migrate ordering data easily since weights are plain entity field values.
