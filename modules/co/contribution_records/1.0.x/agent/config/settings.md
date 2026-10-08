<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & install

## Enable

`drush en contribution_records`. Requires `paragraphs`, `node`, `drupalorg`, and the
`m4tthumphrey/php-gitlab-api` + `marufmax/emoticon-php` libraries (pulled via Composer through
`drupal/drupalorg` and this module's `composer.json`). The module carries **no `config/install`
and no `config/schema`** — it relies on the `contribution_record` content type, `contributor`
paragraph type, `field_*` fields, and the `contribution_records` / `contribution_records_metrics`
views being present in the site config already (the www.drupal.org site).

## `hook_requirements` (`contribution_records.install`)

`contribution_records_requirements()` errors at install/runtime if:
- The `\Gitlab\Client` class is missing (`m4tthumphrey/php-gitlab-api` not installed).
- At runtime, `drupalorg.gitlab_settings` has an empty `host` or `token` — GitLab sources cannot
  be fetched until both are set (in settings or via the drupalorg config form).

## Settings form — `SettingsForm`

- Route `contribution_records.settings` → `/admin/config/contribution-records/settings`,
  permission **`administer site configuration`**, menu link under *Configuration → Development*
  (`contribution_records.links.menu.yml`). `info.yml` `configure:` points here.
- `ConfigFormBase`, editable config **`contribution_records.settings`**, form id
  `contribution_records_settings`. One field:
  - **`allow_dev_sources`** (checkbox) — when TRUE, `SourceLink::detectSource()` also accepts the
    non-production dev domains (`DevDrupalOrgIssue`, `DevGitDrupalCodeIssue`,
    `DevGitDrupalCodeMergeRequest`). Default off; only production `www.drupal.org` and
    `git.drupalcode.org` are accepted otherwise.

## Config consumed from other modules

- **`drupalorg.settings` → `credit_migration_token`** — the shared secret compared (strict `===`)
  against the `Drupalorg-Credit-Migration-Token` request header on the import endpoint
  (`ContributionRecordController::checkSourceOfRequest()`).
- **`drupalorg.gitlab_settings` → `host`, `token`** — GitLab connection used by the GitLab source
  classes (via the `drupalorg` `GitLabClientTrait`).

## `settings.php` keys (via `Settings::get()`)

- **`$settings['contribution_records_hide_users']`** — array of user IDs (e.g. bot accounts like
  "System Message", "Auto Update Bot"). Their `contributor` paragraphs are hidden in
  `hook_preprocess_paragraph` and the Quick Credits table, and preserved (not dropped) when
  re-ordering contributors in `SourceLink::sortContributors()`.

## Operate

- Import queue: `drush queue:run contribution_records_import_queue_worker`.
- Purge imported records (dev): `drush entity:delete node --bundle=contribution_record`.
