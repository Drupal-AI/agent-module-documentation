<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview Link — agent index

Generates a unique tokenised URL that grants anyone (incl. anonymous) temporary preview
access to unpublished/draft entities. Backed by a `preview_link` content entity holding a
UUID token, referenced entities (`dynamic_entity_reference`), and an expiry.

- **Settings form + `preview_link.settings` config (enable entity types, expiry, etc.)** →
  [configure/settings.md](configure/settings.md)
- **Create/inspect preview links programmatically; entity, host service, URLs, routes** →
  [api/generate-links.md](api/generate-links.md)
- **Permissions (`generate preview links`, `administer preview link settings`)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route `preview_link.settings` at `/admin/config/content/preview_link`
  (`info.yml` `configure: preview_link.settings`).
- Config object `preview_link.settings`: `enabled_entity_types`, `expiry_seconds` (default
  604800), `multiple_entities` (default true), `display_message` (`always`/`subsequent`/`never`).
- Depends on `dynamic_entity_reference`.
- Editors generate a link from an entity's **Preview Link** tab
  (`<canonical>/generate-preview-link`), added to supported entity types via
  `hook_entity_type_alter()`.
- Service `preview_link.host` → `hasPreviewLinks()` / `getPreviewLinks()` / `isToken()`.
