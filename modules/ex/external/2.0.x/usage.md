<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Links makes outbound links (and, optionally, PDF links) open in a new browser tab, using a client-side jQuery `window.open()` click handler rather than `target="_blank"` markup.

---

The whole module is one small JavaScript behaviour plus a settings form. On every non-excluded page, `external_page_attachments()` attaches the `external/external` library and a single `drupalSettings.external.externalpdf` boolean — but only when the `external_enabled` config flag is true and the current path (checked against its alias too) is not matched by the admin's `external_disabled_patterns` list. The behaviour in `js/external.js` then binds a click handler to three sets of anchors: every `a[href^=http://]` / `a[href^=https://]` whose host does not look like the current host (a crude `href.indexOf(location.hostname)` heuristic that treats a host found at string index > 13 as external), every `a.newtab` link, and — when the PDF option is on — every `a[href*=.pdf]`. The handler is simply `window.open(this.href); return false;`, which opens the target in a fresh tab and cancels the normal navigation. Note what it does **not** do: it adds no `target="_blank"`, no visible icon, and no screen-reader announcement — the DOM is untouched, which is the point (the markup keeps validating) but also means there is no visible or announced cue that the link opens elsewhere. Configuration lives at `/admin/config/content/external` behind the `administer external` permission (`restrict access: TRUE`): three fields — enable the module, open PDFs in new tabs, and a textarea of Drupal paths to exclude (the `*` wildcard and the `<front>` token are supported). There are no fields, formatters, filters, plugins, services, routes-that-fetch, or server-side HTTP requests anywhere in the module; it is purely a frontend convenience. Version 2.0.0-alpha5 is an alpha on core `^10 || ^11`.

---

- Open every external (off-site) link in a new tab site-wide.
- Do it without writing `target="_blank"` into the markup, so pages still validate.
- Additionally open links to PDF documents in a new tab (opt-in setting).
- Open only hand-picked links in a new tab by giving them `class="newtab"`.
- Keep a visitor's place on a long form or article when they follow a reference.
- Keep a video or audio player running while the user opens a cited source.
- Disable the behaviour on admin screens (the default exclude list covers `admin*`, `node/add/*`, `node/*/edit`).
- Exclude specific pages or whole sections from the new-tab behaviour by path pattern.
- Exclude the front page from the behaviour using the `<front>` token.
- Apply a wildcard exclusion such as `blog/*` to a whole content section.
- Turn the whole behaviour on or off site-wide from one checkbox.
- Provide a leaner alternative to the extlink module when only new-tab-on-external is needed.
- Enforce a simple editorial policy that outbound references leave the current tab intact.
- Reduce accidental site exits when users click reference links.
- Apply consistent outbound-link behaviour across a multi-editor site without per-link markup.
- Cover links injected dynamically after page load (the behaviour re-attaches per Drupal behaviours context).
- Let content editors opt a single internal link into new-tab behaviour with the `newtab` class.
