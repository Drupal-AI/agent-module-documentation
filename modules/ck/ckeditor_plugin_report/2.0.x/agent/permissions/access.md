# The report page: route, permission & columns

## Route (`ckeditor_plugin_report.routing.yml`)

```yaml
ckeditor_plugin_report.plugin_report:
  path: '/admin/reports/ckeditor-plugins'
  defaults:
    _controller: '\Drupal\ckeditor_plugin_report\Controller\PluginReportController::content'
    _title: 'CKEditor plugins'
  requirements:
    _permission: 'view ckeditor plugin report'
```

Linked from the Reports overview via `ckeditor_plugin_report.links.menu.yml`
(`parent: system.admin_reports`).

## Permission (`ckeditor_plugin_report.permissions.yml`)

- **`view ckeditor plugin report`** — "View a list of CKEditor plugins provided by enabled
  modules for CKEditor 5". Declared with `restrict access: true` (treated as a
  security-sensitive permission in the admin UI).

Grant it to a role to let that role open the page. Example (config): a
`user.role.<role>` config entity lists it under `permissions`. Programmatically:

```php
$role = \Drupal\user\Entity\Role::load('my_role');
$role->grantPermission('view ckeditor plugin report')->save();
```

## What the page shows (`PluginReportController::content`)

The controller injects the CKEditor 5 plugin manager
(`plugin.manager.ckeditor5.plugin`, via `NULL_ON_INVALID_REFERENCE` so it degrades
gracefully if CKEditor 5 is absent) and builds a `#type => table` inside a details element
titled "CKEditor 5 plugins". One row per definition from `getDefinitions()`, three columns:

| Column | Source |
|---|---|
| Plugin ID | `$definition->id()` |
| Provider | `$definition->getProvider()` (the module machine name) |
| Class | `$definition->getClass()` |

There is nothing to configure — the page simply reflects whatever CKEditor 5 plugins the
enabled modules currently register.
