# Hooks & runtime behavior

All behavior lives in `acquia_cms_toolbar.module` and `acquia_cms_toolbar.install`. There is no
service, controller, or config object — the module is procedural hook code.

## Hooks implemented

| Hook | What it does |
| --- | --- |
| `hook_preprocess_html` | Adds body classes `acquia-cms-toolbar` and `acquia-cms-{env}` where `{env}` is `environment-local` / `-ide` / `-dev` / `-stage` / `-prod`. |
| `hook_preprocess_page` | If the current user has core permission `access toolbar`, attaches library `acquia_cms_toolbar/toolbar_styles` (the offset JS) to the page. |
| `hook_toolbar_alter` | When both `user` and `admin_toolbar_tools` toolbar items exist: sets the user tab's wrapper class to `user-toolbar-tab` and attaches `acquia_cms_toolbar/styling` (the CSS) to `admin_toolbar_tools`. |
| `hook_toolbar` | Adds a toolbar item `environment_indicator` (`#weight` 125) — a link to `<front>`, title = the environment name, with icon classes `toolbar-icon toolbar-icon-environment {env}`. |
| `hook_content_model_role_presave_alter(RoleInterface &$role)` | Reacts to a role presave hook fired by `acquia_cms_common`. For roles `content_administrator`, `content_author`, `content_editor`, `developer`, `site_builder`, `user_administrator` it calls `$role->grantPermission('access toolbar')`. |

## Environment indicator

`_acquia_cms_toolbar_get_environment_indicator_color_config(): array` returns
`['name' => …, 'environment' => …]`. It defaults to name `Local` / class `environment-local`, then
uses `Acquia\DrupalEnvironmentDetector\AcquiaDrupalEnvironmentDetector` (from the
`acquia/drupal-environment-detector` package, brought in transitively) to detect an Acquia Cloud
environment:

- `Environment::isAhEnv()` → name becomes `ucfirst(Environment::getAhEnv())`.
- `isAhIdeEnv()` → `environment-ide`, `isAhDevEnv()` → `environment-dev`,
  `isAhStageEnv()` → `environment-stage`, `isAhProdEnv()` → `environment-prod`.

Off Acquia hosting it stays `Local` / `environment-local`. Both the returned `name` (tab title) and
`environment` (CSS class) flow into `hook_toolbar` and `hook_preprocess_html`; the classes are what
the module's CSS colours per environment.

## Permission granting (install)

The module does **not** define permissions — it only hands out the core `access toolbar` permission.

- `acquia_cms_toolbar_update_8001()` → `update_toolbar_role_permission()`: loads all roles and, for
  each of `content_administrator`, `content_author`, `content_editor`, `developer`, `site_builder`,
  `user_administrator` that exists, calls `user_role_grant_permissions($role, ['access toolbar'])`.
- The same grant happens at role-creation time via `hook_content_model_role_presave_alter` (above),
  so a fresh Acquia CMS install wires it up without needing the update hook.

To reproduce the grant manually:

```php
\Drupal::service('module_handler'); // not required; direct API call below
user_role_grant_permissions('content_editor', ['access toolbar']);
```
