<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Single DateTimePicker Range — agent index

Submodule of **single_datetime**. Adds one field widget, `single_date_time_range_widget`
(label "Single Date Time Picker"), for core **Datetime Range** (`daterange`) fields. It renders
both the start (`value`) and end (`end_value`) inputs with the xdan jQuery datetimepicker and
extends the parent's `SingleDateTimeBase`, so it shares every parent widget setting. No configure
route, no settings form, no permissions, no Drush, no config schema.

- **Assign the widget to a daterange field / read where it's stored / the settings it accepts** →
  [configure/range-widget.md](configure/range-widget.md)

Key facts:
- Widget plugin id: **`single_date_time_range_widget`**, `field_types = {daterange}`, class
  `Drupal\single_datetime_range\Plugin\Field\FieldWidget\SingleDateTimeRangeWidget`.
- Requires the parent **single_datetime** module enabled (the widget extends its base class) and
  its xdan library at `/libraries/jquery-datetimepicker`; info.yml only declares `datetime_range`.
- Settings live at `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.type: single_date_time_range_widget` with the same `settings` keys as the
  parent (`hour_format`, `allow_times`, `disable_days`, `exclude_date`, …). See parent docs at
  `../../../../2.0.x/agent/configure/widget-settings.md` for the full settings list.
- Adds a `validateSingleDateTime` element-validate callback: **start date must not be after end
  date**. `massageFormValues()` handles `date`, `allday`, and `datetime` range types.
