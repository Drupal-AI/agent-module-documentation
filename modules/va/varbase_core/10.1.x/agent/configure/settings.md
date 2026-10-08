# Varbase Core — general settings

The only settings UI Varbase Core adds for itself. Two routes:

| Route | Path | Handler | Permission |
|---|---|---|---|
| `varbase_core.settings_index` | `/admin/config/varbase` | core `SystemController::systemAdminMenuBlockPage` (renders the child-menu landing page) | `access varbase settings` |
| `varbase_core.general_settings` | `/admin/config/varbase/settings` | `Drupal\varbase_core\Form\VarbaseGeneralSettingsForm` | `access varbase settings` |

`settings_index` is just a landing page listing links to everything placed under
`system.admin_config` by Varbase modules — it holds no fields of its own.

## Config object

`varbase_core.general_settings` (`config_object`, schema in `config/schema/varbase_core.schema.yml`,
default install values in `config/optional/varbase_core.general_settings.yml`).

| Key | Type | Default | Form label / effect |
|---|---|---|---|
| `welcome_status` | boolean | `1` | "Allow site to show welcome message" — when on, appending `?welcome` to the front page shows the Varbase welcome message. Auto-disabled after the message is closed. |
| `allow_custom_account_name` | boolean | `1` | "Allow custom account name" — lets users set/change a custom username. Read by `hook_email_registration_name_alter` (see [hooks](../hooks/hooks.md)); when off, email-registration usernames are not overridden by the account name. |

`VarbaseGeneralSettingsForm` is a standard `ConfigFormBase`; on submit it saves the two values then
calls `drupal_flush_all_caches()`.

## Set via drush / PHP

```bash
drush config:set varbase_core.general_settings welcome_status 0 -y
drush config:set varbase_core.general_settings allow_custom_account_name 0 -y
```

```php
\Drupal::configFactory()
  ->getEditable('varbase_core.general_settings')
  ->set('welcome_status', FALSE)
  ->set('allow_custom_account_name', FALSE)
  ->save();
```

Both read sites default to enabled: code uses `?? 1` / `?? TRUE` when the key is unset.
