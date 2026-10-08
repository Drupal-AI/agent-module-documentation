# Build a view of webform submissions

No admin form — you work in the Views UI (`/admin/structure/views`).

## Create the view
1. Add view → base table **Webform submission** (Views data added by
   `src/WebformSubmissionViewsData.php`).
2. Add a **filter** on the webform (or use the per-webform results tab, below) so the view
   targets a specific form — element columns only make sense once the webform is known.
3. Add **fields** for the submission's elements. Each element type resolves to a matching
   handler (select, checkboxes, date/datetime, numeric, entity reference, managed file,
   composite, computed, hidden, term checkboxes, …) from `src/Plugin/views/field/`, so values
   render correctly. Operation fields are available too: edit, view, duplicate, and an
   editable **notes** field.
4. Add **filters/sorts** on those elements — parallel handlers live in
   `src/Plugin/views/filter/` and `src/Plugin/views/sort/` (e.g. select, checkbox, numeric,
   date, composite, entity-reference-select, webform status/category filters).
5. Add a **relationship** to a referenced entity, including reverse entity-reference
   (`src/Plugin/views/relationship/WebformViewsEntityReverse.php`), to join submissions with
   other entities.

## Submission tabs on a webform
The module's `RouteSubscriber` plus `hook_local_tasks_alter()` /
`hook_menu_local_tasks_alter()` surface Views-based results as local-task tabs on a webform
(`webform_views_applicable_views()` finds views that apply to a given webform). This lets a
custom view replace or augment the default results table.

Which handler a given element uses is registered by `hook_webform_element_info_alter()`; to
change it, see [../extend/element-handlers.md](../extend/element-handlers.md).
