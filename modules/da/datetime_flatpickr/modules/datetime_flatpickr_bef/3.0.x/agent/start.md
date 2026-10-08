<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datetime Flatpickr for BEF — agent index

Submodule of `datetime_flatpickr`. Adds one **Better Exposed Filters** widget, `bef_flatpickr`, so a
Views exposed **date** filter can be shown as a flatpickr picker. No config, permissions, routes, or
Drush of its own. Depends on `better_exposed_filters`, `datetime`, `datetime_flatpickr`.

- **The `bef_flatpickr` widget: applicability, how to select it, where it's stored in the view** →
  [configure/bef-widget.md](configure/bef-widget.md)

Key facts:
- BEF widget plugin id `bef_flatpickr` (class `FlatpickrDateBef extends FilterWidgetBase`), label
  "Date Picker with Flatpickr"; `isApplicable()` restricts it to non-grouped Views Date filters.
- Selecting it is stored in the view display's exposed_form options at
  `exposed_form.options.bef.filter.<filter_id>.plugin_id: bef_flatpickr`.
- Reuses `DateTimeFlatPickrWidgetTrait` for its settings; `exposedFormAlter()` renders the exposed
  element via the parent module's `datetime_flatpickr` form element (single and min/max cases).
