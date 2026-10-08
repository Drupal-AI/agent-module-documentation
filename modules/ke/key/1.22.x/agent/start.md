# key — agent start

Manages site-wide secrets (API keys, passwords, encryption keys) as **Key config entities**
assembled from a *key type* + *key provider* + *key input* plugin. Config UI:
**Admin → Config → System → Keys** (`/admin/config/system/keys`, route
`entity.key.collection`). Fetch values in code via the `key.repository` service.

- Create/manage keys, providers, inputs, config overrides → [configure/key.md](configure/key.md)
- Define a custom KeyType / KeyProvider / KeyInput plugin → [plugins/key.md](plugins/key.md)
- Read key values in code (`key.repository`) → [api/key.md](api/key.md)
- Alter provider definitions via hook → [hooks/key.md](hooks/key.md)
- Drush commands (save, delete, list, value-get) → [drush/key.md](drush/key.md)
- Permissions → [permissions/key.md](permissions/key.md)
