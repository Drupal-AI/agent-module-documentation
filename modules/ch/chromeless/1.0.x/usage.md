<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Chromeless adds a `chromeless` query parameter that makes Drupal render only a page's main content, hiding all surrounding blocks (header, footer, sidebars).

---

Chromeless is a tiny, configuration-free module that swaps in a custom page display variant (`chromeless_page`) whenever a visitor's "chromeless" preference is active. When active, the page renders just status messages, an optional page title, and the main content render array — every block in the block layout is omitted. The preference is toggled by a URL query parameter (`?chromeless=1` to enable, `?chromeless=0` to disable) and a companion `title` parameter that shows or hides the page title while chromeless. Each parameter's value is cast to an integer and treated as TRUE for any non-zero value. Preferences are remembered per visitor in Drupal's private temp store for the rest of the session (default one week), so the parameter only needs to be supplied once. The query-parameter names are container parameters and can be renamed site-wide. The module honours normal content access — it strips chrome only and never bypasses permissions.

---

- Enable bare, content-only rendering of any Drupal page on demand with `?chromeless=1`.
- Embed a Drupal page inside an iframe without duplicating the site header, footer, and menus.
- Produce clean, print- or PDF-friendly versions of nodes and views by hiding the block layout.
- Drive kiosk or digital-signage displays that show only the page body.
- Toggle chromeless mode off again mid-session with `?chromeless=0`.
- Show or hide the page title in chromeless mode independently via the `title` parameter (`?title=1` / `?title=0`).
- Set both preferences in one request, e.g. `?chromeless=1&title=1`.
- Persist a visitor's chromeless preference across subsequent page views (no need to append the parameter every time).
- Keep each visitor's preference private and per-session (stored in the private temp store, not shared).
- Deploy with zero configuration — no settings form, no permissions, no config to export.
- Customize the enabling parameter name by overriding the `chromeless.query.active` container parameter.
- Customize the title parameter name by overriding the `chromeless.query.title` container parameter.
- Shorten how long the preference is retained by tuning the private temp store expiry when many distinct user agents hit chromeless pages.
- Provide a lightweight alternative to a dedicated print theme or separate embed routes.
- Reuse existing routes/pages as-is; no new routes or controllers are added.
- Work across Drupal core 10.5 and 11 (PHP 8.3+).
- Keep chromeless pages correctly cached via a dedicated `chromeless_state` cache context (no cache poisoning between normal and chromeless views).
- Let JavaScript status messages still function on chromeless pages (a messages fallback container is always rendered).
- Combine with contrib PDF/screenshot tooling that fetches a URL, by pointing it at `?chromeless=1` for a chrome-free capture.
- Serve a "content only" variant of the same URL for API-adjacent or lightweight-frontend consumers.
- Avoid theme forks: the same theme renders, just without the block layout regions.
