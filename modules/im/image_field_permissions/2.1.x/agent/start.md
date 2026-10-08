<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Field Permissions (image_field_permissions) — agent index

**Pseudo-field-level permissions for image fields: control create/edit/view of the image file plus alt and title attributes per role.**

- **Version:** 2.1.x (2.1.0-alpha1)
- **Core:** ^9 || ^10 || ^11 · **Requires:** core `image`, `field_permissions`
- **Plugin:** `AdvancedCustomAccess` (FieldPermissionType, extends Field Permissions `CustomAccess`) — adds edit own/any **alt** and **title** permissions on top of the file create/edit/view permissions.
- **Service:** `image_field_permissions.permissions_service` (`ImageFieldPermissionsPermissionsService`, args `entity_type.manager`, `plugin.field_permissions.types.manager`) → `getPseudoFieldAccess()`.
- **ServiceProvider:** `ImageFieldPermissionsServiceProvider` registers the plugin.
- **Enforcement:** `hook_form_node_form_alter()` hides upload/remove buttons and restricted alt/title sub-widgets via `#process` callbacks. Permissions surface on the field's "Custom permissions" setting and the People → Permissions page.

**Security:** This is an access-control module; it restricts image-field editing rather than exposing endpoints. No custom routes or anonymous surface. Form enforcement is implemented in `hook_form_node_form_alter` (node forms).