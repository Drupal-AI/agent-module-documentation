# Configure Advanced Email Validation

Form: `/admin/config/people/advanced-email-validation` (route
`advanced_email_validation.settings`, `Form\SettingsForm`, permission
`administer advanced email validation`). Config object: **`advanced_email_validation.settings`**.

## Config schema (`advanced_email_validation.settings`)

| Key | Type | Meaning |
|---|---|---|
| `override_site_defaults` | bool | (used by the Webform handler mapping; global settings are the site defaults) |
| `rules.mx_lookup` | bool | require the domain to have MX records |
| `rules.disposable` | bool | reject disposable/throwaway domains |
| `rules.free` | bool | reject free providers (gmail, yahoo, …) |
| `rules.banned` | bool | reject domains in your banned list |
| `error_messages.basic` | text | message for a basic RFC failure |
| `error_messages.mx_lookup` | text | message for MX failure |
| `error_messages.disposable` | text | message for disposable domain |
| `error_messages.free` | text | message for free domain |
| `error_messages.banned` | text | message for banned domain |
| `domain_lists.disposable[]` | string seq | your extra/override disposable domains |
| `domain_lists.free[]` | string seq | your extra/override free domains |
| `domain_lists.banned[]` | string seq | your banned domains |
| `local_list_only.disposable` | bool | use ONLY your disposable list (skip library's bundled list) |
| `local_list_only.free` | bool | use ONLY your free list |
| `validate_account_on.created` | bool | validate on **new** account registration |
| `validate_account_on.updated` | bool | validate on account **email change** |

There is no `banned` "local only" flag — the banned list is always your own list.

## When validation runs

Set via `validate_account_on`. On rebuild the module (`hook_entity_base_field_info_alter`)
attaches:
- `AEVNewEmail` constraint to `user.mail` when `validate_account_on.created` is TRUE.
- `AEVChangedEmail` constraint when `validate_account_on.updated` is TRUE.

If neither is set, account email is not validated (the service can still be called manually or
via the Webform handler). After changing `validate_account_on`, clear caches so the base-field
constraints are re-read (`drush cr`).

## Error messages & translation

Messages are stored in config and rendered as the constraint violation. They are translatable
through core **Configuration Translation** (`config_translation`); the module ships
`advanced_email_validation.config_translation.yml`. Edit per-language under the config
translation UI for the settings form.

## Drush

No custom Drush. Read/write config the usual way, e.g.:
```
drush cget advanced_email_validation.settings rules
drush cset advanced_email_validation.settings rules.disposable true -y
```
