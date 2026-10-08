<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kontainer (kontainer) — agent index

**Integrates the Kontainer DAM with Drupal media: asset import, CDN media types, CDN image conversions and file-usage reporting back to Kontainer.**

- **Version:** 2.1.x
- **Core:** ^10.3 || ^11
- **Configure:** `/admin/config/media/kontainer` (`kontainer.admin.config`)
- **Dependencies:** field, file, image, link, media, media_library, path, responsive_image, entity_usage:entity_usage (Entity Usage ^2.2 || ^5.0)

## Routes
- `kontainer.admin.config` — settings form — perm `administer kontainer settings`
- `kontainer.create_media` — `/kontainer/create-media` — JSON, `_csrf_token: TRUE` (no permission req; service-level `create <type> media` check)
- `kontainer.usage` — `/kontainer/api/file-usages` — `_auth: kontainer_auth`, `_role: kontainer_auth_role`
- `kontainer.delete_media_types` + `entity.cdn_image_conversion.*` — perm `administer kontainer settings` / `administer cdn_image_conversion`

## Permissions
`administer kontainer settings`, `administer cdn_image_conversion`

## Services
- `kontainer_service` (`Service\KontainerService`) — import, CDN URL formatting, usage tracking, `createFile()` server-side download (sanitises file name, summarises transfer failures).
- `kontainer.authentication.kontainer_auth` (`Authentication\Provider\KontainerAuth`) — Bearer id:secret check with `hash_equals()`; denies when config id or secret empty.

**Security:** admin routes are permission-gated. `create-media` is CSRF-protected and enforces `create <type> media` at service level. Callback auth uses `hash_equals` and refuses when the integration id/secret is unset (no null-token bypass). TLS is left at Guzzle's secure default (no `verify=>false`).

See [configure/setup.md](configure/setup.md)
