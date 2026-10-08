<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DateTime Reset adds an optional per-widget "Reset" button to core Datetime field widgets that clears the date and time inputs with one click.

---

DateTime Reset is a small form-display helper for core Datetime fields. It adds a "Reset button" checkbox to the third-party settings of any DateTime widget (any widget extending core's `DateTimeWidgetBase`) on the *Manage form display* screen. When the setting is on, the widget renders a small "Reset" button next to the date/time inputs; a lightweight JavaScript behavior clears the `input[type="date"]` and `input[type="time"]` values in that widget container on click, without submitting the form. It handles single-value date fields, the paired value/end_value inputs of Date range fields, and SmartDate's `time_wrapper` structure. The module has no routes, permissions, services, or plugins — it is purely hook implementations plus one JS behavior and config schema for the widget setting. Depends only on core `datetime`.

---

- Add a "Reset" (clear) button to a Date, Date/Time, or Date range field's edit widget.
- Let content editors empty an optional datetime field in one click instead of manually deleting the date and time values.
- Enable the button per field, per form display, via the widget's third-party settings gear on *Manage form display*.
- Provide a clear control for event start/end date fields that are frequently left blank.
- Improve UX on booking, scheduling, or deadline fields where "no date" is a valid choice.
- Turn clearing on for the end date of a Date range while leaving the start date required.
- Apply the reset control to SmartDate widgets (the module marks the `time_wrapper` value/end_value inputs).
- Keep the reset action client-side only — clicking Reset empties the inputs but does not submit or save until the editor saves the form.
- Add the control without writing any code — it is a checkbox in the existing widget settings summary.
- Show a "Display reset button." / "No reset button." line in the Manage-form-display widget summary to confirm the setting.
- Store the setting as a boolean third-party widget setting (`datetime_reset.reset`) exported with the form display config.
- Roll the feature out selectively to only the content types/bundles that need it.
- Give editors a consistent clear affordance across all datetime widget types on a site.
- Reduce data-entry errors from partially-cleared datetime fields (date left, time removed, or vice versa) by clearing both inputs together.
- Pair with optional datetime fields so a saved-then-unwanted value can be removed without re-typing.
- Use on multi-value (unlimited cardinality) datetime fields where individual rows may need clearing.
- Enable on Date range fields to clear both the start and end inputs of a widget row at once.
- Deploy the setting through configuration (form display YAML) as part of a site's config management.
- Provide the same control on any contrib widget that extends core `DateTimeWidgetBase`.
- Attach only the module's small JS library (depending on `core/drupal.ajax`) to pages where a reset-enabled datetime widget is present.
