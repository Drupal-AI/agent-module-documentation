<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
eTracker Analytics attaches the etracker web-analytics tracking snippet to your Drupal pages, configured by a single settings form and gated by flexible path/role/user visibility rules.

---

eTracker Analytics integrates the etracker (German) web-analytics service. It injects etracker's external
loader script (`https://code.etracker.com/code/e.js`) into configured pages, emitting your account key as the
snippet's `data-secure-code` attribute and passing the current page title (and an optional breadcrumb-derived
"area" hierarchy) to etracker via a small inline `<head>` script. A settings form at
`/admin/config/system/etracker` (permission `administer etracker`) controls script placement (header or
footer), which pages and roles are tracked, whether individual users may opt in/out, Do-Not-Track handling,
cookie blocking, and client-side event tracking for mailto/outbound/download links and Drupal system messages.
An etracker account (paid) is required. The optional `cookies_etracker` submodule gates the tracker behind the
COOKiES consent module, and when the `csp` module is installed the tracking domain is added to the CSP
`script-src` directive automatically.

---

- Add etracker web-analytics tracking to a Drupal site.
- Configure the etracker account key (emitted as `data-secure-code`) on the settings form.
- Place the tracking snippet in the page header (recommended) or footer.
- Track every page except a listed set of paths, or only a listed set of paths.
- Restrict tracking to (or exclude) specific user roles.
- Let users opt in or opt out of tracking on their own account page.
- Default new users to tracked-with-opt-out or untracked-with-opt-in.
- Honour the browser Do-Not-Track header (`data-respect-dnt`).
- Run etracker in cookie-less mode (`data-block-cookies`).
- Track clicks on `mailto:` links as events.
- Track clicks on outbound/external links as events.
- Track downloads by a configurable list of file extensions (e.g. `pdf doc docx`).
- Track Drupal status/warning/error messages as events to spot usability issues.
- Send the page title to etracker as `et_pagename`.
- Send the breadcrumb trail as a hierarchical `et_areas` value for tree-view reports.
- Exclude the front page from the breadcrumb area hierarchy.
- Keep admin, batch and node-edit paths untracked out of the box (default path list).
- Add the etracker tracking domain to the Content-Security-Policy when the `csp` module is enabled.
- Gate the tracker behind COOKiES cookie consent via the `cookies_etracker` submodule.
- Confirm tracking by viewing a page's HTML source for the etracker `<script id="_etLoader">`.
- Provide a runtime status warning until the account key is configured.
