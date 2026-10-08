# Access by Reference — agent index

Grants a logged-in user CRUD access to a node when the node references that user (or a value
they share), via `hook_node_access`. No fields added; rules are `abrconfig` config entities.
Config UI: `entity.abrconfig.collection` (`/admin/config/content/access_by_ref`). Only ever
*widens* access (returns allowed/neutral, never denied).

- **The `abrconfig` config entity, the four reference types, read/update/delete grants, the
  grant algorithm and its caching** → [configure/config.md](configure/config.md)
- **The two permissions and which trust level each implies** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Grant logic lives in `src/Hook/AccessByRefHooks.php::nodeAccess()`. Gate: op != `create`,
  user is authenticated (`uid != 0`), and holds `access node by reference`.
- Reference types: `user`, `user_mail`, `shared` (uses the *Extra* user field), `inherit`
  (transitive/chainable; **no infinite-loop protection**).
- Grants map read→`view`, update→`update`, delete→`delete` from the config's three booleans.
- Config schema: `access_by_ref.abrconfig.*` (id, label, bundle, field, reference_type, extra,
  rights_type, rights_read, rights_update, rights_delete). Config entity id `abrconfig`.
- A D7 migration `d7_access_by_ref` is provided (`migrations/`).
