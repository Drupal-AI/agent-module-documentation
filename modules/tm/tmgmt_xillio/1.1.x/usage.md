<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocHub TMGMT (via Xillio) is a TMGMT translator plugin that submits Drupal translation jobs to the Xillio LocHub platform over its Tapicc REST API.

---

Configured as a TMGMT translator (Translation providers UI), it authenticates with a username/password OAuth password grant, caches the bearer token in the expirable keyvalue store, and creates a LocHub job and per-item task for each TMGMT job. Job item content is exported to XLIFF via tmgmt_file and uploaded to LocHub; the connector (`src/TapiccConnector.php`) handles projects, jobs, tasks, inputs, webhooks and deliverable download over Guzzle with default TLS verification.

Completed translations return via a webhook. `TapiccConnector::createWebhook()` registers a `taskUpdated` webhook pointing at the module's own route `/tmgmt_xillio/notify/task-update`. The handler (`XillioController::notifyTaskUpdate`) reads only `task.status` and `task.id`, loads the matching `RemoteMapping`, and calls `XillioTranslator::addTranslation()`, which re-downloads the authoritative deliverable from the Tapicc API (`downloadDeliverables($task_id)`) and imports the XLIFF. Operators add a translator, enter service URL / credentials / project, and register the webhook.
---
- Install TMGMT and this module, then add a "LocHub" translator under Translation providers.
- Enter the LocHub service URL, username, password and project id on the translator.
- Verify connectivity via the translator's availability check (Tapicc `ping`).
- Submit a TMGMT job to LocHub, creating a remote job and per-item tasks.
- Export each job item to XLIFF and upload it to LocHub as source input.
- Register a `taskUpdated` webhook so completed translations flow back automatically.
- Receive completion notifications at `/tmgmt_xillio/notify/task-update`.
- Re-download authoritative deliverables from LocHub when a task completes.
- Import returned XLIFF back into the TMGMT job as translated data.
- Abort a submitted job, cancelling the corresponding LocHub tasks.
- Cache the OAuth bearer token in the keyvalue store to avoid re-auth per call.
- List available LocHub projects when configuring the translator.
- Check the status of a specific LocHub task via the connector.
- Manage LocHub webhooks (create, list, get, delete) from the connector.
- Map Drupal job items to remote job/task ids via TMGMT RemoteMapping.
- Handle zip deliverables by extracting and reading the XLIFF entries.
- Translate any TMGMT-supported content (nodes, config, etc.) through LocHub.
