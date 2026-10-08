Views Fields On/Off adds a Views field and a Views filter that let site visitors selectively show or hide chosen fields (columns) of a View at view-time through the exposed form.

---

The module provides two exposed Views handlers, both plugin id `views_fields_on_off_form`: a
**field** handler (`Global: On/Off Form`, `Plugin/views/field/ViewsFieldsOnOffForm`) and a **filter**
handler (`Global: On/Off Filter`, `Plugin/views/filter/ViewsFieldsOnOffForm`, extends Views'
`InOperator`). In the handler's options you pick which of the View's other fields the visitor may
toggle, the exposed input widget (`checkboxes`, `radios`, single `select`, or `multi_select`), and
(field handler) whether those fields are shown by default. At view-time the module reads the visitor's
selection from the request (`_views_fields_on_off_get_selected()` checks POST then GET) and, in
`hook_views_pre_view()`, marks the non-selected fields with `exclude = 1` so Views omits them from the
render — it never adds fields to the query (both handlers implement an empty `query()`), it only
excludes already-configured fields, so no hidden data is exposed. The filter handler additionally
supports a **Bypass hook_views_pre_view()** option that instead defers to
`hook_preprocess_views_view()` (needed so modules like Charts, which read fields earlier, still work),
and an `in`/`not in` operator to invert the selection. A hidden `fields_on_off_hidden_submitted`
marker distinguishes "form submitted with nothing checked" from "fresh page load". Config schema is
provided for both handlers; there is no global settings page and no permission.

---

- Let visitors choose which columns of a table View to display.
- Add a checkbox set in the exposed form to toggle individual fields on or off.
- Offer radios so a visitor picks exactly one field to show.
- Use a single or multiple select widget to control visible fields.
- Hide a set of fields by default and let users opt in to showing them.
- Show a set of fields by default and let users hide the ones they don't want.
- Pair with Views Data Export so users export only the columns they selected.
- Combine with the Charts module to let users choose which series/columns to chart.
- Reduce a wide report to just the columns a given visitor cares about.
- Invert the selection with the filter's `not in` operator (selected fields are the ones hidden).
- Keep the toggle working with AJAX-enabled Views (reads POST) and non-AJAX (reads GET).
- Let users deep-link a column selection by sharing the GET query string.
- Provide a "customize this table" experience without custom code.
- Use the filter variant when you need Views' exposed-filter grouping/identifier features.
- Use the field variant for a simpler always-exposed field toggle.
- Bypass `hook_views_pre_view()` so early-reading modules (Charts) see the toggled fields.
- Offer per-display field toggling on multiple displays of the same View.
- Simplify a dense administrative listing for different editor audiences.
- Let anonymous users tailor a public data table to their needs.
- Manage the handlers' settings in exported View config (`views_fields_on_off_form`).
