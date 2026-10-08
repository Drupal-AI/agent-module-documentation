<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Queue workers

All in `src/Plugin/QueueWorker/`. Items are created by the webhook/issue-fork controllers and processed on cron (or `drush queue:run <id>`). Each worker uses `GitLabClientTrait`. They are queue-worker plugin *instances* — the module defines no new plugin type.

## `drupalorg_project_activity_webhook_queue_worker` — `DrupalOrgProjectActivityWebhookQueueWorker`

`validateItem()` requires `event_name == 'repository_update'` + `project_id`. `processRepositoryUpdate()` fetches the GitLab project, maps `path_with_namespace` → Drupal project (`ProjectService::getProjectByRepositoryPath()`), and calls `updateLogo()` with the GitLab `avatar_url`.

## `drupalorg_contribution_activity_webhook_queue_worker` — `DrupalOrgContributionActivityWebhookQueueWorker`

Returns early unless `contribution_records` is enabled. Branches on `event_name`:
- `issue_update` / `merge_request_update` → `processContributionUpdate()`: resolves a `contribution_records\SourceLink` from the URL; on `open`/`close`/`merge`/`reopen`/`update` it syncs the contribution record/contributors and posts an automated note (built via `hook_gitlab_contribution_automated_comment_alter`).
- `drupalorg_issue_update` → `processDrupalOrgIssueUpdate()`: creates or syncs the contribution record.
- `comment_update` / `drupalorg_comment_update` → `processCommentUpdate()`: syncs on each comment; recognizes `/do:` command comments (currently stubbed/`@todo`).

`addNote()` posts to `issues()` or `mergeRequests()` depending on the source type.

## `drupalorg_security_issue_webhook_queue_worker` — `DrupalOrgSecurityIssueWebhookQueueWorker`

The security-team automation. `processItem()` loads the GitLab project and routes by state:
- If project is `drupal-security/issues` → **`copyToProject()`**: parses a `machine_name:` prefix from the issue title, finds the Drupal project, forks its repo into the `security` namespace as `<iid>-<machine>-security` (private, forking disabled, most features off), adds the reporter + project members at access level 30, moves the issue into the private fork, locks/closes the original with a pointer note, and rewrites the moved issue description with supported-branch info + a `Security status::unvalidated` label.
- `object_kind == 'issue'` → **`processIssue()`**: when the `Security advisory::needed` label is newly added, posts a "draft an advisory" link to `/node/add/sa` bound to the project + issue URL.
- `object_kind == 'note'` and `action == 'create'` → **`processNote()`**: only acts if the note author is a member of the GitLab `security` group; parses `/access <names>` and `/remove-access <names>` commands and adds/removes project members accordingly, then replies in the discussion.

## `drupalorg_issue_forks_queue_worker` — `DrupalOrgIssueForksQueueWorker`

`validateItem()` requires `action`, `fork_id`, `issue_id`, `user_id`. 
- `request_access` → adds the current user (`getGitLabUserIdFromUserId()`) to `fork_id` at access level 30 (50 for GitLab user id 1).
- `post_fork_creation` → creates branch `issue-<issue_id>-branch` from the fork's default branch and adds the creating user as a member.
