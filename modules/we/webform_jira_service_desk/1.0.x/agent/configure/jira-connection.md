<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Jira Service Desk — connection + per-webform mapping

## 1. Store credentials in a Key (Key module)
Create a **User/Password** key holding your Jira username and API token as JSON, e.g. `{"username":"JIRA_USERNAME","password":"JIRA_API_TOKEN"}`. Prefer an env-backed key provider so the token is never committed.

## 2. Global connection — `/admin/config/services/jira`
- **Jira host** — base URL of the Jira instance (used as Guzzle `base_uri`; requests hit `rest/servicedeskapi/*` and `rest/api/2/*`).
- **User/Password key** — select the Key from step 1. On save the form validates the key is a UserPasswordKeyType and test-connects to `rest/api/2/myself`.
- **Retry codes** — one 3-digit HTTP code per line; the queue worker re-queues a failed send whose response code matches.
- **Debug requests** — logs the full request payload. The form warns: do not enable where submissions carry personal data / logs are insecure.

TLS: the client is built with `ClientFactory::fromOptions(['base_uri'=>host,'auth'=>[user,pass]])` — Guzzle verifies certificates by default (no `verify=>false`).

## 3. Per-webform mapping — `/admin/structure/webform/manage/{webform}/jira`
Requires webform *update* access **and** the `edit webform jira` permission. Choose the **service desk** and **request type** (fetched live from Jira), then add field mappings (`add-field`): each maps a Jira field id to a webform element (`webform_element`) or a static token `text` value, with a Jira field type (`string`, `option`, `option_multiple`, `array`, `number`, `any`, `date`, `datetime`). Optionally enable duplicate detection (JQL on chosen fields) and save-issue-key back to a webform element.

## 4. Delivery
Submissions are enqueued and sent on cron by the `cron_jira_request_queue` worker (60s/run). Watch results at `/admin/config/services/jira/queue-health`. A 201 response logs the created issue key; retry-code responses re-queue.
