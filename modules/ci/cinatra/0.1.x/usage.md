<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cinatra embeds the Cinatra AI editing widget on node pages and brokers the short-lived tokens the widget needs, keeping the site's long-lived integration credential server-side.

A site is connected to a Cinatra instance either through a "Connect with Cinatra" redirect handshake or a pasted install-code fallback, both started from the settings form (Form-API CSRF protected). The redirect return leg (`/admin/config/services/cinatra/connect/callback`) is gated on `administer site configuration` and protected by a single-use, uid-bound, server-stored `state` plus PKCE S256 — a Drupal form token cannot survive the off-site round-trip. The server-to-server token exchange runs through an SSRF guard (`Ssrf`) that rejects loopback/private/link-local/metadata targets and disables redirect-following, and the returned credential is written to config and never sent to the browser. Runtime token brokers (`/cinatra/token`, `/cinatra/widget-auth/{init,token}`) are POST-only, `_csrf_token`-protected, and gated on `use cinatra assistant`; they present the long-lived key to the instance server-side and return only whitelisted short-lived envelopes. A publish webhook emitter signs payloads with Standard-Webhooks HMAC-SHA256.

Use it to give trusted editors an in-page AI assistant that can read page context and propose edits, without exposing the integration secret to client JavaScript.
---
Embeds the Cinatra AI editing widget on node pages with a hardened connect handshake and server-side token brokers.
---
- Add the Cinatra AI editing widget to node pages
- Connect the site to a Cinatra instance via a redirect handshake
- Fall back to a pasted install-code connection string
- Keep the long-lived integration credential server-side only
- Mint short-lived streaming tokens for the widget (POST + CSRF)
- Broker per-user PKCE widget-auth init/token exchanges
- Restrict widget use to trusted editors (use cinatra assistant)
- Protect the OAuth callback with single-use, uid-bound state + PKCE S256
- Block SSRF to loopback/private/metadata addresses on server calls
- Disable redirect-following on server-to-server exchanges
- Sign publish webhooks with Standard-Webhooks HMAC-SHA256
- Configure the Cinatra instance URL and credential from admin
- Reconnect to a different instance and rotate stored credentials
- Avoid exposing the integration key to client JavaScript
- Support containerized topology via a validated base-URL override
- Never reflect upstream error bodies that could echo secrets
- Let editors get AI edit suggestions using current page context
- Clear webhook material when switching instances
