Extrafield Views Integration exposes Drupal core "extra fields" (display pseudo-fields declared via `hook_entity_extra_field_info`) as selectable fields in Views, rendered through a developer-supplied render class.

---

Core extra fields of type `display` (the pseudo-fields modules add to *Manage display*) normally cannot be added to a View. This module's `hook_views_data_alter()` walks every content entity type and bundle, reads its `display` extra fields, and — for each one that declares an extra **`render_class`** key — registers a Views field named `extrafield_views_integration__<field_name>` backed by the `extrafield_views_integration` `@ViewsField` handler. When that field is placed in a View, the handler's `render()` checks the declared `render_class` exists and calls its static `render($entity)` method, passing the current row's entity (`$values->_entity`); the returned string or render array becomes the field output. The handler runs no query (`query()` is empty), so it is purely a render-time computed column. To use it you implement `ExtrafieldRenderClassInterface` (one static `render(EntityInterface $entity)` method) on a class and reference that class's FQN in the `render_class` key of your `hook_entity_extra_field_info` definition. The module has no settings, no permissions, no schema and no UI beyond the Views field itself; it just needs Views and the Entity API. Extra fields without a `render_class` key are ignored.

---

- Show a core/contrib "display" extra field as a column in a View.
- Render a computed value (e.g. a formatted total, badge, or summary) per row in Views.
- Reuse an entity's Manage-display extra field inside a Views listing.
- Add a derived field to a View without creating a stored field or a Views field plugin.
- Expose a module's pseudo-field (declared via `hook_entity_extra_field_info`) to site builders.
- Output a render array from a static method for each Views result row.
- Build a "call to action" or link column computed from the row entity.
- Display aggregated/related data for an entity in a View via custom PHP.
- Provide site builders a Views field whose logic lives entirely in a render class.
- Add the same extra field to multiple Views without duplicating logic.
- Render entity-derived HTML in a Views table/grid/list column.
- Surface a computed status or label alongside real fields in a View.
- Give an extra field a Views-friendly title and help text automatically.
- Keep presentation logic in one static render class shared by display and Views.
- Show a value that depends on multiple fields of the row entity in a View.
- Add a developer-controlled column to a content-entity View (node, media, user, term, …).
- Integrate a legacy `hook_entity_extra_field_info` field into a new Views report.
- Provide a fallback warning when a configured render class is missing (handled by the module).
- Render per-row markup without writing a full custom Views field plugin.
- Bridge Manage-display pseudo-fields into Views for dashboards and listings.
