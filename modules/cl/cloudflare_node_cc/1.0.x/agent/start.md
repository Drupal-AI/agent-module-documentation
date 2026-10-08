<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Node Cache Clear (cloudflare_node_cc) — agent index

**Purges Cloudflare edge cache per node (on save) or site-wide per zone, with optional per-language zones/domains and client-IP restoration.**

- **Version:** 1.0.x (info.yml `1.0.2`)
- **Core:** ^8.8 || ^9 || ^10 (Drupal 10 contrib; no D11 release)
- **Dependencies:** `node`, `media`, `admin_toolbar_tools`, `key`; PHP lib `cloudflare/sdk`.
- **Configure:** `/admin/config/cloudflare-node-cache-clear` — route `cloudflare_node_cc.config_form` (`administer cloudflare_node_cc`).
- **Routes:** `cloudflare_node_cc.purge_cache` `/admin/cloudflare-node-cache-clear/purge-cache` (`cloudflare_node_cc purge cache`).
- **Service:** `cloudflare_node_cc.cloudflare_service` (`CloudflareService`); event subscriber `CloudflareClientIpRestore`.
- **Secrets:** API key/token resolved from a **Key** entity via `key.repository` — not stored in config/state directly.

**Security:** admin/purge routes are permission-gated; API credentials go through the Key module (no hardcoded secrets); Cloudflare SDK uses Guzzle over HTTPS (TLS not disabled). Caveat: the opt-in `CloudflareClientIpRestore` subscriber overwrites `REMOTE_ADDR` from the untrusted `CF-Connecting-IP` header without checking the source is a real Cloudflare IP range (`src/EventSubscriber/CloudflareClientIpRestore.php` `onRequest()`) — client-IP spoofing risk if enabled without an upstream trusted-proxy guard.

See [configure/settings.md](configure/settings.md) and [api/service.md](api/service.md).
