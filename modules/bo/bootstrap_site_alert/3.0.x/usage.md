<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Site Alert renders one or more dismissible, site-wide banners in Bootstrap `alert` styling on top of every page — a maintenance notice, an outage warning, a launch announcement — configured on a single admin form and stored in Drupal's State API.

---

Every site eventually needs to put a banner in front of everyone: "scheduled maintenance tonight", "our office is closed", "new feature launched". This module does it without blocks, panels, or a content type: an editor with the right permission opens one config form at `/admin/config/system/bootstrap-site-alert`, picks a Bootstrap version (3 or 4), and defines any number of alerts — each with a severity class, a WYSIWYG body, an optional dismiss button, an option to hide on admin pages, and optional path restrictions (with a negate switch). The alerts are written to the State API rather than to config or nodes, and a `hook_page_top()` implementation injects them near the top of every response, independent of the theme's block layout. Dismissal is remembered per visitor via a cookie (backed by the `js_cookie` module); because a fresh random token is generated on every save, editing an alert re-shows it to people who had dismissed the previous version. Two permissions govern it — `administer bootstrap site alerts` to create and edit, `view bootstrap site alerts` to see — and by default both anonymous and authenticated users are granted the view permission.

The Bootstrap dependency is stylistic: the banners emit `alert alert-*` classes, so a Bootstrap-based theme (or the equivalent CSS the project documents) gives them their look. For simple operational and promotional messaging this is a fast, theme-independent tool; if you need scheduling or editorial workflow around alerts, the project's separate content-based 2.0.x line is the alternative.

---

- Show a site-wide alert banner on every page.
- Announce scheduled maintenance to all visitors.
- Post an emergency or outage notice.
- Display a promotional or launch banner.
- Define several alerts at once and toggle each on or off.
- Choose a Bootstrap severity (success, info, warning, danger, and the Bootstrap 4 variants).
- Add a WYSIWYG-formatted message body.
- Make an alert dismissible with a close button.
- Remember a visitor's dismissal via a cookie.
- Re-show an edited alert to people who dismissed the old one.
- Hide an alert on admin pages only.
- Restrict an alert to specific paths using wildcards and `<front>`.
- Negate the path list to show an alert everywhere except certain pages.
- Show alerts to authenticated users only by revoking the anonymous view permission.
- Control who may create alerts with a dedicated admin permission.
- Place messaging site-wide without using a block or panel.
- Give non-developers a single form to manage banners.
- Set alert values programmatically through the State API.
- Style banners with Bootstrap alert classes on a Bootstrap theme.
- Provide managed operational messaging independent of the theme layout.
