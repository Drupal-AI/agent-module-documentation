<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How emails get sent (subscriber, sender, queue)

## Dispatch flow

1. **`EmailSubscriber`** subscribes to `KernelEvents::REQUEST` (priority 900). On `onRequest()`
   it loops every `commerce_email_event` plugin definition and registers itself as a listener
   for each distinct `event_name` (at that plugin's `priority`). This lazily wires listeners for
   only the events that some plugin cares about.
2. When a Commerce event fires (e.g. `commerce_order.place.post_transition`), `onEvent()` loads
   **all enabled** `commerce_email` entities, keeps those whose event's `event_name` matches, and
   for each calls `$email->applies($entity)` (evaluates the inline conditions).
3. Matching emails go to `sendEmail()`.

## Immediate vs queued

`sendEmail()` checks `$email->shouldQueue()` (the `queue` config flag):

- **Queue on:** builds a job payload `{email_id, entity_id, entity_type_id, related_entities}`.
  - If `advancedqueue` is enabled → an Advanced Queue `Job` is enqueued on the `commerce_email`
    queue (config `advancedqueue.advancedqueue_queue.commerce_email`, processor `cron`).
  - Otherwise → a core Queue item on `commerce_email_queue` (worker `EmailQueue`), processed on cron.
- **Queue off:** `commerce_email.email_sender` (`EmailSender::send()`) sends immediately.

## `EmailSender::send(EmailInterface $email, ContentEntityInterface $entity, array $related = [])`

Service id **`commerce_email.email_sender`**. It:
- Builds token replacements from the entity (+ related entities), replaces tokens in
  `from/to/cc/bcc/replyTo/subject/body`.
- Resolves recipients: `toType=email` → the `to` string; `toType=role` → every user with `toRole`.
- Renders the body through the `commerce-email.html.twig` wrapper and hands off to
  `commerce.mail_handler->sendMail()`.
- If `logToEntity` is set and Commerce Log is available, writes a log entry on the entity.

## Programmatic use

```php
$email = \Drupal\commerce_email\Entity\Email::load('order_confirmation');
$order = \Drupal\commerce_order\Entity\Order::load(1);
\Drupal::service('commerce_email.email_sender')->send($email, $order);
```

Normally you don't call this — you just create the `commerce_email` entity and let the
subscriber fire it. Use direct `send()` for resends/tests (the Test email form does this).

## Extending

- `hook_commerce_email_event_info_alter(&$definitions)` — change a shipped plugin's `priority`
  (or other definition values).
- Add a `@CommerceEmailEvent` plugin to react to your own Symfony events — see
  [plugins/email-events.md](../plugins/email-events.md).
