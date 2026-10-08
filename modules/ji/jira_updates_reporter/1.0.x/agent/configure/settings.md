<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring jira_updates_reporter

Route `jira_updates_reporter.settings` → `/jira-updates-reporter/config` (requires the `administrator` role and the `access Jira Drupal Updates Reporter configurations` permission). Config object: `jira_updates_reporter.config`.

Fields:
- `jira_url` — Jira base URL, e.g. `https://domain.atlassian.net`.
- `jira_username` / `jira_token` — HTTP Basic credentials (token is the Jira API token).
- `project_key` — target Jira project key.
- `issuetype_name_release` / `issuetype_name_security` — Jira issue-type names used for the two ticket classes.
- `security_only` — when checked, only status==1 (security) updates create tickets.
- `check_on_cron` — when checked, `jira_updates_reporter_cron()` runs `reportToJira()` each cron.
- `last_check` — read-only timestamp of the last run.

Operation: `reportToJira()` refreshes update data, then for each project where `info.version != recommended` posts a new issue unless a same-summary issue already exists. Use "Save and update" to run on demand.
