<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Jira Service Desk Integration (webform_jira_service_desk) — agent index

**Maps Webform submissions to Jira Service Desk requests and sends them through a cron queue.**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^10.4 || ^11.1
- **Requires:** key, webform
- **Routes:** `/admin/config/services/jira` (+ `/queue-health`) — `_permission: administer site configuration`; `/admin/structure/webform/manage/{webform}/jira[...]` — `_custom_access: WebformJiraAccess::checkWebformJiraAccess` (webform update AND-if `edit webform jira`)
- **Permission:** `edit webform jira`
- **Config:** `webform_jira_service_desk.service_configuration` (host, `user_password_key`, retry_codes, debug_requests)
- **Services:** `webform_jira_service_desk.jira_service` (JiraServiceDeskService), `...queue_health_service`
- **Queue worker:** `cron_jira_request_queue` (SendJiraRequest) — duplicate check, save issue key, requeue on retry codes
- See [configure/jira-connection.md](configure/jira-connection.md)

**Security:** credentials in a **Key** entity (UserPasswordKeyType), not config. Guzzle client uses **default TLS verification — no `verify => false`** (`JiraServiceDeskService.php:410`, `JiraServiceDeskConfigurationForm.php:154`); Jira host is admin-configured. Admin routes gated by `administer site configuration`; mapping gated by webform-update + `edit webform jira`. `debug_requests` logs full payloads (UI warns re PII). No anonymous/unverified endpoints. No security findings.
