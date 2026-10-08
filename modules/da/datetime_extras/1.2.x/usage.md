<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Datetime Extras extends core's Datetime and Datetime Range fields with a **time-only field type**, extra **field widgets** (a date-only select list, a configurable date/time widget, and a start-time-plus-duration range widget), and a matching time formatter.

---

Datetime Extras adds plugins on top of core `datetime`/`datetime_range` — it has no settings form, no configure route, no permissions, and no services; everything is configured per field on *Manage form display* / *Manage display*. It introduces one **field type**, `time_only_field` (stores only a time, `datetime_type: time`), with its own widget and formatter (both `time_only_field_default`). For core `datetime` fields it adds two widgets: `datetime_datelist_no_time` ("Select list, no time") which shows date-part select lists with no time element (core only offers a datelist *with* time), and `datatime_configurable` ("Configurable Date and time") which exposes `year_range` and `increment` settings; a third widget `datatime_extras_configurable_list` ("Configurable list") is deprecated. For core `daterange` fields it adds `daterange_duration` ("Date and time range with duration"), letting an editor set a start and then either an absolute end (like core) or a relative **duration** — this widget requires the contrib `duration_field` module (>= 8.x-2.0-rc3) and is hidden by `hook_field_widget_info_alter()` until it is present. All configuration is stored as field storage/widget/formatter settings in the field and `entity_form_display`/`entity_view_display` config; there is nothing global to set.

---

- Store a time-of-day value (e.g. opening time) with no date using the `time_only_field` field type.
- Display a core datetime field as date-only select lists when the time is irrelevant.
- Let editors pick a date via day/month/year dropdowns without a time input.
- Offer a configurable year range (e.g. `-3:+3`) on a datetime widget.
- Set minute increments (e.g. every 15 minutes) on a datetime select widget.
- Capture an event's start plus a duration (2 hours) instead of an explicit end time.
- Let content creators choose between an absolute end date/time and a relative duration on a range field.
- Default a new range field to a preset duration (e.g. 1 hour) with `default_duration`.
- Constrain duration entry granularity (years/months/days/hours/minutes) on a range widget.
- Show a store's daily opening/closing times as standalone time fields.
- Record a recurring reminder time-of-day independent of any calendar date.
- Present a "select list, no time" widget on a birthday or publish-date field.
- Format a time-only field with a chosen date format and optional timezone override.
- Replace the core datelist-with-time widget where seconds/hours add noise.
- Build a booking form where the editor sets start + length rather than start + end.
- Provide a friendlier configurable date picker with a bounded year range for historical dates.
- Use minute increments to keep appointment slots aligned (e.g. :00/:15/:30/:45).
- Add a time-only "office hours" field to a location content type.
- Migrate legacy time-of-day strings into a proper `time_only_field`.
- Keep a datetime field's editing UI to just the date while still storing a datetime.
- Set a duration widget's `time_increment` so the time part snaps to fixed steps.
- Configure the deprecated "Configurable list" widget on an existing site that already uses it.
- Present event schedules with a start time and human-entered duration in the editor.
- Standardise date-only entry across content types without writing a custom widget.
- Combine a time-only field with core date fields to model separate date and time inputs.
