Time Range provides a single field **widget** (`time_range`) for core's Date range (`daterange`) field type that shows only *start time* and *end time* inputs — the date part is hidden.

---

The module adds one `@FieldWidget` (id `time_range`, label "Time range") that applies to the
core `daterange` field type. It extends the core Datetime Range widget base but forces each
delta's start (`value`) and end (`end_value`) elements to render as time-only HTML5 inputs
(`#date_date_element = 'none'`, `#date_time_element = 'time'`, pattern from the `html_time`
date format). It stores **no data of its own** — storage is entirely core's Date range field;
this is purely a *manage form display* change. The widget exposes two settings, `start_label`
and `end_label` (defaulting to "Start time" / "End time"), which retitle the two inputs. To use
it you create a Date range field with the *Date and time* type, then on the bundle's *Manage
form display* switch that field's widget to **Time range**. Because only the time element is
shown, editors pick just hours/minutes for a start and an end; if you also want to hide the
date on output, change the field's display format separately. Requires core Datetime and
Datetime Range. (Note: the `time_range.module` file also contains a legacy
`time_range_field_widget_info()` function that is inert; the real widget is the plugin class.)

---

- Capture a daily opening-hours window (e.g. 09:00–17:00) without exposing a date picker.
- Record event start/end times on a Date range field while ignoring the date component in the form.
- Let editors enter a time slot (start + end) with two labelled HTML5 time inputs.
- Rename the two inputs to domain terms like "Opens" / "Closes" via `start_label` / `end_label`.
- Simplify a booking form so staff only choose start and end times.
- Add shift start/end times to a "Shift" content type using a single Date range field.
- Collect class or session times (start–end) on a course node.
- Provide a compact time-only editing UX on top of core Date range storage.
- Reuse core Date range validation (end must be after start) for time windows.
- Configure per form mode: use Time range on the default form, a different widget elsewhere.
- Present whole-minute time entry using the browser's native time input.
- Avoid building a custom field type just to capture a start/end time pair.
- Standardise time-slot entry across multiple content types by selecting the same widget.
- Enter appointment windows (from–to) on a scheduling entity.
- Model "available from / available to" times on a profile or resource.
- Keep the stored value as a full datetime range while only editing the time portion.
- Swap an existing Date range field's widget to Time range without changing its data.
- Localize the two input titles for a translated editorial UI.
- Offer a cleaner alternative to the default Date range widget when only times matter.
- Combine with a view or formatter that shows only the time to hide the date end-to-end.
- Use on media, taxonomy term, or user forms that carry a Date range field.
- Deploy the widget choice as exported form-display config for consistent environments.
