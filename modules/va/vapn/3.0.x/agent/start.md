# View access per node (VAPN) — agent index

Per-node **view** access control. On the content types you enable, each node gets a
**View access per node** field (`vapn`, an unlimited `user_role` reference); a node with
roles selected is viewable only by users holding one of those roles. Affects **view only**
(not create/update/delete).

- **Enable it on content types + how view access is decided + set roles per node** →
  [configure/setup.md](configure/setup.md)
- **Permissions (administer / use / bypass vapn)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route `vapn.settings` → `/admin/config/people/vapn`. Config object
  `vapn.settings`, key `bundles` — a map of enabled node bundle → `true`
  (e.g. `bundles: { article: true }`). Baseline ships empty (`bundles: {}`).
- The `vapn` field is defined in **code** (`hook_entity_bundle_field_info()`), attached to a
  bundle only when it is listed in `vapn.settings.bundles`; it shows as a vertical tab on the
  node form (`options_buttons` widget).
- Access rule (`hook_node_access`, op `view`): roles selected → allow only those roles; no
  roles selected → VAPN abstains (neutral). `bypass vapn` permission always allows.
- Field-edit access gated by `use vapn` / `administer vapn` (`hook_entity_field_access`).
- No Drush. Provides permissions + config schema. 3.x is field-based; `vapn_update_9000`
  migrates the old 2.x `{vapn}` table and `manage vapn settings` permission.
