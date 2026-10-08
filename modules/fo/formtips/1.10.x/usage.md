<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form Tips unclutters forms by moving each form element's description text into a JavaScript tooltip that appears on hover (or click) next to the field, instead of showing all descriptions inline.

---

The module is a small, purely client-side enhancement with one config object, `formtips.settings`, and one settings form at `/admin/config/user-interface/formtips` (route `formtips.setting_form`, permission `administer formtips`). It has no plugins, services or entities. On every non-admin page it implements `hook_page_bottom()` to attach the `formtips/formtips` library plus a `drupalSettings.formtips` payload built from the config, and the bundled `js/formtips.js` then converts Drupal form descriptions into hoverable/clickable tooltips. Behavior is tuned by a handful of settings: `formtips_trigger_action` (`hover` or `click`), a `formtips_max_width` for the tooltip, a newline list of `formtips_selectors` to exclude from tooltip conversion, an optional `formtips_themes` allow-list (empty means all themes), and — for hover mode — the hoverIntent timing knobs `formtips_hoverintent`, `formtips_interval`, `formtips_sensitivity` and `formtips_timeout`. When `formtips_trigger_action` is `hover` and `formtips_hoverintent` is on, it additionally attaches the `formtips/hoverintent` library. It also implements `hook_library_info_alter()` so that if the `form_placeholder` module is enabled, `form_placeholder/form_placeholder` is added as a dependency. Config is cache-tagged so tooltip settings changes are picked up on the next request.

---

- Declutter a long content-creation form by hiding field descriptions until the editor hovers a field.
- Turn verbose help text on a settings form into on-demand tooltips.
- Switch tooltips to open on click instead of hover for touch-friendly UIs.
- Constrain tooltip width (e.g. `320px`) so long descriptions wrap neatly.
- Exclude specific fields from tooltip conversion with a CSS/jQuery selector list.
- Limit Form Tips to a single theme (e.g. the front-end theme) and leave the admin theme untouched.
- Apply tooltips site-wide across every non-admin form without per-form code.
- Tune hoverIntent sensitivity so tooltips don't flicker on fast mouse movement.
- Increase the hover timeout so a tooltip stays visible while the user moves toward it.
- Disable the bundled hoverIntent plugin when the theme already provides one.
- Reduce visual noise on registration/checkout forms by tucking descriptions into tooltips.
- Pair with the `form_placeholder` module so descriptions also become input placeholders.
- Provide a cleaner Views "add field" experience where each option's help is a tooltip.
- Standardize tooltip UX across an editorial team via one exported `formtips.settings`.
- Keep accessibility help text available but out of the way until requested.
- Roll tooltip settings between environments as config (`drush cget/cset formtips.settings`).
- Deploy a consistent max-width and trigger action across a multisite via shared config.
- Make a busy media-upload form less intimidating to occasional authors.
- Offer hover help on a complex commerce checkout without redesigning the form.
- Hide descriptions on a survey/webform-style layout to shorten the visible page.
- Exclude a specific wizard step's fields from tooltips using a container selector.
- Give a client a "tooltips on hover" experience with no theme changes.
- Quickly A/B click-vs-hover triggering by toggling one setting.
- Turn Drupal's default gray description text into styled tooltips matching the theme.
