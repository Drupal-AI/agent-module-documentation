# Configure — settings form, route, permission

## Screen

`/admin/config/config_suite/admin_settings` — route `config_suite.config_suite_form`, form
`Drupal\config_suite\Form\AdminSettingsForm` (`src/Form/AdminSettingsForm.php`, form id
`config_suite_form`), a standard `ConfigFormBase`. Linked from the admin menu under
*Configuration → Development* (`config_suite.links.menu.yml`, parent `system.admin_config_development`,
weight 99).

Access: `_permission: 'administer config suite'` (defined in `config_suite.permissions.yml`).
`options._admin_route: TRUE`. It is a standard Form API admin settings form (`ConfigFormBase`).

## The two settings

Both live in the `config_suite.settings` config object (schema
`config/schema/config_suite.schema.yml`, install defaults `config/install/config_suite.settings.yml`).
There is nothing else to configure.

| Key | Type | Default | Checkbox label | Effect |
|---|---|---|---|---|
| `automatic_export` | boolean | `TRUE` | Automatic Export | When on, every config save is copied to the sync directory. See [../api/subscribers.md](../api/subscribers.md) → export. |
| `automatic_import` | boolean | `TRUE` | Automatic Import | When on, a full config import runs from the sync directory on any request by a user in the `administrator` role, when the sync dir is newer than the last config-cache write. See [../api/subscribers.md](../api/subscribers.md) → import. |

Read them from code:

```php
$c = \Drupal::config('config_suite.settings');
$c->get('automatic_import'); // bool
$c->get('automatic_export'); // bool
```

Set them (no dedicated Drush command — use core `config:set`):

```
drush config:set config_suite.settings automatic_export 0 -y
drush config:set config_suite.settings automatic_import 0 -y
```

Note: the install config declares an **enforced** module dependency on `config_suite`, so the
`config_suite.settings` object is removed automatically when the module is uninstalled.
