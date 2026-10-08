# Message Subscribe hooks

Three hooks (see `message_subscribe.api.php`) let you add recipients, filter them, and personalize
each message. All are invoked from `Subscribers`.

## `hook_message_subscribe_get_subscribers($message, $subscribe_options, $context)`

Return additional recipients: an array **keyed by uid** of `DeliveryCandidateInterface` objects.
Called for every module during `getSubscribers()`; results are merged (`$uids += $result`). The base
module's own implementation (`message_subscribe_message_subscribe_get_subscribers()`) queries the
`flagging` table for all users flagged on any entity in `$context` with a `subscribe_*` flag, honoring
the `range`/`last uid`/`notify blocked users` options.

```php
use Drupal\message_subscribe\Subscribers\DeliveryCandidate;
function mymodule_message_subscribe_get_subscribers($message, array $subscribe_options = [], array $context = []) {
  return [
    2 => new DeliveryCandidate(['subscribe_node'], ['sms'], 2),
    7 => new DeliveryCandidate(['subscribe_og', 'subscribe_user'], ['sms', 'email'], 7),
  ];
}
```

## `hook_message_subscribe_get_subscribers_alter(&$uids, $values)`

Alter the assembled recipient list (add, remove, or change notifiers) after default notifiers are
applied. `$values` = `['context', 'entity_type', 'entity', 'message', 'subscribe_options']`. This is
where `message_subscribe_email` filters recipients down to those with a matching `email_*` flag and
toggles the `email` notifier; `message_subscribe_example` uses it to force `email` on everyone and
add administrators.

```php
function mymodule_message_subscribe_get_subscribers_alter(array &$uids, array $values) {
  foreach ($uids as $uid => $candidate) {
    // e.g. respect a per-user preference field, drop or re-notifier recipients.
  }
}
```

## `hook_message_subscribe_message_alter($message, $delivery_candidate)`

Called immediately before each recipient's (cloned) message is sent; the message owner is already
set to the recipient. Personalize subject/body/fields per user here.

```php
function mymodule_message_subscribe_message_alter(\Drupal\message\MessageInterface $message, \Drupal\message_subscribe\Subscribers\DeliveryCandidateInterface $delivery_candidate) {
  // $delivery_candidate->getAccountId(), ->getFlags(), ->getNotifiers()
}
```
