<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Feeds Block (social_feeds_block) — agent index

**Blocks that render Facebook / X / Instagram / Pinterest / YouTube / LinkedIn / Google Business feeds via each network's API.**

- **Version:** 2.0.x (dev-2.0.x) · **Core:** ^10.3 || ^11 · **PHP:** 8.2
- **Configure:** `social_feeds_block.configuration` (menu of per-network forms).
- **Routes:** seven `*_settings_form` admin routes + `social_feeds_block.instagram_auth` (OAuth token exchange) — all `_permission: 'administer social_feeds_block'` (restricted).
- **Services:** per-network post collectors over `@http_client` with `@cache.default`; block plugins per network.
- **External hosts:** fixed HTTPS API endpoints (graph.facebook.com, api.instagram.com, graph.instagram.com, api.pinterest.com, www.googleapis.com, api.linkedin.com, mybusiness.googleapis.com).
- **Security:** config + Instagram auth routes permission-gated; outbound URLs are hardcoded HTTPS (no SSRF), TLS at Guzzle defaults (not disabled). Note: some Facebook Graph calls pass `access_token` in the query string (`FacebookPostCollector.php:292,407,519,637`) — token may appear in logs.

See [configure/social-feeds.md](configure/social-feeds.md)
