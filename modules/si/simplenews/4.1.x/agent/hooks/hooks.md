# Hooks — `simplenews.api.php`

## Subscription events

```php
use Drupal\simplenews\SubscriberInterface;

// Fired when a subscriber is subscribed to a newsletter.
function mymodule_simplenews_subscribe(SubscriberInterface $subscriber, string $newsletter_id) {}

// Fired when a subscriber is unsubscribed from a newsletter.
function mymodule_simplenews_unsubscribe(SubscriberInterface $subscriber, string $newsletter_id) {}
```

## Alter per-mail send result

```php
use Drupal\simplenews\Spool\SpoolStorageInterface;
use Drupal\simplenews\AbortSendingException;

// Called after each mail is sent; reclassify a single-recipient error vs a global failure.
function mymodule_simplenews_mail_result_alter(&$result, array $message) {
  // $result is one of SpoolStorageInterface::STATUS_* (e.g. STATUS_FAILED).
  // Throw AbortSendingException to stop the whole run on a transport-level error.
}
```

## Operation & cache hooks

- `hook_simplenews_issue_operations()` — add operations available on newsletter issues.
- `hook_simplenews_subscription_operations()` — add bulk operations on subscriptions
  (activate / inactivate / delete).
- `hook_simplenews_source_cache_info()` — expose custom mail-source cache implementations.

## Entity CRUD hooks

Because `simplenews_subscriber` and `simplenews_subscriber_history` are content entities and
`simplenews_newsletter` is a config entity, the standard generic hooks fire
(`hook_ENTITY_TYPE_presave/insert/update/delete`, `hook_entity_*`) — use them to react to
subscribers or newsletters being created or changed.
