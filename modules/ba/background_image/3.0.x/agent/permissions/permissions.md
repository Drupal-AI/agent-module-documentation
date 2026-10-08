# Permissions

Defined in `background_image.permissions.yml`:

- **`administer background image`** — `restrict access: TRUE`. Full control over background image
  entities and configuration (create/edit/delete background images, manage settings). Because it is
  `restrict access`, treat it as a trusted-admin permission; grant only to roles you fully trust.

The settings form route (`background_image.settings`) is separately gated by core
`administer site configuration`, not by the module permission.

No other permissions are defined. Media upload/library access is governed by the core Media
module's own permissions.
