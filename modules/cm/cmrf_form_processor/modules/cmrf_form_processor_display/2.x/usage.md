<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a display-only "CMRF Display" Webform element that shows a value coming from the CiviCRM Form Processor instead of collecting input.

---

A submodule of **cmrf_form_processor**. It registers a `cmrf_display` Webform element (category "CMRF") that renders a value supplied by the parent's Form Processor handler — typically a calculation output or a retrieved default — as plain markup, a link, or a styled button. The element is marked as an input so it can receive that value, but the parent handler excludes `cmrf_display` elements from what it submits back to CiviCRM, so it is purely presentational. Enable it when a form should show CiviCRM-derived text or a link (for example a computed total or a generated document URL) without asking the user to fill anything in. Governed entirely by the parent handler's configuration.

---

- Add a display-only element to a Webform.
- Show a CiviCRM Form Processor value to the user.
- Render as literal markup, a link, or a button.
- Display a calculation output or default value.
- Present a generated URL as a link or button.
- Style the button with CSS classes.
- Keep the value out of the CiviCRM submission.
- Enable alongside the parent handler.
- Configure via the Webform element settings.
- Depend on cmrf_form_processor.
- Keep disabled if unused.
- Test the rendered output before production.
