<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nonce Piwik Plugin integrates Piwik PRO analytics and renders its tracking script with a fresh Content-Security-Policy nonce on every request through the Nonce Generator plugin system.

---

It solves the problem of adding an inline analytics tag on a site that enforces a strict CSP: instead of allowing `unsafe-inline`, the script is emitted as a `NonceScript` plugin (`PiwikScript`) so it carries a per-request nonce that matches the CSP header. Configuration at `/admin/config/security/nonce-piwik-plugin` (permission `administer site configuration`) covers enabling tracking, the Piwik PRO container URL, the site ID, an optional data-layer name, secure/SameSite=Strict cookie options, and inclusion/exclusion rules by path, user role, and content type. A default exclude list keeps tracking off admin, batch and node-edit paths.

Set up by installing Nonce Generator and this module, entering the container URL and site ID, and tuning the path/role/content-type filters. The plugin decides per request whether the tracker should render.

---
- Add Piwik PRO analytics to a Drupal site.
- Serve the tracking tag with a CSP nonce instead of `unsafe-inline`.
- Enable or disable tracking globally from one toggle.
- Set the Piwik PRO container URL and site ID.
- Rename the data-layer variable to match your Piwik setup.
- Force secure cookies and `SameSite=Strict` for the tracker.
- Exclude admin paths from tracking (default).
- Exclude node add/edit and batch paths from tracking.
- Limit tracking to (or away from) specific user roles.
- Limit tracking to specific content types.
- Keep analytics compatible with a strict Content-Security-Policy.
- Avoid weakening the CSP just to load analytics.
- Add custom excluded paths with wildcards.
- Confirm the nonce changes on each page load.
- Combine with Nonce Generator's CSP header management.
- Turn off tracking on staging while keeping config.
- Audit which paths currently emit the tracker.
- Roll out Piwik PRO consent-friendly cookie flags.
