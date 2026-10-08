# Module settings

Config object `encrypt.settings`. Admin form at
`/admin/config/system/encryption/profiles/settings` (route `encrypt.settings`, form
`Drupal\encrypt\Form\EncryptSettingsForm`, permission `administer encrypt`).

| Key | Default | Effect |
|---|---|---|
| `check_profile_status` | `true` | On the profiles overview page, validate each profile (loads its key). Disable if you have many profiles / performance issues, or to avoid loading key material during the status check. |
| `allow_deprecated_plugins` | `false` | When TRUE, deprecated encryption methods may be selected for **new** profiles. When FALSE, deprecated methods are usable only by existing profiles. Consumed by `EncryptService::loadEncryptionMethods()`. |

Set via drush without the UI:
```
drush config:set encrypt.settings allow_deprecated_plugins 1 -y
drush config:set encrypt.settings check_profile_status 0 -y
```
