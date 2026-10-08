<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backlinks (backlinks) — agent index
**Extracts internal links from node fields on save and records which nodes link to each node.**

- **Version:** 1.0.x  •  **Core:** ^9 || ^10 || ^11 || ^12  •  **Requires:** node
- **Routes:** `backlinks.settings` `/admin/config/content/backlinks`; `backlinks.bulk` `/admin/config/content/backlinks/update`
- **Permission:** both require `administer site configuration`
- **Services:** `backlinks.entity` (EntityLinkService, runs on presave), `backlinks.links` (BackLinkService, DOM parsing), `backlinks.trusted_hosts` (matches settings.php `trusted_host_patterns`)
- **Fields:** add `linked_node` (entity ref) and `linked_url` to content types; optional "Linked Content" view.
- **Security:** admin-only config; parses stored node markup and resolves only internal `entity.node.canonical` routes — no outbound HTTP fetch, no SSRF surface.

See [api/service.md](api/service.md).