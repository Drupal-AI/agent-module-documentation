# Encryption profiles

Config entity `encryption_profile` (config prefix `encrypt.profile.*`), managed at
`/admin/config/system/encryption/profiles` (route `entity.encryption_profile.collection`,
permission `administer encrypt`).

## Create one (UI)
Add profile → pick an **Encryption method** (an `EncryptionMethod` plugin) → pick a **Key**
(a Key entity providing the secret). Save. Each profile links exactly one method + one key.
Routes: add/edit `.../profiles/add`, `.../profiles/manage/{id}`;
**test** at `.../profiles/manage/{id}/test` round-trips a sample string to confirm setup;
delete at `.../profiles/manage/{id}/delete`.

## As config (exportable)
`config/sync/encrypt.profile.<id>.yml`:
```yaml
id: my_profile
label: 'My profile'
encryption_method: 'real_aes'        # EncryptionMethod plugin id (e.g. from Real AES)
encryption_method_configuration: {}  # optional per-method settings
encryption_key: 'my_aes_key'         # Key entity id
```
- The cipher lives in the plugin; the secret lives in the **Key** module (env var, file,
  KMS…), so the profile references but never stores the key material.
- A method can restrict which key types are selectable and can be marked deprecated.
  Deprecated methods are hidden from new profiles unless `allow_deprecated_plugins` is set
  (see [../settings/settings.md](../settings/settings.md)).
- Import with `drush config:import`. Validate with `drush encrypt:validate-profile <id>`
  (see [../drush/commands.md](../drush/commands.md)).
