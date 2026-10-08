<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unomi Integration for Personalization (unomi) — agent index

**Connects Drupal to an Apache Unomi CDP via a pluggable auth connector; exposes Unomi segments as a visibility condition.**

- **Version:** 6.0.x (6.0.0) · **Core:** ^10 || ^11 · **Depends:** options
- **Configure:** `unomi.settings` `/admin/config/services/unomi` (`administer unomi`).
- **Plugin type:** `UnomiConnector` (manager `plugin.manager.unomi.connector`); shipped `BasicAuthUnomiConnector`.
- **Services:** `UnomiCookieManager`, `cache.unomi` bin, `logger.channel.unomi`.
- **Condition plugin:** `SegmentSelection` (show/hide by Unomi segment).
- **Clients:** `UnomiClientBase` / `UnomiClientBasicAuth` over `@http_client`.
- **Connection:** Unomi server URI is admin-configured; TLS at Guzzle defaults. Admin config route permission-gated; no anonymous or mutating endpoints.

See [configure/unomi.md](configure/unomi.md)
