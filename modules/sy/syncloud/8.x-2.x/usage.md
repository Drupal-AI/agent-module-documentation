<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
syncloud captures site events — completed Commerce orders, webform submissions and contact-form messages — and pushes structured payloads over MQTT to an external "biz-panel"/Telegram bridge.
---
The module defines a `syn` content entity (bundle-like config linking a site "type" such as `commerce_order`, `webform_submission` or `contact_message` to a remote id and MQTT routing metadata). Hooks (`ContactMessageInsert`, `WebformSubmissionInsert/Presave`, an OrderComplete event subscriber and `Cron`) enqueue the affected entity id into the `syncloud_queue`. The queue is drained by `Queue::queueProcess()`, which loads the entity, builds a message array (order line items, billing profile fields, webform values, contact fields), and publishes it as JSON to MQTT topic `$telega/syncloud/<uuid>/event/contact-message` via `MqttService`. MQTT server/port/login/password come from `syncloud.settings`.

Security notes to be aware of when operating this module: the route `/syncloud/queue` (`syncloud.queue`) is declared with **`_access: 'TRUE'`**, i.e. reachable by anonymous users; its controller `SyncloudQueueController::page()` calls `sleep(5)` and then processes the queue for up to 30 seconds. It does not read request input or return queue data (it returns an empty render array), so it is a queue-drain trigger rather than a data-exposure or sync-push endpoint — but any anonymous client can invoke it to force processing and hold a worker for ~5–35s per request, an availability/DoS concern; front it with access control or a cron-only trigger. MQTT credentials are stored in config and the client uses `rand()` for its client id. Admin settings live at `admin/structure/syn` (permission `administer syn`).
---
- Configure the MQTT server, port, login and password at admin/structure/syn.
- Enable the Telegram integration toggle (`telegram-int`) in settings.
- Create a `syn` entity mapping a Commerce order type to a remote id.
- Push completed Commerce orders to an external panel/Telegram.
- Forward webform submissions to MQTT as structured JSON.
- Forward contact-form messages to the remote bridge.
- Include order line items, prices and quantities in the payload.
- Include billing-profile customer fields in order messages.
- Send shipping method and payment gateway details with orders.
- Store the site's syncloud UUID in state for topic routing.
- Trigger queue processing on cron.
- Manually enqueue an entity for syncing via the queue service.
- Alter outgoing order payloads with `hook_syncloud_queue_preprocess_commerce`.
- Alter webform payloads with `hook_syncloud_queue_preprocess_webform`.
- Alter contact payloads with `hook_syncloud_queue_preprocess_contactform`.
- Grant `administer syn` to a back-office role only.
- Restrict or firewall the anonymous `/syncloud/queue` trigger route.
- Review the syn overview/list of configured mappings.
- Publish a periodic cron heartbeat to the MQTT broker.
- Map multiple Matomo/Yandex/Google tracking ids per syn entity.
