# Calling Mailchimp from code

Two services wrap `thinkshout/mailchimp-api-php`.

## `mailchimp.api` (`Drupal\mailchimp\ApiService`)
High-level helpers with caching.

```php
/** @var \Drupal\mailchimp\ApiService $api */
$api = \Drupal::service('mailchimp.api');

$client   = $api->getApiObject('MailchimpApiUser');   // raw library client for a given class
$audiences = $api->getAudiences();                    // array of audiences (cached; pass IDs / $reset)
$mergevars = $api->getMergevars(['<audience_id>']);   // merge fields per audience (cached)
```

- `getApiObject(string $classname = 'MailchimpApiUser')` — returns the underlying API client
  (or NULL if not configured), for arbitrary Mailchimp API calls.
- `getAudiences(array $audience_ids = [], bool $reset = FALSE)` — audiences, cached in the
  `mailchimp` cache bin; `$reset` bypasses the cache.
- `getMergevars(array $audience_ids, bool $reset = FALSE)` — merge variables per audience.

## `mailchimp.client_factory` (`Drupal\mailchimp\ClientFactory`)
Lower-level client construction.
- `getByClassName(string $classname = 'MailchimpApiUser')` — build a client (throws
  `ClientFactoryException` if misconfigured).
- `getByClassNameOrNull(...)` — same but returns NULL instead of throwing.
- `getApiClass()` — the configured `MailchimpApiInterface` implementation.

Other pieces: `mailchimp.queue.processor` (`Queue\Processor`) drains queued subscription ops
on cron; the `mailchimp` cache bin holds audience/mergevar data; `Event\Authenticate` fires
during OAuth authentication.
