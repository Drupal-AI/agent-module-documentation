# Configuration

HTTP Client Retry is configured from a single settings form. There you enable
retries globally and shape the retry policy — which failures to retry, how many
times, and how long to wait between attempts.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → System → HTTP Client Retry**, or navigate directly to
   **`/admin/config/system/http_client_retry`**.

## What the settings control

The form lets you **enable or disable retrying** for all outbound requests, and tune
the retry policy — the set of **response status codes** that should trigger a retry
(5xx server errors being the typical choice), the **maximum number of retry
attempts**, and the **backoff** (how long to wait between attempts, which the
underlying library increases with each try). Because the precise field labels can
vary between releases, treat the descriptions on the form itself as the authority,
then save.

> **Tune it sensibly.** A high retry count with aggressive timing can pile extra
> load onto a dependency that is already failing, and can delay the point at which a
> genuine error becomes visible. Modest retry counts with a growing backoff are
> usually the right balance.

## Per-request control (in code)

You do not have to apply the same policy everywhere. A common pattern is to leave
global retries **disabled** in the settings form and opt specific requests in from
custom code:

```php
$client = \Drupal::service('http_client');
$client->request('GET', 'https://example.com/api', ['retry_enabled' => TRUE]);
```

Other Guzzle retry options can likewise be passed per request — see the Guzzle
Retry Middleware README for the full list.

## Retry events and logging

Every time a request is retried, the module dispatches a
`\Drupal\http_client_retry\Event\RequestRetryEvent`
(`http_client_retry.request.retry`) carrying the retry status, the retry
configuration, and the original request and current response. The module's own
optional retry logging is built on this event, and you can subscribe to it in
custom code to take your own action when a retry happens.

## Idempotency caution

Retrying re-sends the request. That is safe for idempotent calls (GET and similar),
but be careful enabling it broadly for non-idempotent **POST** requests that could
cause duplicate side effects (double charges, duplicate records) if sent more than
once.

## Save

Click **Save** to apply your retry policy. It takes effect for subsequent outbound
requests.
