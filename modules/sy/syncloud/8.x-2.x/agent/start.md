<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# syncloud (syncloud) — agent index

**Queues site events (Commerce orders, webform & contact submissions) and publishes them over MQTT to an external Telegram/biz-panel bridge.**

- **Version:** 8.x-2.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** contact
- **Configure:** `entity.syn.settings` → `admin/structure/syn` (perm `administer syn`)
- **Entity:** `syn` (`src/Entity/Syn.php`, access handler, list/view builders, forms)
- **Services:** `syncloud.mqtt` (MqttService), `syncloud.queue` (Queue), `syncloud.order_complete` (event subscriber)
- **Queue:** `syncloud_queue`, drained by `Queue::queueProcess()` → MQTT publish
- **Permissions:** administer syn, access syn overview, create/view/edit/delete syn

**Security:** Route `syncloud.queue` `/syncloud/queue` uses **`_access: 'TRUE'`** (anonymous). Controller `SyncloudQueueController::page()` (src/Controller/SyncloudQueueController.php:16-19) does `sleep(5)` then `queueProcess()` (up to 30s) — no request input read, no data returned; it is an unauthenticated queue-drain/DoS-amplification trigger, not a data-exposure or push endpoint. Admin config route is permission-gated. MQTT creds stored in `syncloud.settings`; `MqttService::run()` uses `rand()` for client id (non-security).

See [configure/settings.md](configure/settings.md)
