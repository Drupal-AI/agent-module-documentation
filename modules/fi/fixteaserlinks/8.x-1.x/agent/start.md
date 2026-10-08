<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fix Teaserlinks (fixteaserlinks) — agent index

**Hides selected node links from teaser view mode via hook_node_links_alter().**

- **Version:** 8.x-1.x  | **Core:** ^8.8 || ^9 || ^10
- **Configure:** `/admin/config/system/fixteaserlinks` (route `fixteaserlinks.config`, perm `administer site configuration`)
- **Surface:** one settings form; `hook_node_links_alter()` acts only on the `teaser` view mode. No entities, services, or permissions.

**Security:** admin-only settings form; display-only behaviour, no data exposure. Nothing notable.
