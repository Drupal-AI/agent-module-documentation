# AOS JS UI — agent index

Admin UI for AOS JS: global settings + CRUD of animation "selectors" (bind AOS options to
CSS selectors, no markup edits). Takes over page-attaching from base `aosjs` when enabled.
`configure` → `aosjs.admin` (`/admin/config/user-interface/aosjs`). One permission:
`administer aos js`. Targets stored in the `aos` DB table; settings in `aosjs.settings`.

- **`aosjs.settings` config keys, routes, page-visibility logic, the `aos` DB table schema, drupalSettings export, the permission** → [configure/settings.md](configure/settings.md)
- **The `aosjs.animate_manager` service (`AosJsManager`) methods** → [api/manager.md](api/manager.md)

Parent module: [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md)

Key facts:
- Routes (all `_permission: administer aos js`): `aosjs.admin` (list), `.add`, `.edit/{aos_id}`, `.delete/{aos_id}`, `.duplicate/{aos_id}`, `.settings`.
- `hook_page_attachments()` gates on `load`, `url` visibility, version/method; exports `drupalSettings.aosjs.elements`.
- Serialized `options` blob is read with `unserialize(..., ['allowed_classes' => FALSE])` (no object injection).
