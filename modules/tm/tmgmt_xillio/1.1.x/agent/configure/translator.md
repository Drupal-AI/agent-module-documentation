<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the LocHub (Xillio) translator

## 1. Create the translator
Go to the Translation providers collection (`entity.tmgmt_translator.collection`) and add a translator using the **LocHub** plugin (`xillio`). Settings (`XillioTranslator::defaultSettings()`):

- `service_url` — base URL of the LocHub / Tapicc endpoint.
- `username`, `password` — credentials for the OAuth password grant (`grant_type=password`, `client_id=app`).
- `project` — LocHub project id (populated from `getProjects()`).
- `webhook_id` — set when a webhook is registered.

`checkAvailable()` calls Tapicc `ping` and marks the translator available on success.

## 2. Job flow
- `requestTranslation()` creates a remote job, then per job item: creates a task, exports the item to XLIFF (`tmgmt_file` xlf converter), uploads it as source input, sets task status `confirmed`, and stores a `RemoteMapping` (remote ids + `inputId`).
- `abortTranslation()` sets each mapped task to `cancelled`.

## 3. Return webhook
- `TapiccConnector::createWebhook()` registers an `eventType: taskUpdated` webhook whose `url` is `Url::fromRoute('tmgmt_xillio.notify_task_update')->setAbsolute()`.
- Incoming POST to `/tmgmt_xillio/notify/task-update` with `{"task":{"status":"completed","id":"<taskId>"}}` triggers `XillioController::notifyTaskUpdate`.
- The controller loads the RemoteMapping for that task id and, if the job item is active, calls `addTranslation()` which **re-downloads** the deliverable from LocHub and imports the XLIFF — the request body is never used as translation content.

## Operations notes
- The auth token is cached in keyvalue; credentials are entered on the translator config.
- Guzzle requests use default options (TLS verification enabled by default; not disabled anywhere in the connector).
