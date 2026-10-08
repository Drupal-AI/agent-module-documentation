# Permissions

## Defined by this module (`workbench_menu_access.permissions.yml`)

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer workbench menu access` | TRUE | Both config forms (site scheme + per-menu section assignment), the menu "Access settings" operation link, and the per-menu section `<select>` element. Also **bypasses** the section check in the access handlers (falls straight through to core). |

## Honoured from `workbench_access` (not defined here)

| Permission | Effect |
|---|---|
| `bypass workbench access` | Skips the per-menu section check entirely; the user is treated as unrestricted (core `administer menu` still applies). |

## Core permissions still required

This module only *adds* restrictions on top of Drupal core. To edit a menu or menu link at all a
user still needs the relevant core permission — typically `administer menu` (which covers
`menu` and `menu_link_content` update/delete). Workbench Menu Access can deny such a user for a
specific menu, but it never grants menu access to a user who lacks the core permission.

Note: `administer workbench menu access` is `restrict access: TRUE` — it is an administrative
permission that both configures the delegation and bypasses it, so grant it only to trusted
site administrators. The delegated, lower-trust editors get their access purely from their
Workbench Access section membership plus a core menu permission, not from this permission.
