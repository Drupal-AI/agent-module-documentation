<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hubspot Integration (hubspot_integration) — agent index

**Embeds HubSpot forms/behaviour (fields, widgets, formatters, JS block), maps CRM contact data to taxonomy tids, and drives persona cookies.**

- **Version:** 2.2.x (from `2.2.4`) · **Package:** Hubspot
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends:** `entity_reference_revisions`, `paragraphs`.
- **Configure:** `hubspot_integration.admin` (Settings/Mapping/Sort under /admin/config/hubspot_integration, `Administer hubspot integration`).
- **Service:** `hubspot_integration.api` (HubspotAPI: cookie → HubSpot Contacts API → term ids).
- **Public routes (`_access: TRUE`):** `ajax/is-contact`, `ajax/is-limit-reached` (read-only GET JSON of caller's own state), `/set-persona/{persona_id}` (sets persona cookie, redirects).
- **Security:** reviewed SOUND — AJAX endpoints reflect only the caller's own cookie/tids; `/set-persona` redirect via `Url::fromUserInput` on a slash-prefixed path is not an open redirect; `getCookie()` sanitises the persona cookie. Admin config is permission-gated.

See [api/service.md](api/service.md).
