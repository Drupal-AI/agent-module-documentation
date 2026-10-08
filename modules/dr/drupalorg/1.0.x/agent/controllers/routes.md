<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes & controllers

All routes are in `drupalorg.routing.yml`.

## Webhook endpoints — `WebhooksController` (`src/Controller/WebhooksController.php`)

POST-only, `_access: 'TRUE'` (anonymous — auth is done inside the controller by a shared secret token). Each handler returns a `JsonResponse` `{status, message}` and, on success, pushes one item to a queue (it does not act synchronously).

| Route | Path | Method | Token checked | Queue |
|---|---|---|---|---|
| `drupalorg.project_webhook` | `/drupalorg-api/webhook/project-activity` | POST | `X-Gitlab-Token` header vs `drupalorg.gitlab_settings:webhook_token` | `drupalorg_project_activity_webhook_queue_worker` |
| `drupalorg.contribution_activity_webhook` | `/drupalorg-api/webhook/contribution-activity` | POST | `X-Gitlab-Token` **or** `Drupalorg-Credit-Migration-Token` vs `drupalorg.settings:credit_migration_token` | `drupalorg_contribution_activity_webhook_queue_worker` |
| `drupalorg.security_activity_webhook` | `/drupalorg-api/webhook/security-issue` | POST | `X-Gitlab-Token` header | `drupalorg_security_issue_webhook_queue_worker` |

Token check is a strict comparison guarded by `!empty($token)` (e.g. `!empty($gitlab_token) && $request->server->get('HTTP_X_GITLAB_TOKEN') === $gitlab_token`). `projectWebhook()` only queues on `event_name == 'repository_update'`; `securityIssueWebhook()` builds an item with `object_kind`/`action`/`iid`/`discussion_id` and label-change diffs; `contributionActivityWebhook()` branches by `event_type` (issue / merge_request / note) for GitLab payloads and by `event_type` (issue / comment) for legacy drupal.org form-POST payloads. Set the hooks on GitLab at `<instance>/admin/hooks`, `<instance>/groups/project/-/hooks`, `<instance>/groups/security/-/hooks` (see route file comments).

## Issue-fork endpoints — `IssueForksController` (`src/Controller/IssueForksController.php`)

Uses `GitLabClientTrait`. Const `FORK_NAME_PREFIX = 'drupalorg-'`. All read `source_link`/`fork_id`/`fork_name` from the query string; `getProjectAndIssueIdFromUrl()` validates `source_link` host against an allowlist (`GitDrupalCodeBase::DOMAIN`, plus a dev domain when `contribution_records.settings:allow_dev_sources`) and requires a `/project/<name>/-/issues/<iid>` path.

| Route | Path | Requirements | Does |
|---|---|---|---|
| `drupalorg.issue_fork_management` | `/drupalorg/issue-fork/management` | `_permission: access content` | Renders `drupalorg_issue_forks_management` theme with GitLab project/issue/MRs/forks (read-only, `max-age: 60`). |
| `drupalorg.issue_fork_check_access` | `/drupalorg/issue-fork/check-access` | `access content` + `_user_is_logged_in` | JSON: is current user a member of `fork_id`. |
| `drupalorg.issue_fork_request_access` | `/drupalorg/issue-fork/request-access` | `access content` + `_user_is_logged_in` | Queues `request_access` (add current user to `fork_id`) → `drupalorg_issue_forks_queue_worker`, then redirects. |
| `drupalorg.issue_fork_create_fork` | `/drupalorg/issue-fork/create-fork` | `access content` + `_user_is_logged_in` | Calls GitLab `projects()->fork()` (namespace `issue`, path/name `drupalorg-<iid>` unless `fork_name` given), then queues `post_fork_creation`. |

`getGitLabUserIdFromUserId()` (in the trait) maps the Drupal user to a GitLab user via `field_git_username`; requests fail cleanly if it is unset.

## Project Browser — `ProjectBrowserController` (`src/Controller/ProjectBrowserController.php`)

| Route | Path | Requirements |
|---|---|---|
| `drupalorg.project_browser_filters_uuids` | `/drupalorg-api/project-browser-filters` | `_access: 'TRUE'` |

`filtersUuids()` returns taxonomy-term UUIDs for the `development_status`/`maintenance_status` vocabularies bucketed into `active`/`maintained`/`not-active`/`not-maintained` (allow-lists in class consts), and, if `drupal_version` is supplied, a `supported`/`message` result from `checkVersion()` (uses `Composer\Semver\Semver::satisfies` against `Settings::get('drupalorg_project_browser_unsupported_drupal_versions')`; the explanation string is `Xss::filter`ed). Read-only public metadata.

## Admin forms

`drupalorg.gitlab_settings` → `/admin/config/development/drupalorg-gitlab` and `drupalorg.settings` → `/admin/config/development/drupalorg-settings`, both `_permission: administer site configuration` (menu links in `drupalorg.links.menu.yml`). See [../config/settings.md](../config/settings.md).
