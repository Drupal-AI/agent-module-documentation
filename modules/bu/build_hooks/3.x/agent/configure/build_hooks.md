<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring build_hooks

Grounded in `build_hooks.routing.yml`, `build_hooks.permissions.yml`,
`config/install/build_hooks.settings.yml`, `config/schema/build_hooks.schema.yml`,
`src/Entity/FrontendEnvironment.php`, `src/Form/{SettingsForm,DeploymentForm,FrontendEnvironmentForm}.php`,
and `build_hooks.module`.

## Admin routes & permissions

| Route | Path | Permission | Purpose |
|---|---|---|---|
| `build_hooks.hook_form` (the `configure` route) | `/admin/config/build_hooks/settings` | `administer site configuration` | Pick which entity types are logged. |
| `entity.frontend_environment.collection` | `/admin/config/build_hooks/frontend_environment` | `manage frontend environments` | List/add/edit/delete environments. |
| `build_hooks.frontend_environment_plugin_types` | `/admin/config/build_hooks/frontend_environment_plugin_types` | `manage frontend environments` | Choose a plugin type when adding. |
| `build_hooks.deployment_form` | `/admin/build_hooks/deployments/{frontend_environment}` | `trigger deployments` | Review changelog + press deploy. |

Two permissions (both `restrict access: true`): **`manage frontend environments`** (also the
`admin_permission` of the `frontend_environment` config entity) and **`trigger deployments`** (also the
`admin_permission` of the `build_hooks_deployment` content entity). The deploy form is a normal Drupal
`FormBase` POST — CSRF-protected by core and gated by `trigger deployments`.

## 1. Settings: which content is "loggable"

`build_hooks.settings` has one key. Default (`config/install`):

```yaml
logging:
  entity_types:
    - node
```

Only changes to these entity types are recorded into deployments and counted in the toolbar
(`DeployLogger::isEntityTypeLoggable()`). Set it via drush:

```bash
drush cset build_hooks.settings logging.entity_types.0 node -y
drush cset build_hooks.settings logging.entity_types.1 media -y
drush cget build_hooks.settings logging.entity_types
```

## 2. Frontend environments (the deploy targets)

A `frontend_environment` is a **config entity** (`config_prefix: frontend_environment`). Exported keys
(`config_export`): `id`, `label`, `weight`, `provider`, `plugin`, `settings`, `url`, `deployment_strategy`.
`plugin` is the FrontendEnvironment plugin id; `settings` is that plugin's own configuration (schema
`frontend_environment.settings.[%parent.plugin]`). The base module ships one plugin: **`generic`**
(`build_hook_url` → POST). Provider submodules add more (`bitbucket`, `circleciv2`, `github`, `netlify`, …).

Create one in the UI (Add Frontend environment → pick type → fill fields), or in code/config. A generic
environment as exported config (`frontend_environment.frontend_environment.prod.yml`):

```yaml
id: prod
label: 'Production (Gatsby)'
weight: 0
provider: build_hooks
plugin: generic
deployment_strategy: manual
url: 'https://example.com'
settings:
  id: generic
  label: 'Production (Gatsby)'
  provider: build_hooks
  build_hook_url: 'https://api.netlify.com/build_hooks/XXXX'
```

Programmatic creation:

```php
\Drupal::entityTypeManager()->getStorage('frontend_environment')->create([
  'id' => 'prod',
  'label' => 'Production (Gatsby)',
  'plugin' => 'generic',
  'deployment_strategy' => 'manual',
  'settings' => ['build_hook_url' => 'https://api.netlify.com/build_hooks/XXXX'],
])->save();
```

List them: `drush config:status` / `drush cget frontend_environment.frontend_environment.prod`.

## 3. Deployment strategy (when it fires)

`deployment_strategy` is one of (`Drupal\build_hooks\TriggerInterface`):

- **`manual`** — only when a user presses deploy on the deployment form.
- **`cron`** — `build_hooks_cron()` → `Trigger::deployFrontendCronEnvironments()` fires every environment
  with this strategy on each cron run.
- **`entitysave`** — `hook_entity_insert/update/delete` on any *loggable* entity fires every environment
  with this strategy immediately (`Trigger::deployFrontendEntityUpdateEnvironments()`).

## 4. The deploy flow

Editors see a toolbar item per environment with a change counter (built in `build_hooks_toolbar()`,
cached against the `build_hooks_toolbar` cache tag). Clicking it opens the deployment form, which shows
the `build_hooks_deployment` changelog (created/updated items via a dynamic_entity_reference `contents`
field, deleted items as strings) plus any plugin-supplied elements (`getAdditionalDeployFormElements()`),
and a deploy button. Deploying calls `Trigger::triggerBuildHookForEnvironment()` → the plugin's
`getBuildHookDetails()` → a Guzzle request; on success `DeployLogger::setLastDeployTimeForEnvironment()`
closes the current deployment and starts a new (empty) one.

Trigger a deploy from drush without the UI:

```bash
drush php:eval '\Drupal::service("build_hooks.trigger")->triggerBuildHookForEnvironment(
  \Drupal::entityTypeManager()->getStorage("frontend_environment")->load("prod"));'
```

## Provider credentials

Provider submodules keep their credential in a **separate** simple-config object
(`build_hooks_{provider}.settings`), configured on the provider's own settings form — not on the
environment entity (except CircleCI v2, which stores its token on the environment). See each submodule's
`configure` doc.
