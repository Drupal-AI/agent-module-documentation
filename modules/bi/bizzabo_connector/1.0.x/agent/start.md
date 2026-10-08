<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bizzabo API connector (bizzabo_connector) — agent index

**Fetches and displays events from the Bizzabo event API.**

- **Version:** 1.0.x · **Core:** ^10
- **Config:** `bizzabo_connector.base_url_form` → `/admin/config/eventapi/baseUrl` (`administer site configuration`); stores base URL + bearer `auth_key` in `bizzabo_connector.baseurl`.
- **Controllers:** `BizaboEventController::getDisplayEvents` (`/bizabo/fetch/events`), `::testConnection` (`/admin/config/api/param`), `::getParams` (`/admin/bizabo/fetch/events/params`).

**Security:** config routes are permission-gated, but `/bizabo/fetch/events` and `/admin/config/api/param` use `_access: "TRUE"` (anonymous); the events listing is exposed publicly. Bearer key stored as plain config. See [configure/bizzabo_connector.md](configure/bizzabo_connector.md).
