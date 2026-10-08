<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GitLab integration

The module drives a GitLab instance through the `m4tthumphrey/php-gitlab-api` client (`\Gitlab\Client`). `hook_requirements()` (`drupalorg.install`) hard-errors if that library is missing, and warns if `host`/`token` are unset.

## Building the client — `GitLabClientTrait` (`src/Traits/GitLabClientTrait.php`)

`getGitLabClient(): \Gitlab\Client` reads config `drupalorg.gitlab_settings`:

- Throws `\Exception('GitLab host or token not set.')` if `host` or `token` is empty or `token === 'CHANGE-ME'`.
- `new Client()` → `setUrl($config->get('host'))` → `authenticate($config->get('token'), Client::AUTH_HTTP_TOKEN)`.
- The base URL comes only from config (not from request input); TLS verification is the client/Guzzle default (not disabled).

Other trait methods:
- `getGitLabUserIdFromUserId(int $user_id)` — resolves a Drupal user's `field_git_username` to a GitLab user id via `users()->all(['username' => …])`, requiring an exact single match; result cached under `gitlab_user_id_for_drupal_user_<uid>`. Returns `NULL` when no git username is set.
- `getGitLabUrl(): string` — returns the configured `host`.

`GitLabClientHelper` (`src/Utilities/GitLabClientHelper.php`) is a thin `final` class that `use`s the trait and exposes `client()`, so procedural code (e.g. `.module`) can obtain a client without being in a class context. Do not add logic there — put it in the trait.

## Token rotation — `GitLabTokenRenew` (`src/Utilities/GitLabTokenRenew.php`)

- `renewToken($days_before_expiry = 2)` — only if `renew_token_on_cron` is TRUE: reads `personal_access_tokens()->current()`, and if it expires within `$days_before_expiry` (min 1) days, calls `personal_access_tokens()->rotate($id)` and saves the new token back into `drupalorg.gitlab_settings:token`.
- `daysToExpiry()` — days until the current token expires (negative if already expired).
- `hook_cron()` (`drupalorg.module`) calls `renewToken()` every cron and logs an error when the token is within 2 days of (or past) expiry.

## Where the client is used

- `IssueForksController` — fork listing/creation, membership check, issue/MR display.
- `DrupalOrgIssueForksQueueWorker` — add members to forks, create issue branches.
- `DrupalOrgSecurityIssueWebhookQueueWorker` — fork projects into the `security` namespace, add/remove members, move/lock issues, post notes, set labels.
- `DrupalOrgProjectActivityWebhookQueueWorker` — fetch project + `avatar_url` for logo updates.
- `DrupalOrgContributionActivityWebhookQueueWorker` — post automated issue/MR notes.
- `DrushCommands` — `drupalorg:check-gitlab-system-hooks`, `drupalorg:fetch-gitlab-avatars`, `drupalorg:security-populate-milestones` (see [../config/settings.md](../config/settings.md)).
- `_drupalorg_parse_security_issue_url()` + `drupalorg_node_access()` — validate a security-advisory `sa` node create request against a real GitLab issue.
