<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, routes, permission & config

## Install & enable

```bash
composer require drupal/drupalforge_deploy   # pulls backup_migrate_aws_s3 (+ backup_migrate)
drush en drupalforge_deploy -y
```

`drupalforge_deploy.info.yml`: `lifecycle: experimental`, `configure: drupalforge_deploy.deploy`,
dependency `backup_migrate_aws_s3:backup_migrate_aws_s3`. This is a **0.0.x pre-release**
(packaged `version: 0.0.0`). `composer.json` `require` = only `drupal/backup_migrate_aws_s3: "*"`.

## Permission (`drupalforge_deploy.permissions.yml`)

- `administer drupalforge deploy` — title *"Administer Drupal Forge Deployment"*,
  `restrict access: true`. This is the **only** permission and it gates **both** routes below.

## Routes (`drupalforge_deploy.routing.yml`)

| Route id | Path | Handler | Requirement |
|---|---|---|---|
| `drupalforge_deploy.deploy` | `/admin/config/development/drupalforge-deploy` | `_form: DrupalForgeDeployForm`, `_title_callback: DrupalForgeDeployForm::pageTitle` | `_permission: 'administer drupalforge deploy'` |
| `drupalforge_deploy.git_reference_autocomplete` | `/admin/config/development/drupalforge-deploy/git-reference-autocomplete` | `_controller: GitReferenceAutocompleteController::autocomplete` | `_permission: 'administer drupalforge deploy'` |

Menu link `drupalforge_deploy.deploy_menu` (parent `system.admin_config_development`, weight 100) and
local task `drupalforge_deploy.deploy_tab` both point at `drupalforge_deploy.deploy`.

## Config schema (`config/schema/drupalforge_deploy.schema.yml`)

```yaml
drupalforge_deploy.settings:
  type: config_object
  mapping:
    deployment_env_vars:
      type: text
```

- Single config object, single key `deployment_env_vars` — a `KEY=VALUE`-per-line string of extra
  deployment environment variables. There is **no `config/install/`**, so the object starts absent
  and is created on first save of the deploy form (`submitForm()` writes it via `getEditable()`).
- `deployment_env_vars` is parsed by `DeploymentUrlBuilder::parseEnvironmentVariables()` and merged
  into launch parameters; derived keys `DP_REPO_BRANCH` / `DP_IMAGE` are stripped before persistence.

## Hook

`hook_help()` is implemented OOP in `DrupalForgeDeployHooks::help()` (`#[Hook('help')]`), with a
`#[LegacyHook]` shim in `drupalforge_deploy.module` delegating to the service. It returns help only
for `help.page.drupalforge_deploy`, listing requirements and `git remote add` examples.

## Libraries (`drupalforge_deploy.libraries.yml`)

- `step_navigation` — `js/deploy-step-navigation.js` (deps `core/drupal`, `core/once`).
- `deploy_sync` — `js/drupalforge-deploy.js` + `css/deploy.css` (deps `core/drupal`, `core/once`).

Both are internal; no external/CDN front-end library dependencies.
