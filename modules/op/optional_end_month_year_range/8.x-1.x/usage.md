<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optional End Month Year Range provides a DateRange-based field type whose end date can be omitted, via a per-value "No end date" checkbox.
---
Built on core `datetime` and `datetime_range`, the module defines a field type (`OptionalEndMonthYearRangeItem`), a widget (`OptionalEndMonthYearRangeWidget`) and three formatters (Default, Plain, Custom) plus a field-item-list class. The widget adds a checkbox — whose label ("No end date") is configurable in the field's storage/settings — that lets an editor store a start date with no end, representing open-ended or ongoing ranges (e.g. "2020 – present"). When the box is checked the end value is cleared/omitted; otherwise the field behaves like a normal date range. The formatters render the range accordingly, showing only the start (or a "present"-style output) when no end date is stored.

Setup requires no global configuration: enable the module (core `datetime` and `datetime_range` are dependencies), add a field of this type to any entity/bundle, and choose the widget and a formatter on the form/display. Optionally change the checkbox title in the field settings. Security posture: the module is a **pure field-type/widget/formatter plugin bundle — it ships no routes, permissions, services or config entities**, and stores only date values through the standard Field API. There is no request-handling code, external I/O, or mutating endpoint; access is governed entirely by the host entity's normal field/entity permissions.
---
- Enable the module (requires `datetime` and `datetime_range`).
- Add an "Optional End Month Year Range" field to a content type or other entity.
- Let editors record a start date with no end date via the checkbox.
- Represent ongoing/open-ended periods (e.g. employment "2019 – present").
- Customise the "No end date" checkbox label in field settings.
- Choose the Default, Plain or Custom formatter on the entity display.
- Use the widget on the entity edit form for start + optional end entry.
- Store event or membership ranges that may not have ended yet.
- Model publication or availability windows with an optional close date.
- Combine with Views to list items with or without an end date.
- Migrate existing datetime_range data into an optional-end field.
- Display ranges consistently whether or not an end date is present.
- Record project or role durations that are still in progress.
- Model course or program dates with an as-yet-unknown end.
- Show "start – present" for ongoing engagements on a profile.
- Filter entities in Views by whether an end date exists.
