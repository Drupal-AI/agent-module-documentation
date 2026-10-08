<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal.org (drupalorg) — agent index

Site-specific customizations powering **drupal.org**: GitLab integration, inbound webhooks, issue-fork management, security-advisory workflow, Project Browser filter endpoints, and helper services/hooks reflecting drupal.org's role model. Package `DrupalOrg`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

Published for transparency/education — **not meant to be generally reusable**. Its permissions and access hooks only make sense on a site replicating drupal.org's content types and roles.

## Dependencies

- Drupal modules (info.yml): core `block`, core `jsonapi`, contrib `jsonapi_views`.
- Composer/soft: `drupal/contribution_records` (`^1.0@dev`; checked at runtime via `moduleExists`, used by webhooks/breadcrumb), `m4tthumphrey/php-gitlab-api` (`^11`, `\Gitlab\Client` — enforced by `hook_requirements`), plus Guzzle HTTP factory adapters.
- PHP `^7.3 || ^8.0`.
- Submodule: **drupalorg_test_content** (default content for local installs) → [modules/drupalorg_test_content/1.0.x/agent/start.md](modules/drupalorg_test_content/1.0.x/agent/start.md).

## What it provides (from source)

- **Routes / controllers** (`drupalorg.routing.yml`): 3 webhook POST endpoints (`WebhooksController`), 4 issue-fork endpoints (`IssueForksController`), 1 Project Browser endpoint (`ProjectBrowserController`), 2 admin settings forms. See [controllers/routes.md](controllers/routes.md).
- **GitLab client** (`Traits/GitLabClientTrait`, `Utilities/GitLabClientHelper`, `Utilities/GitLabTokenRenew`). See [api/gitlab.md](api/gitlab.md).
- **Services** (`drupalorg.services.yml`): `ProjectService`, `UserService`, `OrganizationService`; breadcrumb builder; two event subscribers; a logger channel. Plus `.module` access hooks and `ExtraPermissions` dynamic permissions. See [api/services-and-hooks.md](api/services-and-hooks.md).
- **Queue workers** (`src/Plugin/QueueWorker/`): project-activity, contribution-activity, security-issue, issue-forks. See [plugins/queue-workers.md](plugins/queue-workers.md).
- **Blocks + theme + libraries** (`src/Plugin/Block/`): documentation issue submission, documentation tree, sponsor widget. See [plugins/blocks.md](plugins/blocks.md).
- **Config, forms, schema, cron, Drush, utilities**: config objects `drupalorg.gitlab_settings` + `drupalorg.settings`; `GitLabSettingsForm` + `DrupalOrgSettingsForm`; `hook_requirements`/`hook_schema`; `DrushCommands`; `Utilities/{ActiveInstalls,CoreCompatibility,ComposerNamespace}`. See [config/settings.md](config/settings.md).
- **Permissions** (`drupalorg.permissions.yml` + `ExtraPermissions`): static `manage security releases`; dynamic `view any unpublished <type> content` per node type.
- **Views**: `DrupalOrgNodeStatus` filter (id `drupalorg_node_status`) + `hook_views_data_alter`.

## Custom DB tables (`drupalorg.install`)

`project_usage_week_release`, `project_maintainer`, `drupalorg_project_repositories` (Drupal-nid ↔ GitLab project map), `drupalorg_project_release_supported_versions`. Populated by migrations; read by the services.
