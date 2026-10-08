# Permissions

Defined in `menu_link_attributes.permissions.yml`:

- **`use menu link attributes`** — allows setting attribute values within the menu link
  create/edit forms. Without it the Attributes fieldset is not shown and existing values are
  preserved on save (read-only for that user).
- **`administer menu link attributes`** — restricted (`restrict access: true`). Grants access
  to the available-attributes config form (`/admin/config/menu_link_attributes/config`) and
  shows the "Manage available attributes here" helper link on the menu link form.
