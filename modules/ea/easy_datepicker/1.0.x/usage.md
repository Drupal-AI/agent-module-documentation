<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Datepicker is a lightweight, dependency-free datepicker Form API element (and Webform textfield add-on) with fast day/month/year navigation for distant dates.
---
The module solves the pain of picking historical or far-future dates in the native HTML5 date input by providing a pure-JS widget that drills day → month → year (12 years at a time) with no jQuery or external libraries. It ships a `#type => 'easy_datepicker'` Form API element (a progressively-enhanced textfield), a public `easy_datepicker_attach()` API, and a `hook_webform_element_alter` that attaches the picker to any Webform Text field carrying the `js-easy-datepicker` class; all three paths normalize the submitted value to `Y-m-d` via a strict `DateTime::createFromFormat` element-validate callback that rejects rolled-over dates like 02/30.

Two routes exist: a self-contained read-only demo at `/easy-datepicker/demo` (`access content`) and the settings form at `/admin/config/content/easy-datepicker` (`administer easy_datepicker settings`, restricted) for site-wide min/max/format defaults. Per-field overrides use `data-cdp-*` attributes, and `hook_easy_datepicker_options_alter()` lets code tighten options per field. Set up by configuring defaults, then using the element or adding the CSS class to a Webform textfield.
---
- Add a birthdate field with fast year navigation to a custom form
- Restrict a field to a min/max date range
- Block future date selection (e.g. birthdates)
- Block past date selection (e.g. future appointments)
- Choose display format (mm/dd/yyyy, dd/mm/yyyy, yyyy-mm-dd)
- Set which calendar view opens first (days/months/years)
- Turn a Webform Text field into a datepicker with just a CSS class
- Override site defaults per Webform field via data-cdp-* attributes
- Attach the picker to any custom textfield via easy_datepicker_attach()
- Programmatically tighten options for a field via the alter hook
- Normalize all submitted dates to Y-m-d for consistent storage/export
- Try the widget instantly via /easy-datepicker/demo
- Reject invalid rolled-over dates (02/30) server-side
- Theme the calendar via CSS custom properties
- Provide a WCAG 2.1 AA accessible date picker with keyboard nav
- Set site-wide date defaults for all pickers
- Localize date format based on locale via the alter hook
- Work without JS (graceful textfield fallback with pattern hint)
