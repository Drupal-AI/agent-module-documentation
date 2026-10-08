<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bridges Drupal's Update Status data to Jira by creating an issue for each module or core update that is available.

---

The module reads the core Update module's available-update data (`update_get_available`, `update_calculate_project_data`) and, for every project whose installed version differs from the recommended version, opens a Jira issue via the Jira REST API (`/rest/api/2/issue`). Security updates are prefixed `SECURITY` and get one issue type; ordinary release updates are prefixed `RELEASE` and get another; a "security only" toggle suppresses non-security tickets. Before creating a ticket it searches Jira (`/rest/api/latest/search`) for an existing issue with a matching summary so duplicates are not opened.

Configuration lives at `/jira-updates-reporter/config` (route `jira_updates_reporter.settings`), gated by the administrator role plus the `access Jira Drupal Updates Reporter configurations` permission. You supply the Jira base URL, username, API token, project key and the two issue-type names. The reporter can be triggered manually with the "Save and update" button or automatically on cron when "Check for updates on cron" is enabled. Authentication uses HTTP Basic (`CURLOPT_USERPWD`) over cURL with TLS verification left at its secure default; the Jira token is stored in module config and rendered in a plain textfield, so treat the config export as sensitive.

---
- Configure the Jira base URL, username and API token
- Set the target Jira project key
- Choose the issue type used for security updates
- Choose the issue type used for release updates
- Restrict ticket creation to security updates only
- Enable automatic checks on cron
- Trigger an immediate update-to-Jira run from the config form
- See the timestamp of the last check
- Automatically open a Jira ticket for an available module update
- Automatically open a Jira ticket for an available core update
- Prefix security update tickets with SECURITY
- Prefix release update tickets with RELEASE
- Avoid duplicate tickets by searching existing Jira issues first
- Include the project update link in the ticket description
- Feed Drupal update monitoring into an existing Jira workflow
- Give a security team visibility of pending Drupal updates
- Audit which updates have been reported via the dblog channel
