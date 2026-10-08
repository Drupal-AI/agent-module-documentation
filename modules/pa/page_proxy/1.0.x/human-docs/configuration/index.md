# Configuration

Page Proxy is configured by creating one or more **proxy routes**, each mapping a
local Drupal path to an external target. Before you do, it is worth understanding
what the module does on the server's behalf.

## Read this first — security considerations

Page Proxy makes **server‑side outbound requests** and **forwards cookies and
headers**. That makes it powerful but sensitive:

- **The target host is admin‑configured, not per‑request.** An end user can vary
  the *path* on the host you configured, but cannot point the proxy at an arbitrary
  internal host — so this is not an open server‑side‑request‑forgery (SSRF) proxy.
  It is still an SSRF‑adjacent surface, so treat the configuration with care.
- **Point proxies only at hosts you trust** and that are reachable exactly as you
  intend. Your Drupal server becomes the origin of the request to that host.
- **Cookie forwarding is filtered** to an "allowed cookies" list. Verify that
  filtering matches your needs so you do not leak session cookies cross‑origin.
- **Keep the configuration permission restricted.** The settings form is gated by
  **Administer site configuration** — grant that only to trusted administrators.
- **Serve over HTTPS** so proxied traffic and any forwarded credentials are
  protected in transit.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Page Proxy**, or navigate directly to
   `/admin/config/services/page-proxy`.

## Create a proxy route

Add a new page proxy configuration that maps a **local Drupal path** to an
**external target**. For example, mapping the local path `bar` to `https://bar.org`
makes the remote site available under `yoursite/bar`. Requests to that local path
are forwarded to the target — including the request path and query string — and the
response is served back to the visitor. Save the configuration.

## Verify

Visit the local path you mapped as a visitor and confirm the remote page renders
under your domain. Then double‑check the cookie/header forwarding behaves as you
expect, especially if the target shares a domain with anything session‑sensitive.
