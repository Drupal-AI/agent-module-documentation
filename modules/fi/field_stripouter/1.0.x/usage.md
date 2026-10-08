<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Strip field outer div adds a "Strip outer div" checkbox to every field formatter and passes the choice into field templates as a Twig variable.
---
Using `hook_field_formatter_third_party_settings_form()`, the module attaches a `stripouter_valueonly` checkbox to the third-party settings of any field formatter, with a matching summary line ("Outer divs stripped") via `hook_field_formatter_settings_summary_alter()`. At render time `hook_preprocess_field()` reads the display component's third-party setting and exposes it as the `{{ stripouter_valueonly }}` variable in `field.html.twig` (and its suggestions). The module itself does not remove markup — it provides the flag; the theme's field template is expected to check the variable and render only the field value without the wrapping `<div>`s.

There are no routes, permissions, services, or configuration pages. It is a theming/output helper. The checkbox appears in the manage-display formatter settings, which already require the relevant field/display administer permission.
---
- Add a "Strip outer div" option to any field formatter's settings.
- Expose `{{ stripouter_valueonly }}` in field templates.
- Render a field value without its wrapping div in a custom template.
- Produce cleaner markup for inline fields.
- Flag specific fields in a view mode for stripped output.
- Show "Outer divs stripped" in the formatter summary for clarity.
- Let front-end devs opt-out of Drupal's default field wrappers per field.
- Combine with a custom field.html.twig that respects the flag.
- Keep theming decisions in the display config rather than in code.
- Apply per view mode (teaser vs full) via the display component setting.
- Reduce CSS overrides needed to hide wrapper divs.
- Output a field value directly inside a custom wrapper element.
- Simplify markup for a component-based front end.
- See at a glance which fields have stripping enabled via the summary.
- Toggle stripping on a single field without a code deploy.