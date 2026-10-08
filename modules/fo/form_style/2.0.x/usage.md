<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form Style renders a single page containing (nearly) every common Form API element so themers and accessibility testers can see how forms look and behave in the active front-end theme — the tool used during development of Inline Form Errors, Claro and Olivero.
---
The showcase form lives at `/admin/form_style` and, deliberately, renders in the **front-end theme** (not the admin theme, `_admin_route: FALSE`) so you inspect what real visitors see. Submitting it intentionally triggers validation errors on every element, making it a fast way to review error states, inline error messages and accessibility behaviour all at once. A separate settings form at `/admin/config/form_style` (gated by `administer site configuration`) tunes what is shown.

Security/operational note straight from the module's own README: the showcase route requires only the `access content` permission, so any user who can view content can reach it. This is intentional for a testing tool but means **the module should not be enabled on production sites**. It performs no data mutation beyond form validation, makes no external calls, and stores nothing sensitive.
---
- Visit /admin/form_style to preview all form elements in the active theme.
- Review how textfields, textareas, selects and checkboxes render.
- Inspect radios, date/time, number, range and managed_file widgets.
- Trigger validation on every element by submitting the form.
- Test inline form error (IFE) presentation.
- Audit keyboard and screen-reader accessibility of form controls.
- Compare form rendering across different front-end themes.
- Develop or debug a custom theme's form styling.
- Verify Claro/Olivero form behaviour after an upgrade.
- Check error message placement and wording.
- Configure showcase options at /admin/config/form_style.
- Use the Navigation-module link to reach the showcase quickly.
- Validate focus states and required-field indicators.
- Confirm RTL/label alignment for form elements.
- Regression-test form theming changes before release.
- Demonstrate accessible form patterns to a team.
