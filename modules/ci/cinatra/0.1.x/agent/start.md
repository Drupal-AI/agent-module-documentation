<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cinatra (cinatra) — agent index

**Embeds the Cinatra AI editing widget on node pages; hardened connect handshake + server-side token brokers.**

- **Version:** 0.1.x (0.1.6)
- **Core:** ^10.3 || ^11 || ^12 · **Depends on:** node, user
- **Configure route:** `cinatra.settings_form` → `/admin/config/services/cinatra` (perm `administer site configuration`)
- **Connect callback:** `cinatra.connect_callback` GET `/admin/config/services/cinatra/connect/callback` — perm `administer site configuration`; CSRF via single-use, uid-bound, server-stored `state` + PKCE S256 (form token can't survive off-site redirect)
- **Token brokers:** `cinatra.token`, `cinatra.widget_auth_init`, `cinatra.widget_auth_token` — POST-only, `_csrf_token: TRUE`, perm `use cinatra assistant`
- **Permission:** `use cinatra assistant` (restricted)
- **Security:** reviewed sound. OAuth callback state is single-use + uid-bound + PKCE-protected; long-lived credential stored server-side, never sent to JS; `Ssrf` guard blocks loopback/private/link-local/metadata on all server-to-server calls with redirect-following disabled; publish webhooks signed HMAC-SHA256 (`hash_equals`); upstream error bodies never reflected. No CSRF/state or token-leak weakness found.

See [configure/connect.md](configure/connect.md)
