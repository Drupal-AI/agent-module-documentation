<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Environment Variables (env_variables) — agent index

Small utility module that loads a configured `.env` file with `vlucas/phpdotenv` and lists the
resulting environment variables on an admin page. Also ships an injectable service to load the
`.env` from custom code. Version **3.0.0**. `core_version_requirement: ">=8"`. License GPL-2.0-or-later.
No Drupal module dependencies; requires the PHP library `vlucas/phpdotenv` (`^5.0`) via Composer.

- **Settings form, routes, permissions, config object, controller & template** →
  [config/settings.md](config/settings.md)
- **The `env_variables` / `DotEnvServices` service (inject to load a `.env`)** →
  [api/service.md](api/service.md)

## What it actually is (from source)

- **Two routes** (`env_variables.routing.yml`):
  - `env_variables.viewenv` → `/admin/config/env/list`, `_permission: 'View env_variables'`,
    controller `ViewEnvironmentVariablesController::view_env_variables()`.
  - `env_variables.config.form` → `/admin/config/env/settings`, `_permission: 'Edit Environment Variables'`,
    form `EnvironmentVariablesSettingsForm` (the module's `configure` route).
- **One permission declared** (`env_variables.permissions.yml`): `View env_variables`
  (title "View Environment Variables"). The settings route references a second permission name,
  `Edit Environment Variables`, which is **not declared** in the permissions file (see notes below).
- **One config object**: `env_variables.settings` with a single key `env_path`
  (`config/install/env_variables.settings.yml`, default `''`). **No `config/schema/`** ships.
- **One service** (`env_variables.services.yml`): `env_variables` →
  `Drupal\env_variables\Services\DotEnvServices`, args `@request_stack`, `@logger.factory`.
- **One theme hook** (`env_variables_theme()` in `.module`): `view_env_variables`, variable
  `result`, template `templates/view-env-variables.html.twig` (a two-column HTML table).
- **Menu links** (`env_variables.links.menu.yml`): "Environment Settings" under
  `system.admin_config`, with child links "Settings" and "List".
- No entities, no plugin types, no Drush commands, no hooks beyond `hook_theme()`, no `.install`.

## Mechanism (from source)

- `ViewEnvironmentVariablesController::view_env_variables()` reads `env_path` from
  `env_variables.settings`, calls `DotEnvServices::loadEnvFile($env_path)`, then returns a
  `#theme => 'view_env_variables'` render array with `#result => $_ENV`.
- `DotEnvServices::loadEnvFile($path)` builds `DOCUMENT_ROOT . $path`, calls
  `Dotenv::createMutable($dir)->load()` (the mutable loader populates the process environment),
  and logs any exception to the `env_variables` logger channel.
- The template iterates `result` and prints each `key`/`value` (Twig auto-escapes values).

## Notes / caveats

- The settings route requires permission `Edit Environment Variables`, but only `View env_variables`
  is declared in `env_variables.permissions.yml`; an undeclared permission is held by no role, so the
  settings form is reachable only by the superuser (uid 1) until the permission is declared/assigned.
- `env_variables.settings` has no schema file, so `env_path` is untyped in config
  (`drush config:*`/translation may warn). This is a packaging gap, not a behavioral one.
