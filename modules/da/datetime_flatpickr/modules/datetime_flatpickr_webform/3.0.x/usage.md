<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Datetime Flatpickr that adds a `flatpickr_date` Webform element, letting Webform authors add a flatpickr-powered date/time picker to their forms.

---

`datetime_flatpickr_webform` provides a single Webform element plugin, `flatpickr_date` (label "Flatpickr
Date", category "Date/time elements"), implemented by `FlatpickrDate extends WebformElementBase`. It reuses
the parent module's `DateTimeFlatPickrWidgetTrait`, so the element exposes the same flatpickr settings
(under a "Flatpickr settings" details group on the element edit form) and defaults `dateFormat` to
`Y-m-d`. At render time `prepare()` sets the element `#type` to the parent module's `datetime_flatpickr`
render element, which attaches the flatpickr library/locale and passes the settings to
`drupalSettings.datetimeFlatPickr`. It also supports Webform's standard "multiple" value properties. It has
no config of its own, no permissions, and no routes — it simply registers the element for use in the
Webform UI (`/admin/structure/webform`). Requires `webform`, `datetime`, and `datetime_flatpickr`.

---

- Add a flatpickr calendar date field to a Webform.
- Offer a date-and-time flatpickr picker on a contact or booking webform (enable the time picker).
- Restrict selectable dates on a webform with min/max date settings.
- Disable weekends or specific dates on a webform date question.
- Provide a friendly display format (altInput/altFormat) on a webform date element.
- Use 24-hour time on a webform appointment field.
- Set a minute increment (e.g. 15) on a webform time selection.
- Collect multiple dates in one webform element via the multiple property.
- Localize the webform date picker to the site language automatically.
- Replace the default Webform date element with a lightweight flatpickr picker.
- Configure the picker per element from the Webform "Flatpickr settings" group.
- Build an event registration webform with a constrained date range.
- Add an inline (always-visible) calendar to a webform.
- Reuse the same flatpickr configuration approach as the field widgets, inside Webform.
- Provide consistent date UX between content forms and webforms.
- Let site builders pick "Flatpickr Date" from the Webform element list.
- Set a default date/hour/minute on a webform date element.
- Allow or forbid direct keyboard entry on a webform date field.
- Position the calendar above/below the webform input.
- Show week numbers on a webform calendar.
