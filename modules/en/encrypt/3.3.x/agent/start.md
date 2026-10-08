# encrypt — agent start

Two-way encryption API. Binds an `EncryptionMethod` plugin (cipher) to a `key` (Key module)
via `encryption_profile` config entities. Requires `key`. Requires Drupal **10.3+ or 11**
(`core_version_requirement: ^10.3 || ^11`). Config UI: **Admin → Config → System →
Encryption profiles** (`/admin/config/system/encryption/profiles`, route
`entity.encryption_profile.collection`).

- Create/manage/test encryption profiles → [configure/profiles.md](configure/profiles.md)
- Module-wide settings (deprecated plugins, validation display) → [settings/settings.md](settings/settings.md)
- Encrypt/decrypt in code (`encryption` service) → [api/service.md](api/service.md)
- Implement a custom encryption method (plugin) → [plugins/encryption-method.md](plugins/encryption-method.md)
- Drush commands → [drush/commands.md](drush/commands.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
