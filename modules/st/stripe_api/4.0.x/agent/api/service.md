# Service, client, and webhook events (API)

## Service — `stripe_api.stripe_api`

`Drupal\stripe_api\StripeApiService` (constructor args: `@config.factory`, `@entity_type.manager`,
`@logger.channel.stripe_api`, `@key.repository`). Inject it to get a ready-to-use Stripe client that
already carries the configured API key and (optional) API version — you never build a `StripeClient`
by hand.

```php
use Drupal\stripe_api\StripeApiService;

class MyStripeThing {
  public function __construct(protected StripeApiService $stripeApi) {}

  public function listSubscriptions(): array {
    $client = $this->stripeApi->getStripeClient();      // \Stripe\StripeClient
    return $client->subscriptions->all()->data;
  }
}
```

Or grab it directly: `\Drupal::service('stripe_api.stripe_api')`.

### Methods (`StripeApiService.php`)

| Method | Returns | Notes |
|---|---|---|
| `getStripeClient(array $config = [])` | `\Stripe\StripeClient` | Builds a client with `api_key` = `getApiKey()` and `stripe_version` = `getApiVersion()`; `$config` is `array_merge`d over those defaults, so you can override per call. |
| `getApiKey()` | `?string` | Secret key for the current mode. Reads config key `<mode>_secret_key` (a Key entity id), then `key.repository->getKey($id)->getKeyValue()`. `NULL` if unset. |
| `getPubKey()` | `?string` | Publishable key for the current mode (`<mode>_public_key`), resolved the same way. |
| `getWebhookSigningSecret()` | `?string` | Env `STRIPE_WEBHOOK_SIGNING_SECRET` first; else the Key entity referenced by `<mode>_webhook_signing_secret`. `NULL` if neither is set. |
| `getMode()` | `string` | `mode` config; defaults to `'test'` when empty. |
| `getApiVersion()` | `?string` | `api_version_custom` when `api_version === 'custom'`, otherwise `NULL` (use the Stripe account default). |

`<mode>` is `test` or `live` (see [../configure/settings.md](../configure/settings.md)). All secrets
resolve through the Key module, so config stores only key **ids**, not secret values.

## Webhook route + controller

Stripe POSTs events to `/stripe/webhook`. Two routes share that path:

| Route | Path | Methods | Controller |
|---|---|---|---|
| `stripe_api.webhook` | `/stripe/webhook` | `POST` (`_content_type_format: json`) | `Controller\StripeApiWebhook::handleIncomingWebhook` |
| `stripe_api.webhook_redirect` | `/stripe/webhook` | `GET, HEAD, PUT, DELETE` | `Controller\StripeApiWebhookRedirect::webhookRedirect` |

Both declare `_permission: 'access content'` (reachable by anonymous, as Stripe's servers must be — the
real authentication is the signature check inside the POST handler). `handleIncomingWebhook`
(`StripeApiWebhook.php`):

1. Returns `403` immediately if `enable_webhooks` config is `FALSE`.
2. `getEventFromRequest()` calls `\Stripe\Webhook::constructEvent($request->getContent(),
   $request->headers->get('stripe-signature'), $secret)` with `$secret = getWebhookSigningSecret()`.
   The SDK verifies the `Stripe-Signature` HMAC against the signing secret, enforces a timestamp
   tolerance and does a constant-time compare. On failure it returns `NULL` → the handler responds `403`.
3. On success it constructs `new StripeApiWebhookEvent($event->type, $event)` and dispatches it as
   `'stripe_api.webhook'`, then responds `200 'Okay'`.
4. If a subscriber throws `\RuntimeException`, it responds `503` with a `Retry-After: 5` header so Stripe
   retries (rather than treating the event as delivered).

The GET/HEAD/etc. route (`webhookRedirect`) just flashes a "The webhook route works properly." message
and redirects to the front page — a smoke test that the path resolves.

## Subscribe to `stripe_api.webhook`

React to a verified Stripe event by subscribing to the `'stripe_api.webhook'` event name with a
`StripeApiWebhookEvent`:

```php
use Drupal\stripe_api\Event\StripeApiWebhookEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyWebhookSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return ['stripe_api.webhook' => ['onWebhook']];
  }

  public function onWebhook(StripeApiWebhookEvent $event): void {
    // $event->type  — string, e.g. 'checkout.session.completed', 'invoice.paid'.
    // $event->event — \Stripe\Event (the full deserialized Stripe event object).
    if ($event->type === 'checkout.session.completed') {
      $session = $event->event->data->object;   // \Stripe\Checkout\Session
      // ... act on it (see the re-fetch guidance below).
    }
  }
}
```

Register the subscriber as a service tagged `event_subscriber` (as the module does for
`stripe_api.webhook_subscriber` in `stripe_api.services.yml`).

`StripeApiWebhookEvent` (`Event/StripeApiWebhookEvent.php`) is a plain
`Symfony\Contracts\EventDispatcher\Event` with two public properties: `->type` (string) and `->event`
(`\Stripe\Event`). The bundled `StripeApiWebhookSubscriber::onIncomingWebhook` only logs the event name
+ data when the `log_webhooks` setting is on; it takes no other action — all business behaviour is meant
to live in your own subscribers.

For anything that grants access, fulfils an order or moves money, treat the delivered payload as a
pointer and **re-fetch the object from Stripe** (via `getStripeClient()`) before acting — the standard
Stripe integration practice.
