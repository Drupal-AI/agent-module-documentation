<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BEF HTML5 Date plugin adds a Better Exposed Filters widget that renders a Views exposed date filter as a native HTML5 date input.

---

BEF HTML5 Date plugin registers a single Better Exposed Filters (BEF) filter-widget plugin (`id: bef_html5_date`,
label "HTML5 Date"). When selected for an exposed Views date filter, the plugin's `exposedFormAlter()` sets the
exposed form element's `#type` to `date` and adds `type="date"` plus a `bef-html5-date` CSS class, so the browser
shows its native HTML5 date picker instead of a plain text field. It handles single-value filters, two-value/ranged
filters (`min`/`max`/`value` subfields), and the wrapper element that core adds around exposed filters. The widget is
offered only for filters that are a Views `Date` plugin (or declare a `date_handler`) and that are not grouped
(`isApplicable()`). The module depends on Better Exposed Filters (`^6 || ^7`); it defines no routes, permissions,
services, config objects, settings form, hooks, or install logic, and does not change query results or access — the
underlying View's access and the filter's own value handling still apply. Choose the widget per-filter under the BEF
"Exposed filter widgets" settings when editing a View.

---

- Render a Views exposed date filter with the browser's native HTML5 date picker instead of a text input.
- Improve date-filter UX on any exposed filter that targets a date field.
- Replace the default text/date-popup input on an exposed filter with `<input type="date">`.
- Apply to a single-value exposed date filter (single `#type: date` element).
- Apply to a two-value or ranged date filter with `min` and `max` inputs.
- Apply to a "between"/operator-exposed filter that produces `value`, `min`, or `max` subfields.
- Add a `bef-html5-date` CSS class hook to the exposed input for custom theming.
- Select the "HTML5 Date" widget per-filter under Better Exposed Filters settings in the Views UI.
- Keep the exposed filter's underlying operator and value handling unchanged (only the widget changes).
- Use on Views date filters exposed in blocks, pages, or attachments.
- Offer a consistent native date control across desktop and mobile browsers.
- Avoid loading jQuery UI datepicker for exposed date filters.
- Combine with other BEF widgets on the same exposed form (per-filter choice).
- Restrict availability to genuine date filters via `isApplicable()` (not shown for non-date or grouped filters).
- Work with filters that declare a `date_handler` even if not the core `Date` filter class.
- Preserve the View's access control — the widget shapes input only, not results or permissions.
- Drop-in with no configuration: enable the module and pick the widget; nothing else to set up.
- Extend Better Exposed Filters without patching BEF core.
- Provide a lightweight, dependency-free (beyond BEF) native date input for content editors and site visitors.
- Support Drupal 9.3+, 10, and 11 sites using BEF 6 or 7.
