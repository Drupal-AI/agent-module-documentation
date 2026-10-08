<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Siteimprove.ai Plugin (siteimprove) — agent index

Bridges Drupal to the **Siteimprove.ai** SaaS platform — injects the overlay/JS on configured entity routes and fetches a short-lived auth token so editors get content/accessibility/SEO/analytics insights and a recheck/prepublish action in-editor. Version **3.0.5**. Core `^10.2 || ^11`. Requires **js_cookie**. Configure at `/admin/config/system/siteimprove` (`administer siteimprove`).

Permissions: `administer siteimprove` (settings), `use siteimprove` (overlay), `use siteimprove prepublish` (prepublish check).

External call: `GET https://my2.siteimprove.com/auth/token` server-side via Guzzle at the secure default (certificate verification **on**). Enabled routes are set via service parameters (`siteimprove.*_enabled_routes`).

Security: settings route is permission-gated; token request uses verified TLS; no anonymous/mutating endpoints. See [configure/settings.md](configure/settings.md).