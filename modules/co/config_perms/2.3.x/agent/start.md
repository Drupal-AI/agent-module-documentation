# Custom Permissions (config_perms) — agent index

Define new, role-assignable permissions that each gate one or more Drupal **routes**,
managed through an admin form and stored as `custom_perms_entity` config entities.

- **What it is / mental model, config entity shape, admin UI, drush recipes** → [configure/config_perms.md](configure/config_perms.md)
- **Create/read/update custom permissions programmatically (entity API, services)** → [api/config_perms.md](api/config_perms.md)
- **The permissions this module provides and how access is decided** → [permissions/config_perms.md](permissions/config_perms.md)

Quick facts:
- Config entity type: `custom_perms_entity`; config prefix `config_perms.custom_perms_entity.<id>`.
- Fields: `id`, `label`, `route`, `status` (+ `uuid`). The **`label` is the permission title**.
- Multiple routes per permission = newline-separated route machine names in `route`.
- Configure UI route: `custom_perms_select_list_form` → `/admin/people/custom-permissions/list`.
- No Drush commands, no plugin types, no dependencies.
