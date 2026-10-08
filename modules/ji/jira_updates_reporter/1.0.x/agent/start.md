<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Jira Drupal Updates Reporter (jira_updates_reporter) — agent index
**Turns Drupal available-update data into Jira issues for security and release updates.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Depends on:** core Update module
- **Config route:** `jira_updates_reporter.settings` at `/jira-updates-reporter/config`
- **Permission:** `access Jira Drupal Updates Reporter configurations` (route also requires the `administrator` role)
- **Service:** `jira_updates_reporter_wrapper_service` (`JiraWrapperService::reportToJira()`), also invoked from `hook_cron` when enabled
- **External API:** Jira REST `/rest/api/2/issue` and `/rest/api/latest/search`, HTTP Basic auth via cURL (TLS verify at secure default)

**Security:** admin-only config route (role + permission gated); no anonymous or public endpoints. Outbound-only integration. Jira API token stored in config and shown in a plain textfield — config export is sensitive.

See [configure/settings.md](configure/settings.md)
