Calendar Systems BEF adds Persian/Jalali datepicker support to Better Exposed Filters (BEF) exposed date filters, replacing BEF's jQuery UI datepicker with the bundled persian-datepicker when the active calendar is Persian.

---

The submodule swaps BEF's `bef` exposed-form Views plugin class with `CalendarSystemsBef` (a subclass of BEF's `BetterExposedFilters`) via `hook_views_plugins_exposed_form_alter`. In `exposedFormAlter()` it checks the active calendar through `_calendar_systems_factory()`; only when that calendar is `persian` does it strip BEF's `core/jquery.ui.datepicker` / `better_exposed_filters/datepickers` libraries from the exposed form and attach `calendar_systems_bef/picker` instead. That library depends on the parent `calendar_systems/picker` (persian-date + persian-datepicker) and ships a small behavior (`calendar_systems_bef.js`) that initializes a persian datepicker on `.bef-datepicker` inputs, honoring BEF's `datepicker`/`datepicker_options` drupalSettings. It requires both `calendar_systems` and `better_exposed_filters`; it has no config, permissions, routes, or Drush.

---

- Give a Views exposed date filter a Persian/Jalali datepicker popup instead of jQuery UI's.
- Let Farsi-language site visitors pick filter dates in the Shamsi calendar.
- Keep exposed date filters consistent with the site's active calendar via Calendar Systems.
- Replace BEF's default datepicker only when the Persian calendar is active (Gregorian left untouched).
- Provide a self-contained Jalali datepicker for BEF without adding jQuery UI.
- Localize date-range exposed filters in a faceted Views search UI.
- Reuse the parent module's bundled persian-datepicker assets for BEF forms.
- Support Jalali date entry in an exposed filter block placed in a sidebar.
- Maintain BEF's configured datepicker options while switching the widget to persian-datepicker.
- Offer a coherent Jalali filtering experience across exposed filters and field widgets.
- Avoid double-loading jQuery UI datepicker when Calendar Systems' picker is in use.
- Enable Jalali exposed filters on a multilingual site only for the Persian interface language.
- Pair with Calendar Systems' Views date filter swaps for end-to-end Jalali filtering.
- Style the exposed-filter datepicker with the bundled persian-datepicker themes.
- Drop into an existing BEF-powered View with no query or field changes.
