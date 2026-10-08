# Islandora Breadcrumbs — agent index

A breadcrumb builder that walks `field_member_of` (or configured reference fields) to build ancestor trails
for Islandora nodes. Configure at `/admin/config/islandora/breadcrumbs`. Depends on `islandora`. No
permissions of its own.

- **Settings and behavior** → [configure/breadcrumbs.md](configure/breadcrumbs.md)

Key facts:
- Service `IslandoraBreadcrumbBuilder` (`src/IslandoraBreadcrumbBuilder.php`) — `applies()` to Islandora node
  routes; `build()` follows the reference fields upward using Islandora Core utils.
- Config `islandora_breadcrumbs.breadcrumbs`: `referenceFields` (default `[field_member_of]`), `maxDepth`
  (default `-1` = unlimited), `includeSelf` (default `FALSE`).
- Settings form route `system.islandora_breadcrumbs_settings` (`IslandoraBreadcrumbsSettingsForm`, requires
  `administer site configuration`).
