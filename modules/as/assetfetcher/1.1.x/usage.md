<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Asset Fetcher downloads the external CSS/JS library files that modules and themes declare (e.g. from a CDN) and rewrites those library sources to serve local copies instead, checking any declared SRI hash.

---

Asset Fetcher hooks into Drupal's asset pipeline via `hook_css_alter()` and `hook_js_alter()`. For every library source marked `type: external` with a `//host/...` URL, it downloads the file through core's `system_retrieve_file()`, stores it under `public://assetfetcher/…` (or reuses a matching `libraries/…` copy), and swaps the source to that local `type: file` path so the browser never contacts the CDN. If the library declared an `integrity` attribute, the downloaded bytes are verified against that Sub-Resource Integrity spec before the file is kept. It is controlled from the core Performance settings page (three checkboxes: enable, prefer unminified, allow remote fallback) and reports fetch results on the status report. There are no entities, permissions, routes, or Drush commands of its own — it is a purely infrastructural performance/privacy tool aimed at GDPR compliance (no third-party CDN calls) and at letting the downloaded assets benefit from core/AdvAgg aggregation.

---

- Serve CDN-hosted JS/CSS libraries from your own domain instead of a third party.
- Comply with GDPR by eliminating browser calls to external CDNs (jsDelivr, unpkg, cdnjs, googleapis, aspnetcdn).
- Let contrib module authors ship a plain CDN library link and have it localized automatically, with no manual download step.
- Localize an external library declared by a theme without editing the theme's `.libraries.yml`.
- Have downloaded external assets participate in core CSS/JS aggregation and minification.
- Keep external assets available even if the upstream CDN is later blocked or goes offline.
- Verify a fetched library against the `integrity` (SRI) hash the library declares.
- Reject and discard a downloaded asset whose bytes do not match its declared SRI hash.
- Prefer the unminified build of a CDN library (`.min.js`/`.min.css` → non-min) for easier debugging in development.
- Fall back to loading the original remote URL if a fetch fails (opt-in) — or hard-fail for strict privacy.
- Reuse an already-installed `libraries/<name>@<version>/…` copy instead of re-downloading (works with jsDelivr/unpkg/cdnjs/googleapis path layouts).
- Audit which module/theme libraries pull external assets via the status report (`/admin/reports/status`).
- Turn asset fetching on or off site-wide from one checkbox on the Performance page.
- Reduce third-party tracking exposure introduced by CDN-hosted fonts' companion scripts (note: CSS `@import`/font `url()` includes are not covered).
- Cache localized assets on disk so repeat requests are served without another upstream fetch.
- Provide a deterministic, self-hosted asset set for air-gapped or firewalled environments.
- Improve first-party cache-header and CDN control over previously external assets.
- Flag libraries that could not be localized so an administrator can resolve them.
- Support Drupal 9, 10, and 11 with the same configuration.
