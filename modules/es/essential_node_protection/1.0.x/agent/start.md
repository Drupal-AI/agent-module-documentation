<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Essential Node Protection (essential_node_protection) — agent index

**Forbids deletion of the nodes set as the site's front / 403 / 404 pages by overriding the node access handler.**

- **Version:** 1.0.x  •  core: `^8 || ^9 || ^10`  •  configure: `essential_node_protection.settings_form`  •  depends on `node`  •  permission `administer essential_node_protection configuration`.
- **Mechanism:** `hook_entity_type_build` sets node `access` handler to `NodeAccessControlHandler extends \Drupal\node\NodeAccessControlHandler`. `access()` returns `AccessResult::forbidden()` when `$operation==='delete'` AND `isEssential()` (node system path == `system.site` page.front/403/404 and that slot enabled in config); else `parent::access()`.
- **Config:** `site_settings.front/403/404` booleans (default all 1).

**Security (reviewed, enforces correctly):** uses `AccessResult`, is fail-CLOSED (only ever adds a deny; defers all other ops and non-essential nodes to core) — no fail-open. Minor nit: the forbidden result attaches no cacheability metadata for the config/system.site, so a stale deny could linger in a cached access result until cache clear; harmless for a delete guard. No security finding.
