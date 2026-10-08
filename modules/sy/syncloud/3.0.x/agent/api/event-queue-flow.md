<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event → queue → MQTT publish flow

Three sources create a `syn` record and enqueue a job; a queue processor rebuilds each event as a
JSON message and publishes it over MQTT. All source files are under `src/`.

## 1. Event capture (creates a `syn`, enqueues a job)

Each source builds the same `syn_array` (name `"<ip>--<type>"`, `ip`, `host`, `scheme`, `type`,
`message` = source entity id, `mode` from the `synhelper` cookie, `url` = absolute alias), saves a
`syn` entity, then calls `Queue::queuePush(<source id>, <syn id>)` and `Queue::guzzlePushQueue()`:

- **Commerce order placed** — `EventSubscriber\OrderCompleteSubscriber` (service
  `syncloud.order_complete`) on the `commerce_order.place.post_transition` state-machine event
  (`type = 'commerce_order'`).
- **Webform submission** — `Hook\WebformSubmissionInsert` (`hook_ENTITY_TYPE_insert`) and
  `Hook\WebformSubmissionPresave` (`hook_ENTITY_TYPE_presave`), each gated on
  `$entity->isCompleted()` (presave also requires an existing id).
- **Contact message** — `Hook\ContactMessageInsert` (`hook_contact_message_insert`), gated on
  `method_exists($entity, 'getContactForm')`.

## 2. Queue enqueue (`Service\Queue`)

- `queuePush($id, $synId)` — returns early if either id is null; otherwise
  `queueFactory->get('syncloud_queue')->createItem(['id' => $id, 'syn_id' => $synId])`.
- `guzzlePushQueue()` — fires a 1-second Guzzle GET to `<host>/syncloud/queue` (a self-request to
  kick off draining) and returns the status code or an exception string.

## 3. Queue drain (`Queue::queueProcess`, reachable via `SyncloudQueueController::page`)

Route `syncloud.queue` `/syncloud/queue` (`_access: 'TRUE'`, `no_cache: 'TRUE'`) →
`Controller\SyncloudQueueController::page()`, which does `sleep(5)` then `queueProcess()`.
`queueProcess()` claims items for up to 30 s; for each it validates the `{id, syn_id}` shape, loads
the `syn` entity and then the source entity of `syn.type`, and — **only when
`syncloud.settings.telegram-int` is truthy** — calls `publishEntityEvent()`. Items are always
deleted after handling (invalid/unloadable ones are dropped).

`publishEntityEvent()` seeds a message from `syn` fields (`ip`, `type`, `host`, `mode`,
`matomo`=`syn_id`, `url`, plus `yandex`/`google` from `extra`), then dispatches by source type:
- `commerce_order` → `addOrderData()`: billing-profile `field_customer_*` values, order items
  (title/price/quantity/adjusted price), order number, shipment shipping-method, payment gateway,
  total price. Invokes `hook_syncloud_queue_preprocess_commerce`.
- `webform_submission` → `addWebformData()`: sets `type='webform_submission'`, maps each decoded
  element value (radios/checkbox handled), plus webform id + title. Invokes
  `hook_syncloud_queue_preprocess_webform`.
- otherwise → `addContactData()`: emits contact-message fields except a fixed skip list
  (uuid, langcode, message, copy, recipient, created, uid, metatag, ip_address, contact_form, id);
  entity-reference fields become absolute URLs, file fields become absolute file URLs. Invokes
  `hook_syncloud_queue_preprocess_contactform`.

The assembled array is JSON-encoded and published via
`syncloud.mqtt->run()->publish("$telega/syncloud/<uuid>/event/contact-message", $json)`, where
`<uuid>` is the `syncloud.uuid` state value.

## 4. MQTT transport (`Service\MqttService`)

`run()` connects with `politsin/phpmqtt` (`Bluerhinos\phpMQTT`) using the `syncloud.settings`
server/port/login/password (see [config/settings.md](../config/settings.md) for exact sourcing),
sets an error message on failure, and `publish()` sends the payload then closes. `cronTask()` and
`getMessage()`/`subscribe()` are additional helpers; `subscribe`'s callback `procMsg` just prints
the received message as an error message.

## Alter hooks (extension points)

- `hook_syncloud_queue_preprocess_commerce($order, $synId)`
- `hook_syncloud_queue_preprocess_webform($submission, $synId)`
- `hook_syncloud_queue_preprocess_contactform($message, $synId)`

## Operational note (3.0.6 defect)

`Queue::__construct()` argument 2 is type-hinted `Drupal\Core\Queue\QueueFactoryInterface`, but the
`@queue` service Drupal 11 injects is `Drupal\Core\Queue\QueueFactory`, which does not satisfy that
hint → a `TypeError` is thrown whenever the `syncloud.queue` service is instantiated. Consequently
`/syncloud/queue` returns HTTP 500 and every enqueue call (`\Drupal::service('syncloud.queue')`
inside the hooks/subscriber) also fails on current core. The fix is to type-hint `QueueFactory`
(or otherwise align the argument). The `MqttService` weekly-usage cron publish is independent of
this service and still runs.
