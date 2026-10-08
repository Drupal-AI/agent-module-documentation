<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Proxy — agent index

**Lets Drupal act as a reverse proxy for an ADMIN-configured external page** (proxy routes at
`admin/config/services/page-proxy`, gated by `administer site configuration`; target **host fixed by config**).
Version **1.0.0-rc5**. Core `^10||^11`.

Proxy/integration — **SSRF-adjacent** but constrained to the configured host (end users vary only the path). It
makes **server-side outbound requests** and **forwards filtered cookies/headers** (verify no session-cookie leak).
Point proxies only at trusted hosts; keep the config permission restricted; HTTPS.
