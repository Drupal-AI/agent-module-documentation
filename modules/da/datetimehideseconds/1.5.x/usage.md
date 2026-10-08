<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DateTime Hide Seconds adds a per-widget "Hide seconds" toggle to core Date/time field widgets so the time input on entity edit forms only accepts hours and minutes, not seconds.

---

The module is a thin widget-level enhancement for core's `datetime` module. It does not add any field type, widget, settings form, or configuration page of its own. Instead it hooks into the existing Date/time widgets (any widget extending `DateTimeWidgetBase`, i.e. `datetime_default` and `datetime_datelist`, and the Datetime Range widgets) via `hook_field_widget_third_party_settings_form()`, adding a single "Hide seconds" checkbox to the widget settings on any entity's *Manage form display* page. When enabled, the choice is stored as a third-party setting (`datetimehideseconds.hide: true`) on that field's component in the `entity_form_display` config entity. At form build time `hook_field_widget_single_element_form_alter()` reads the setting and flags the `datetime` render element; an `hook_element_info_alter()` process callback then trims the value to `H:i`, sets the HTML5 time input's `step` attribute to `60` (which removes the seconds spinner in supporting browsers), and adjusts the element's time format. The effect is purely on the editing widget — stored values and formatters are untouched — and it has no effect on a date-only field that renders no time input.

---

- Hide the seconds spinner on an event's "start date" datetime field so editors only pick hours and minutes.
- Simplify a "published on" datetime widget where second-level precision is meaningless.
- Clean up a booking form's time input so `HH:MM` is the only thing an editor can enter.
- Enforce minute-granularity time entry on a datetime field without writing custom code.
- Apply hidden seconds to both the start and end inputs of a Datetime Range field at once.
- Configure the toggle per form mode, e.g. hide seconds on the default form but not on a custom "full" form.
- Set the HTML5 `step=60` attribute on a time input so browsers drop the seconds control natively.
- Provide a friendlier time-entry title/hint (e.g. `h:i`) on datetime widgets.
- Standardise time entry across many content types by enabling the setting on each datetime widget.
- Reduce editor confusion where trailing `:00` seconds looked meaningful but were not.
- Keep appointment scheduling widgets constrained to whole-minute slots.
- Trim seconds on a "deadline" field used in a workflow module's form.
- Hide seconds on a user-profile datetime field (e.g. a custom "available from" time).
- Use it on a taxonomy term or media entity datetime field via that entity's form display.
- Migrate an existing site to minute-precision editing UX without altering stored data.
- Combine with core's datetime field storage while presenting a simplified widget.
- Configure via exported config (`third_party_settings.datetimehideseconds.hide: true`) for deployment.
- Toggle the behavior on/off per environment by overriding the form-display config.
- Present a consistent `HH:MM` time UI to editors regardless of browser locale spinner defaults.
- Avoid needing a custom widget plugin just to drop seconds from a datetime input.
- Use on Datetime Range "smart date"-style scheduling where seconds add noise.
- Give content authors a shorter, less error-prone time field.
- Apply to a "reminder time" datetime field on a scheduling entity.
- Keep second data at zero implicitly because the widget never surfaces it.
- Roll out minute-granularity editing to an editorial team through a single checkbox per field.
