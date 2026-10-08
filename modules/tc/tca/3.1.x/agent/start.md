# Token Content Access (TCA) — agent index

Gate an entity's **view** access behind a secret URL token (`?tca=<token>`). No standalone
config page (`configure` null); settings are edited on the entity add/edit form and stored in
`tca.tca_settings.*` config entities + per-entity base fields. The base module ships **no**
TcaPlugin, so enable a submodule to pick target entity types.

- **Enable TCA on an entity/bundle, the token/public/force settings, where they live** →
  [configure/settings.md](configure/settings.md)
- **The `tca_plugin` plugin type — add TCA support for a new entity type** →
  [plugins/tca-plugin.md](plugins/tca-plugin.md)
- **The two per-entity-type permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs):
- `tca_node` → [../../modules/tca_node/3.1.x/agent/start.md](../../modules/tca_node/3.1.x/agent/start.md)
- `tca_commerce_product` → [../../modules/tca_commerce_product/3.1.x/agent/start.md](../../modules/tca_commerce_product/3.1.x/agent/start.md)

Key facts:
- Enforcement: `hook_entity_access()` (`tca.module`) → `TcaAccessCheck::access()`
  (`src/Access/TcaAccessCheck.php`) for `view` only. Reads `?tca` query, compares to stored
  token with **`hash_equals()`**; mismatch/empty ⇒ forbidden, match+`public` ⇒ allowed
  (bypasses "view published content"), match+not-public ⇒ neutral.
- Token generation: `TcaSettingsManager::generateToken()` = `Crypt::hashBase64(entityType.id.microtime, private_key . hash_salt)` — strong, site-secret-keyed.
- Base fields (fieldable targets): `tca_active`, `tca_public`, `tca_token`.
- Bundle-level config `tca.tca_settings.<bundle>` supports **`force`** (mandatory TCA).
- Plugin type `tca_plugin` (attribute `\Drupal\tca\Attribute\TcaPlugin`, manager
  `plugin.manager.tca_plugin`); base ships none.
