# Workbench Menu Access — agent index

Delegates per-menu edit access to Workbench Access editorial **sections**. Depends on
`workbench_access`. Config route `workbench_menu_access.admin`. No Drush.

Access model (important):
- Overrides the core access handlers for the `menu` and `menu_link_content` entity types
  (`workbench_menu_access_entity_type_build`). It **adds** restriction on top of core — it can
  only deny, never grant. Users still need core `administer menu` / `administer menu_link_content`.
- A menu is restricted only when BOTH the active scheme is set (`workbench_menu_access.settings`)
  AND the menu has assigned sections (third-party setting). Otherwise `checkSections()` returns
  TRUE (unrestricted) and core's `administer menu` gate alone applies — this fail-open is
  by design ("If no sections are selected, access will not be restricted").
- `administer workbench menu access` or `bypass workbench access` bypass the section check.
- Enforcement is at the entity-access layer (real deny), plus menu-parent option trimming on
  menu-link/node forms for UX. Not just link hiding.

Docs:
- **Global scheme + per-menu section assignment (both config forms, config object, third-party
  settings)** → [configure/menu-access.md](configure/menu-access.md)
- **The one permission it defines and the two bypass permissions it honours** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `workbench_menu_access.settings` → `access_scheme` (id of the active
  `access_scheme` entity, or `0`/unset for "do not restrict").
- Per-menu: `system.menu.<id>.third_party.workbench_menu_access.access_scheme` = array of section ids.
- Section membership resolved via `workbench_access.user_section_storage` +
  `AccessControlHierarchy::checkTree($scheme, $menu_sections, $user_sections)`.
