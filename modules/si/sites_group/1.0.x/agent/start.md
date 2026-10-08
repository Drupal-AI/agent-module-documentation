<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sites group (sites_group) — agent index
**Uses Group entities as "sites", bridging the Group module and the Sites module with a per-Group site plugin and canonical-site access enforcement.**

- **Version:** 1.0.x (1.0.0-alpha2)
- **Core:** ^10 || ^11
- **Depends on:** group, form_decorator (gnode optional for node relations)
- **Services:** `sites_group.service` (SitesGroupService); `sites_group.current_site` context provider (GroupFromSiteContext); `CanonicalSiteAccessControl` decorates `group.relation_handler.access_control` (priority 50).
- **Permissions file:** `sites_group.group.permissions.yml` (Group-scoped).
- **Setup:** via Group UI — create a Group type, enable "sites group" on it, set Group-type permissions.

**Security:** no custom routes or public endpoints; access is delegated to the Group permission system and tightened by the canonical-site access-control decorator. Review Group type permissions so content is not shared across sites. Early alpha.
