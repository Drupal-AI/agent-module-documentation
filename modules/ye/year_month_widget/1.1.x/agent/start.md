<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Year/Month Widget — agent index

One field widget for core `datetime` fields that renders only a **year** and **month** dropdown
(a restricted `datelist`), no day. Depends on core `datetime`. No config page (`configure` null),
no permissions, no Drush, no new plugin types.

- **Selecting the widget, its two settings (`part_order`, `year_range`), storage & Drush** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Widget plugin: `#[FieldWidget(id: 'year_month_widget', field_types: ['datetime'])]`,
  `src/Plugin/Field/FieldWidget/YearMonthWidget.php`, extends core `DateTimeWidgetBase`.
- Renders `#type => 'datelist'` with `#date_part_order` = `['year','month']` or
  `['month','year']`; optional `#date_year_range` from the `year_range` setting.
- Settings (schema `field.widget.settings.year_month_widget`): `part_order` (`YM`|`MY`,
  default `YM`) and `year_range` (e.g. `-3:+1`, `2000:2010`, `2000:+3`; validated by
  `validateYearRange()` against `/^[+-]?\d{1,4}:[+-]?\d{1,4}$/`).
- Stored on a normal `datetime` field, so the saved value is still a full datetime (day/time
  defaulted); Views/tokens/etc. keep working.
