# entity_clone — agent start

Adds a **Clone** operation/link (`clone-form` template, route pattern
`/entity_clone/{entity_type}/{id}`) to all content & config entities via
`hook_entity_type_build()`. Copies with `createDuplicate()`, optionally recursing into
clonable reference fields. Special handlers for file/user/term/menu/field/Layout Builder.
Config UI: `/admin/config/system/entity-clone` (route `entity_clone.settings`).

- Global + per-type/bundle settings, cloneable entities → [configure/settings.md](configure/settings.md)
- Permissions (`administer entity clone` + `clone {type} entity`) → [permissions/permissions.md](permissions/permissions.md)
- PRE_CLONE / POST_CLONE events → [hooks/events.md](hooks/events.md)
- Custom clone handler for an entity type → [extend/clone-handler.md](extend/clone-handler.md)

Submodule: **entity_clone_extras** (bundle-level node/media clone permissions) — documented
separately.
