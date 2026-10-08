<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, routes, permissions & list page

## Install / enable

Composer is required because of the `vlucas/phpdotenv` (`^5.0`) library:

```
composer require drupal/env_variables
drush en env_variables -y
```

No `.install` file, no schema updates, no entities.

## Routes (`env_variables.routing.yml`)

| Route id | Path | Requirement | Handler |
|---|---|---|---|
| `env_variables.viewenv` | `/admin/config/env/list` | `_permission: 'View env_variables'` | `ViewEnvironmentVariablesController::view_env_variables()` |
| `env_variables.config.form` | `/admin/config/env/settings` | `_permission: 'Edit Environment Variables'` | `EnvironmentVariablesSettingsForm` |

`env_variables.config.form` is the module's declared `configure` route (info.yml).

## Permissions (`env_variables.permissions.yml`)

Only one permission is declared:

```yaml
'View env_variables':
  title: View Environment Variables
```

The settings route names permission `Edit Environment Variables`, which is **not declared** here.
Drupal grants an undeclared permission to no role, so the settings form is reachable only by the
superuser (uid 1) unless a maintainer declares/assigns that permission. Assign `View env_variables`
on `/admin/people/permissions` to control who reaches the list page.

## Config object

- Object: `env_variables.settings` (install default in `config/install/env_variables.settings.yml`).
- Single key: `env_path` (string, default `''`).
- **No `config/schema/`** ships, so `env_path` is untyped in configuration.

## Settings form — `EnvironmentVariablesSettingsForm`

`src/Form/EnvironmentVariablesSettingsForm.php`, extends `ConfigFormBase`.

- `getFormId()` → `env_variables_admin_settings`; `getEditableConfigNames()` → `env_variables.settings`.
- `buildForm()` renders one textfield `env_path` (title "Path (.env file)", description example
  `"/../" for outside docroot`), defaulted from the config value.
- `submitForm()` writes `env_path` to `env_variables.settings` and saves.

Path is interpreted relative to the request `DOCUMENT_ROOT` (see [../api/service.md](../api/service.md)).
Typical values: `/../` (outside docroot), `/` (docroot), `/env` (a `docroot/env` folder).

## List page — `ViewEnvironmentVariablesController`

`src/Controller/ViewEnvironmentVariablesController.php`, extends `ControllerBase`; constructed with
`config.factory` and the `env_variables` service.

`view_env_variables()`:
1. reads `env_path` from `env_variables.settings`;
2. calls `DotEnvServices::loadEnvFile($env_path)` (loads the `.env` into the process environment);
3. returns `['#theme' => 'view_env_variables', '#result' => $_ENV]`.

## Theme / template

`env_variables_theme()` (in `env_variables.module`) registers theme hook `view_env_variables`
(variable `result`, template `templates/view-env-variables.html.twig`). The template renders a
two-column HTML table (`Variable Name` / `Value`) by iterating `result`; Twig auto-escapes each value.
Override the template or theme hook to change presentation.

## Menu links (`env_variables.links.menu.yml`)

`env_variables.config.link.form` ("Environment Settings") under `system.admin_config`, with children
"Settings" (→ settings form) and "List" (→ list page).
