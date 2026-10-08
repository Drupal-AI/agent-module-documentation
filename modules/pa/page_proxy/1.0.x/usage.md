<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Proxy lets Drupal act as a proxy for external pages.

---

Page Proxy **lets Drupal act as a reverse proxy for external pages** — an admin defines proxy routes (a Drupal
path mapped to an external target) and Drupal fetches the target server-side and serves it under the local path,
optionally passing through the request path/query and filtered cookies. Its settings are gated by `administer site
configuration`.

Use it to surface an external page under your domain. It is a proxy/integration feature with security
considerations. The proxied **target host is admin-configured** (not chosen per-request by end users), so this is
not an open SSRF proxy — an end user can vary the **path** on the configured host but can't point it at an
arbitrary internal host. Still, treat it carefully: it makes **server-side outbound requests** to the configured
target (confirm that host is trusted and reachable only as intended), it **forwards cookies/headers** (it filters to
"allowed cookies" — verify that filtering matches your needs so you don't leak session cookies cross-origin), and
proxying makes your server the request origin. Keep `administer site configuration` restricted, point proxies only
at trusted hosts, and serve over HTTPS. Configure the proxy routes.

---

- Reverse-proxy an external page.
- Map a Drupal path to an external target.
- Fetch the target server-side + serve it.
- Gate settings by administer site configuration.
- Serve proxy/integration.
- Pass through path/query + filtered cookies.
- Fix the target HOST by admin config (not an open per-request SSRF proxy).
- Let end users vary only the path on the configured host.
- FORWARD cookies/headers (filtered to 'allowed cookies' — verify no session-cookie leak).
- Confirm the target host is trusted + keep the config permission restricted + HTTPS.
- Make the server the request origin.
- Configure the proxy routes.
- Handle proxying.
- Proxy pages.
- Configure the routes.
- Fetch pages.
- Handle the requests.
- Serve external pages.
- Trust the target.
- Provide external-page proxying.
