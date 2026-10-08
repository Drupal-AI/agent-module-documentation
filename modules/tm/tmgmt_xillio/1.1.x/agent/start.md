<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocHub TMGMT (via Xillio) (tmgmt_xillio) — agent index

**TMGMT translator plugin that submits jobs to the Xillio LocHub (Tapicc) REST API and imports deliverables back via a webhook.**

- **Version:** 1.1.x
- **Core:** ^9.3 || ^10
- **Depends on:** tmgmt, tmgmt_file, tmgmt_language_combination.
- **Configure:** `entity.tmgmt_translator.collection` (Translation providers UI); translator plugin id `xillio` (`XillioTranslator`).
- **Connector service:** `tmgmt_xilio.tapicc_connector` (`TapiccConnector`) — OAuth password grant, token cached in keyvalue; jobs/tasks/inputs/webhooks/deliverables over Guzzle (default TLS verification).
- **Callback route:** `tmgmt_xillio.notify_task_update` → `/tmgmt_xillio/notify/task-update`, **`_access: 'TRUE'`** (anonymous), `XillioController::notifyTaskUpdate`.

The notify callback reads only `task.status`/`task.id` from the body, loads the RemoteMapping, and `addTranslation()` re-downloads the deliverable from the Tapicc API (`downloadDeliverables()`).

See [configure/translator.md](configure/translator.md)
