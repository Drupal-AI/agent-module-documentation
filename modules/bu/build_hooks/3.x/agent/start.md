<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# build_hooks — agent start

Fire a **decoupled/static-site rebuild webhook** from Drupal. Drupal is the content source; this
module triggers the frontend's build ("build hook") **manually** (toolbar → deploy form), on **cron**,
or on **every entity save**. Depends on `views` + `dynamic_entity_reference`. Configure route =
`build_hooks.hook_form` (`/admin/config/build_hooks/settings`).

Core model: a **`frontend_environment`** config entity = one deploy target, bound to a
**FrontendEnvironment plugin** (base module ships only `generic` = POST a URL) + a
`deployment_strategy` (`manual`|`cron`|`entitysave`). A per-environment **`build_hooks_deployment`**
content entity accumulates the changelog of loggable content since the last deploy. The
`build_hooks.trigger` service makes the Guzzle request from the plugin's `BuildHookDetails`.

- Settings (loggable entity types), environments, deploy form, strategies, permissions, cron/auto-deploy
  → [configure/build_hooks.md](configure/build_hooks.md)
- Implement your own environment type (annotation, base class, `getBuildHookDetails()`, forms)
  → [plugins/frontend_environment.md](plugins/frontend_environment.md)
- Trigger deploys in code, the `BuildTrigger`/`ResponseEvent` events, and the plugin-info alter hook
  → [api/build_hooks.md](api/build_hooks.md)

**Provider submodules** (each adds one plugin + a credential settings form) are documented under
`modules/build_hooks_{bitbucket,circleci,github,netlify}/3.x/`.

Key names: config entity `frontend_environment`; content entity `build_hooks_deployment`; plugin type
`frontend_environment` (manager `plugin.manager.frontend_environment`, annotation
`@FrontendEnvironment`, base `Drupal\build_hooks\Plugin\FrontendEnvironmentBase`, interface
`…\Plugin\FrontendEnvironmentInterface`); service `build_hooks.trigger`
(`Drupal\build_hooks\Trigger`); DTO `Drupal\build_hooks\BuildHookDetails`; permissions
`trigger deployments`, `manage frontend environments`; alter hook
`build_hooks_frontend_environment_info`; events `BuildTrigger`, `ResponseEvent`.
