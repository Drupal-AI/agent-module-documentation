Webform Views Integration exposes webform submissions (and their individual element values) to the Views module, so you can build custom listings, reports, and dashboards of submission data with Views fields, filters, sorts, and relationships.

---

Core Webform stores submissions but only offers its own fixed results table; this module makes that data available to Views. It adds Views data for the webform submission entity and, crucially, maps each webform **element** to a matching Views handler so a submission field (select, checkboxes, date, numeric, entity reference, managed file, composite, computed, hidden, term checkboxes, …) can be shown as a column, filtered, and sorted with type-appropriate logic. It provides field, filter, sort, and relationship plugins under `src/Plugin/views/`, including reverse entity-reference relationships and edit/duplicate/view operation fields. A route subscriber and `hook_local_tasks_alter` add Views-based results as local-task tabs on webforms, and `hook_webform_element_info_alter` registers the default element-to-handler mapping (overridable per element/webform via `hook_webform_views_element_views_handler`). It depends on Views and Webform (6.2+). A bundled example submodule ships a sample form and view. Because the integration is handler-driven, custom or contrib webform elements can be given their own Views handlers.

---

- Build a custom table/report of webform submissions with Views.
- Show individual webform element values as sortable Views columns.
- Filter submissions by a select/checkbox element value.
- Filter by submission date or a webform date element.
- Sort submissions by a numeric element value.
- Expose a submission listing as a page, block, or feed.
- Add an exposed filter so users can search submissions.
- Replace the default Webform results table with a tailored view.
- Show composite-element sub-values as separate columns.
- Display computed-element results in a view.
- Filter by webform status or webform category across submissions.
- Add edit / view / duplicate operation links per submission row.
- Build a "my submissions" view scoped to the current user.
- Relate submissions to a referenced entity via a reverse relationship.
- Report on managed-file uploads submitted through a webform.
- Filter by term-checkboxes / entity-reference element selections.
- Export submission data by attaching Views Data Export to the view.
- Aggregate submission counts for a dashboard.
- Add submission views as tabs on the webform via local tasks.
- Give a custom webform element its own Views handler.
- Override the Views handler for one element on one specific webform.
- Combine submissions from a webform with other entities in one view.
- Provide editors a filtered, paginated submissions overview.
- Create per-webform reporting pages without custom code.
