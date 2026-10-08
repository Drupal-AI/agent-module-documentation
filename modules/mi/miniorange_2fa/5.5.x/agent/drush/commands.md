# miniOrange 2FA Drush command

Source: `src/Commands/Miniorange2faDrushCommands.php` (registered via `drush.services.yml`).

| Command | Alias | Args | Effect |
|---|---|---|---|
| `miniorange_2fa:change-status` | `mo-2fa-status` | `<action> <email>` | Enable or disable 2FA for the user with the given email. `<action>` must be `enable` or `disable`. |

```bash
ddev drush miniorange_2fa:change-status enable  user@example.com
ddev drush mo-2fa-status                disable user@example.com
```

Behaviour / guards:
- **Refuses unless `mo_auth_2fa_drush` is enabled** in `miniorange_2fa.settings` ("Drush control for 2FA
  is disabled in configuration. Cannot proceed."). Turn it on in the module's advanced settings first.
- Validates the action is `enable`/`disable`.
- Looks the user up in the `UserAuthenticationType` table by `miniorange_registered_email` (falls back to
  a Drupal user lookup by mail). Errors if the user has not configured 2FA yet.
- Updates the `enabled` flag for that user's 2FA record.

This is the only Drush command the module provides. There is no CLI command to configure methods or to
bypass the second factor; method setup happens through the admin UI / miniOrange cloud.
