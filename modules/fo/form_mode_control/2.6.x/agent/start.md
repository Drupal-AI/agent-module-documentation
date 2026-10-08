# Form Mode Control — agent index

Chooses which entity **form mode** (create/edit form display) is used, per bundle and per
role, and lets permitted users switch with a `?display=<form_mode_id>` URL query parameter.
No field type/widget/entity of its own; it only alters which core `entity_form_display`
core loads. Dependency: `field`.

- **Set the default form mode per entity/bundle/operation/role; the `?display=` switch; config shape** →
  [configure/form-modes.md](configure/form-modes.md)
- **The dynamic per-form-mode permissions and `access_all_form_modes`** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `form_mode_control.settings` key `defaults` → `entity_type.bundle.operation.role = form_mode_id`, where `operation` is `create` or `update`.
- Admin form route `form_mode_control.configuration` at `/admin/structure/display-modes/form/config-form-modes`.
- Switching: append `?display=<form_mode_id>` to an add/edit URL; only applied if the user has the matching per-form-mode permission or `access_all_form_modes`.
- When multiple roles apply, the role with the **highest weight** decides the default.
- The switch/default only take effect if the target form display exists and is **enabled** (status = true) for that bundle.
