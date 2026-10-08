# The `message_subscribe.subscribers` service

`Drupal\message_subscribe\Subscribers` (interface `SubscribersInterface`), service id
`message_subscribe.subscribers`. This is the whole public API. Get it with
`\Drupal::service('message_subscribe.subscribers')`.

## `sendMessage($entity, $message, $notify_options = [], $subscribe_options = [], $context = [])`

The main entry point. `$entity` is the thing acted on (node, comment, user, term); `$message` is a
saved-or-unsaved `Drupal\message\MessageInterface`. Flow:

1. Saves the message if unsaved (unless `save message => FALSE`).
2. If `use_queue` (config or `$subscribe_options['use queue']`) and not already inside the queue
   worker, it computes context once and **enqueues** a task on the `message_subscribe` queue, then
   returns. (Throws `MessageSubscribeException` if the message has no id.)
3. Otherwise gathers recipients (`getSubscribers()` unless you passed an explicit `uids` list),
   and for **each** recipient clones the message, sets its owner to that uid, invokes
   `hook_message_subscribe_message_alter()`, and sends via each of the recipient's notifiers using
   `message_notify.sender`.
4. When queued and a `range` batch didn't reach the last uid, it re-enqueues a follow-up task with
   `last uid` so cron continues where it left off.

Key `$subscribe_options` (see `SubscribersInterface::sendMessage` docblock): `save message`,
`skip context`, `last uid`, `uids` (bypass subscriber lookup — deliver to a hand-picked list of
`DeliveryCandidate`s), `range`, `end time`, `use queue`, `queue`, `entity access` (default TRUE —
respect view access), `notify blocked users` (default FALSE), `notify message owner`.
`$notify_options` is passed through to `MessageNotifier::send()` per notifier.

## `getSubscribers($entity, $message, $options = [], &$context = [])`

Returns `DeliveryCandidateInterface[]` keyed by uid. It:
- builds `$context` via `getBasicContext()` if empty,
- invokes **all** `hook_message_subscribe_get_subscribers()` implementations and merges results
  (the base module's own implementation queries the `flagging` table for users flagged on any
  entity in the context using the `subscribe_*` flags),
- drops blocked users (unless `notify blocked users`), the entity owner (unless
  `notify_own_actions`), and users without entity view access (unless `entity access` is FALSE),
- adds `default_notifiers` to every candidate, then runs `hook_message_subscribe_get_subscribers_alter()`.

## `getBasicContext($entity, $skip_detailed_context = FALSE, $context = [])`

Builds the context array `['<entity_type>' => [ids...]]`. Beyond the entity itself it adds the
node author (`user`) and referenced **taxonomy terms** of any node in context; for a `CommentInterface`
it adds the commented node and the comment author. Returns just the entity id/type when
`$skip_detailed_context` is TRUE.

## `getFlags($entity_type = NULL, $bundle = NULL, $account = NULL)`

Returns `FlagInterface[]` for flags whose id starts with `flag_prefix . '_'`, optionally filtered by
flaggable entity type/bundle and (if `$account` given) by that account's flag/unflag action access.
Note: without an account it returns matching flags **regardless of enabled status**.

## `DeliveryCandidate` value object

`Drupal\message_subscribe\Subscribers\DeliveryCandidate` carries one recipient's state:

```php
use Drupal\message_subscribe\Subscribers\DeliveryCandidate;
// (array $flags, array $notifiers, int|string $uid)
$candidate = new DeliveryCandidate(['subscribe_node'], ['email'], 7);
$candidate->addNotifier('sms')->addFlag('subscribe_term');
$candidate->getNotifiers();  // ['email' => 'email', 'sms' => 'sms']
$candidate->getAccountId();  // 7
```

Methods (from `DeliveryCandidateInterface`): `getFlags/setFlags/addFlag/removeFlag`,
`getNotifiers/setNotifiers/addNotifier/removeNotifier`, `getAccountId/setAccountId`. Flags and
notifiers are stored keyed by their own value (deduped).

## Queue worker

Plugin id `message_subscribe` (`Plugin\QueueWorker\MessageSubscribe`, `cron = {"time" = 60}`).
`processItem()` reloads the message and entity, sets `subscribe_options['queue'] = TRUE`, and calls
`sendMessage()` again to deliver that batch. Runs on cron; the item payload is
`['message','entity','notify_options','subscribe_options','context']`.
