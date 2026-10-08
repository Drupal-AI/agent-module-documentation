# Message Digest — services & cron flow

Services (`message_digest.services.yml`):
- `message_digest.manager` → `DigestManager` (database, `plugin.message_notify.notifier.manager`,
  entity_type.manager, module_handler, `message_digest.formatter`, `plugin.manager.mail`, queue).
- `message_digest.formatter` → `DigestFormatter` (entity_type.manager, renderer).

## `DigestManagerInterface` (service `message_digest.manager`)
- `processDigests()` — finds users with pending `message_digest` rows whose interval has elapsed and enqueues a
  per-user item `{uid, notifier_id, end_time}` onto the `message_digest` queue.
- `processSingleUserDigest($account_id, $notifier_id, $end_time)` — aggregates that user's pending messages up to
  `end_time`, renders them (via `DigestFormatter` + the notifier's view modes), and sends one email through
  `hook_mail('digest')`; marks rows sent / updates last-sent State.
- `getNotifiers()` — returns the available Digest notifier plugin instances.
- `cleanupOldMessages()` — deprecated (8.1.2); cleanup now happens on message/user delete.

## Cron entry point
`message_digest_cron()` (in `.module`):
```php
$dm = \Drupal::service('message_digest.manager');
$dm->processDigests();        // enqueue per-user digest work
$dm->cleanupOldMessages();    // deprecated no-op path
```
The queue worker then runs `processSingleUserDigest()` per item on the same/next cron.

## Mail + rendering
- `hook_mail('digest')` sets the subject to `@title message digest` (site name, or the grouping entity's label
  when `entity_type`/`entity_id` are set) and appends the pre-rendered body; if the grouping entity no longer
  exists it sets `send = FALSE`.
- Theme hooks `message_digest` and `message_digest_rows` (+ their `template_preprocess_*`) assemble the message
  rows into the digest body.

## Bookkeeping / cleanup
- Storage: the `message_digest` table (mid, receiver, entity_type, entity_id, notifier, timestamp, sent).
- `hook_entity_predelete()` deletes rows for a deleted `message` (by `mid`) or `user` (by `receiver`).
