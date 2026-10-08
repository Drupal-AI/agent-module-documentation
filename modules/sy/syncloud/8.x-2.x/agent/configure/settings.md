<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring syncloud (MQTT / event push)

## Settings form — `admin/structure/syn` (perm `administer syn`)
`SynSettingsForm` writes `syncloud.settings`:
- `server`, `port`, `login`, `password` — MQTT broker connection (`MqttService::getMqttSettings()`).
- `telegram-int` — master toggle; when off, `Queue::queueProcess()` skips publishing.

State: `syncloud.uuid` is used in the MQTT topic `$telega/syncloud/<uuid>/event/contact-message`.

## syn entities
A `syn` entity maps a local entity type/bundle (`type`, e.g. `commerce_order`, `webform_submission`, contact) to remote routing fields (`syn_id`, `ip`, `host`, `mode`, `url`, `extra` with yandex/google). Manage via the syn list/add/edit forms.

## Event flow
1. Insert/complete hooks (`Hook/ContactMessageInsert`, `Hook/WebformSubmissionInsert`, `EventSubscriber/OrderCompleteSubscriber`) call `Queue::queuePush($id, $syn_id)`.
2. `Queue::queueProcess()` claims items for up to 30s, builds the message, and calls `syncloud.mqtt`→`publish()`.
3. Cron (`Hook/Cron`) can trigger processing; `Queue::guzzlePushQueue()` GETs `/syncloud/queue` internally.

## Alter hooks
- `hook_syncloud_queue_preprocess_commerce(&$entity, $syn_id)`
- `hook_syncloud_queue_preprocess_webform(&$entity, $syn_id)`
- `hook_syncloud_queue_preprocess_contactform(&$entity, $syn_id)`

## Operational security
`/syncloud/queue` is anonymous (`_access: 'TRUE'`) and expensive (`sleep(5)` + 30s drain). Restrict it at the web/proxy layer or replace the internal Guzzle self-call with a cron-only trigger to avoid unauthenticated queue-drain/DoS.
