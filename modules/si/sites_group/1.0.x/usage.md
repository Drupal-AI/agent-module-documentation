<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sites group lets you run multiple websites from one Drupal install by treating each Group entity as a "site", bridging the Group module and the Sites module.
---
The module provides a Site plugin per configured Group (via `plugin.manager.site`) and a context provider (`GroupFromSiteContext`) that resolves the current Group from the active site. Its `SitesGroupService` connects content to its owning Group/site, and it decorates Group's relation access-control handler (`CanonicalSiteAccessControl`, decoration priority 50) to enforce that relations are edited on their canonical site. A `form_decorator` integration adds a "sites group" toggle to Group type edit forms.

Setup is done through the Group UI, not a dedicated admin form: enable `gnode` if you want to relate nodes to Groups, create a Group type and at least one Group, enable "sites group" on the Group type via its edit dialog, then grant the needed view permissions on the Group type's Permissions tab. Because access is layered on top of Group's own permission system, review the Group type permissions carefully so content is not exposed across sites. The module is early-stage (1.0.0-alpha2) and its own README notes install/deploy code still to be cleaned up.
---
- Run several sites from one Drupal codebase using Groups as sites.
- Map each Group to its own site plugin instance.
- Relate nodes to a Group/site using the Group Node (`gnode`) submodule.
- Enable the "sites group" behavior on a specific Group type.
- Resolve the current Group from the active site context in code.
- Enforce canonical-site editing of group relations via the access decorator.
- Grant per-site view permissions on the Group type Permissions tab.
- Create a "Custom sites" Group type and manage it at `/admin/group/types`.
- Add Groups at `/admin/group` to represent additional sites.
- Use `SitesGroupService` to connect an entity to its site.
- Provide a `current_site`-derived Group context to blocks and plugins.
- Combine with the Sites module's site negotiation.
- Restrict content editing to the site that owns it.
- Build affiliate/microsite structures on shared infrastructure.
- Expose site-scoped content lists per Group.
- Integrate Group memberships with per-site access.
- Decorate Group relation access control without patching Group.
- Prototype a multisite information architecture on Drupal 10 or 11.
- Extend with custom Site plugins keyed on Group data.
- Migrate a legacy multi-domain setup toward Groups-as-sites.
