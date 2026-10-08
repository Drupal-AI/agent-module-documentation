<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Select converts Drupal's multiple-select HTML elements into stylized, optionally-scrollable checkbox lists.

---

Better Select implements `hook_element_info_alter()` to attach a `#process` callback to every `select` form element. When a select is `#multiple` (and the site-wide "explicit opt-in only" mode is off, or the element carries `#betterselect = TRUE`), the callback rewrites it into a core `checkboxes` element with a "check all" control, wraps it in a container `<div>`, and attaches the module's CSS/JS library. Options can be placed in a fixed-height scrollable box, auto-scrolled to the first checked item on load, and — for hierarchical taxonomy term lists — annotated with `checkbox-depth-N` and `has-children` wrapper classes derived from the leading-dash indentation of each option label. There are no entities, fields, services, or plugins; the only route is the settings form at `/admin/config/content/betterselect`, gated by the core `administer site configuration` permission. Supports Drupal 10 and 11.

---

- Replace an awkward native multi-select box with a checkbox list users can click directly.
- Convert every `#multiple` select on the site to checkboxes automatically (default mode).
- Restrict conversion to opt-in elements only by enabling "Explicit opt-in only" and setting `#betterselect = TRUE` on chosen elements.
- Flag a specific form element in a custom form or `hook_form_alter()` with `#betterselect = TRUE` to convert just that widget.
- Improve accessibility for users who cannot Ctrl/Cmd-click to multi-select.
- Put a long option list in a fixed-height scrollable div so it does not dominate the page (enable "Scrollable div").
- Auto-scroll a scrollable list to the first already-checked option on page load (enable "Scroll to the first selected item").
- Style parent vs. child taxonomy terms differently using the `checkbox-depth-0`, `checkbox-depth-1`, … wrapper classes (enable "Add depth classes").
- Target terms that have children via the injected `has-children` class.
- Get a "Check all / Uncheck all" toggle for free (core Checkboxes `#checkall`).
- Highlight the row of each checked option via the `hilight` class kept in sync by the module's JS.
- Present a taxonomy multi-value reference field as an indented checkbox tree instead of a scroll box.
- Improve node-edit forms that expose multi-value select widgets.
- Keep the empty "- None -" option hidden on non-required converted fields.
- Style the converted widgets with the module's `css/betterselect.css` or override in your theme by targeting `.better-select`.
- Automatically switch to a fixed-height (`betterfixed`) layout when the option count exceeds the select's `#size`.
- Configure all behavior centrally at `/admin/config/content/betterselect` (no per-field settings needed).
- Deploy the four boolean settings as config via `betterselect.settings.yml` for consistent multi-environment behavior.
- Enhance faceted-search or filter forms that use multi-select controls.
- Reduce user error on forms where multiple selections are expected but easy to miss.
- Uninstall cleanly — `hook_uninstall()` deletes the `betterselect.settings` config object.
