Workbench Menu Access delegates control of individual menus to Workbench Access editorial sections, so non-admin editors can only edit the menus (and menu links) that belong to their section.

---

The module extends [Workbench Access](https://www.drupal.org/project/workbench_access) from content to menus. You pick one Workbench Access **access scheme** as the active scheme on a global settings form (`/admin/config/workflow/workbench_access/menu_settings`), then on each menu's *Workbench menu access* tab (`/admin/structure/menu/manage/{menu}/access`) you assign the editorial **section(s)** allowed to update that menu; if a menu has no sections assigned, access is not restricted and core's own `administer menu` gate applies. Enforcement is real, not cosmetic: the module swaps core's access-control handlers for the `menu` and `menu_link_content` entity types (`WorkbenchMenuAccessControlHandler`, `WorkbenchMenuLinkContentAccessControlHandler`), so update/delete of a menu or its links is denied unless the current user's Workbench sections match the menu's assigned sections (checked via `AccessControlHierarchy::checkTree`). It layers *on top of* core — it can only add restrictions, never grant access beyond the core `administer menu` / `administer menu_link_content` permissions, so users still need those. Users with `administer workbench menu access` or `bypass workbench access` skip the section check entirely. Beyond hard denial, it also trims menu-parent `<select>` options on menu-link and node forms (`workbench_menu_access_reduce_options`) so editors only see menus they may write to, and hides the node *Menu settings* fieldset when none are available. Only the `menu` entity type's access tab and one config object (`workbench_menu_access.settings`, storing the active scheme) plus per-menu third-party settings are added. There are no Drush commands.

---

- Let a "Marketing" editorial team manage only the Marketing menu while other teams cannot touch it.
- Delegate the main navigation menu to a specific department without granting site-wide menu admin.
- Restrict which menus a section-scoped editor can add links to.
- Prevent editors from moving a node's menu link into a menu outside their section.
- Hide menu-parent options that belong to menus the current user may not edit.
- Hide the *Menu settings* fieldset on a node form entirely when the user owns no menus.
- Scope menu editing by any Workbench Access scheme (taxonomy-based or menu-based sections).
- Give regional teams control over their own regional menus in a multi-section site.
- Enforce menu delegation at the entity-access layer so direct route access is blocked, not just hidden.
- Assign multiple sections to a single menu so several teams can co-manage it.
- Leave a menu unrestricted by assigning no sections (falls back to core `administer menu`).
- Grant a lead editor `bypass workbench access` to edit every menu regardless of section.
- Reserve `administer workbench menu access` for admins who configure the scheme and per-menu sections.
- Deny delete access to a menu link whose parent menu is outside the editor's section.
- Combine with Workbench Access content sections so the same editorial groups govern both content and menus.
- Switch the whole site's menu delegation to a different access scheme from one settings form.
- Show editors a "You may not edit the menu this content is assigned to" notice instead of an editable widget.
- Keep menu delegation config in code by exporting `workbench_menu_access.settings` and menu third-party settings.
- Support editorial workflows where menu structure must mirror content-section ownership.
- Audit which sections own which menus via each menu's access tab.
