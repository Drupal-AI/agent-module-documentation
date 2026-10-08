<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Turns Webform submissions into Jira Service Desk requests, mapping form values to Jira request fields and sending them asynchronously through a cron queue.

---

Global connection settings live at `/admin/config/services/jira`: a Jira host URL, a **Key** entity of type *User/Password* (username + API token, stored via the Key module, never in plain config), retry HTTP codes and a debug toggle. Per webform, an admin maps form elements/tokens to Jira request-type fields at `/admin/structure/webform/manage/{webform}/jira` and picks a service desk + request type. `JiraServiceDeskService` builds a Guzzle client from the Key credentials and posts to the Jira REST API; submissions are enqueued and processed by the `cron_jira_request_queue` QueueWorker, which optionally checks for duplicate issues first, saves the returned issue key back onto the submission, and re-queues on configured retry codes. A queue-health form surfaces send results.

Security posture: **credentials are stored in a Key entity** (UserPasswordKeyType), not in module config, and the config form validates the key type and test-connects. The **HTTP client uses Guzzle defaults, so TLS certificate verification is on** — there is no `verify => false` (`src/JiraServiceDeskService.php:410`, `src/Form/JiraServiceDeskConfigurationForm.php:154`). The Jira host is admin-configured only. Admin routes are gated by `administer site configuration`; per-webform mapping is gated by webform *update* access + the `edit webform jira` permission. Note the optional *Debug requests* toggle logs the full request payload — the form itself warns not to enable it where submissions contain personal data.

---
- Create a Jira Service Desk ticket from each webform submission.
- Store Jira credentials securely in a Key entity (username + API token).
- Connect to a Jira host over TLS with Basic auth.
- Map webform elements to Jira request-type fields per form.
- Map static text/token values to Jira fields.
- Pick the Jira service desk and request type per webform.
- Send requests asynchronously via the cron queue.
- Retry failed sends on configured HTTP status codes.
- Detect duplicate tickets before creating a new one (JQL search).
- Save the created Jira issue key back onto the submission.
- Monitor delivery via the Jira Queue Health form.
- Convert webform field types to Jira field types (string/option/array/number/date/datetime).
- Test the Jira connection when saving configuration.
- Restrict per-webform mapping via the `edit webform jira` permission.
- Enable request-payload debug logging (with a PII warning).
- Format datetimes for Jira with the shipped `jira_datetime` date format.
- Integrate a public support form with an internal Jira helpdesk.
