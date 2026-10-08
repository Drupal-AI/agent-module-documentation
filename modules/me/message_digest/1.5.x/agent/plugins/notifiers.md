# Message Digest — notifier & queue plugins

Message Digest does not define a new plugin type. It plugs into **Message Notify**'s notifier plugin manager and
adds a core **QueueWorker**.

## Digest notifier plugins (`@Notifier`)
- Base class `DigestBase` (abstract, extends `message_notify`'s `MessageNotifierBase`, implements
  `DigestInterface`). Concrete plugin `Digest` (`src/Plugin/Notifier/Digest.php`):
  ```php
  @Notifier(
    id = "message_digest",
    deriver = "\Drupal\message_digest\Plugin\Deriver\DigestDeriver",
    viewModes = { "mail_subject", "mail_body" }
  )
  ```
- `DigestDeriver` loads every `message_digest_interval` config entity and derives one notifier per interval, so
  the usable notifier ids are `message_digest:<interval_id>` (e.g. `message_digest:daily`,
  `message_digest:weekly`). The derivative definition carries `digest_interval` (the entity's `strtotime`
  string).
- `DigestBase::deliver()` intentionally does **not** send the email. It inserts a row into the `message_digest`
  DB table (`receiver`, `entity_type`, `entity_id`, notifier, timestamp) and returns TRUE, so the message is
  captured for later digesting instead of immediate delivery.

### Using / adding
- To digest a notification, send it with a digest notifier id instead of an immediate one:
  ```php
  \Drupal::service('message_notify.sender')->send($message, [], 'message_digest:daily');
  // or the legacy helper message_notify_send_message($message, [], 'message_digest:weekly');
  ```
- To add a new interval notifier, create a `message_digest_interval` config entity (see configure/intervals.md)
  — no code needed. To customise digest behaviour beyond interval, subclass `DigestBase` and override
  `getInterval()` (per README).

## Queue worker
- `@QueueWorker(id = "message_digest", cron = {"time" = 60})` → `Plugin/QueueWorker/MessageDigest`.
- `processItem($data)` calls `DigestManager::processSingleUserDigest($data['uid'], $data['notifier_id'],
  $data['end_time'])` — items are enqueued by `DigestManager::processDigests()` during cron.
