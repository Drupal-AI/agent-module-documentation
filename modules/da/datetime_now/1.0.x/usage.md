Datetime Now adds a small **"Now"** button beside core Date/time edit widgets that, when clicked, fills the date and time inputs with the current date and time in the user's browser timezone.

---

The module is a zero-configuration widget enhancement for core's `datetime` module. It has no settings form, no configure route, no permissions, no Drush commands, and no plugins. It works by implementing `hook_element_info_alter()` to append a `#process` callback (`DatetimeElementInfoAlter::process`) to the core **`datetime` form element**. That callback wraps the element with a `datetime-now-wrapper` class and injects a `#type => button` labelled "Now" carrying a `data-date-selector` pointing at the element's date/time inputs, then attaches the `datetime_now/datetime_now` JS library. The bundled JavaScript listens for clicks on the `.datetime-now` button and sets the date input to today and the time input to the current time (respecting the time input's HTML5 `step`, so it drops seconds when `step` is a multiple of 60). Because it targets the core `datetime` render element, the button appears automatically on **every** widget built from that element — the `datetime_default` ("Date and time") widget and the Datetime Range **daterange_default** widget (both start and end) — across all entity types and bundles, with no per-field opt-in. It does **not** appear on the `datetime_datelist` ("Select list") widget, which renders the separate `datelist` element rather than `datetime`.

---

- Give content editors a one-click "Now" button to stamp the current date/time into a Date/time field.
- Speed up entering a "Published on" datetime without typing the date and time by hand.
- Let editors set an event's "start" time to the exact current moment while creating it.
- Fill both the start and end inputs of a Datetime Range field to "now" with two clicks.
- Reduce data-entry errors on datetime fields by using the browser clock instead of manual typing.
- Provide a "log the current time" affordance on a workflow or moderation datetime field.
- Stamp "received at" / "created at" style datetime fields quickly during content entry.
- Speed up test/demo content creation where any current timestamp will do.
- Offer a friendlier datetime widget UX site-wide with no configuration.
- Set a "reminder time" datetime field to now as a starting point, then adjust.
- Fill a booking or appointment datetime field with the present time as a default.
- Let editors record "when this happened" on a media or user-profile datetime field.
- Add the Now button to a Commerce or custom entity's datetime field automatically.
- Standardise quick datetime entry across every content type at once (global, no opt-in).
- Respect the widget's seconds setting: the Now value omits seconds when the input step is 60.
- Populate a "deadline" field's time to the current moment before choosing a due date.
- Give non-technical editors an obvious button rather than expecting them to know the format.
- Improve accessibility of datetime entry by not forcing exact keyboard input.
- Use on the Datetime Range daterange_default widget for scheduling start/end pairs.
- Roll out consistent "set to now" behaviour by simply enabling the module — nothing else.
- Complement DateTime Hide Seconds: the Now value honours the same `step=60` seconds trimming.
- Set a survey/form submission timestamp field to now during manual entry.
- Provide a quick current-time fill on any custom entity form that uses the datetime element.
- Avoid writing a custom widget just to add a "current time" shortcut button.
