# Negotiator service

Service `consumer.negotiator` (`Drupal\consumers\Negotiator`, interface
`NegotiatorInterface`) resolves which Consumer is making the current request.

```php
$negotiator = \Drupal::service('consumer.negotiator');

// The Consumer entity for this request (or the default, or NULL).
$consumer = $negotiator->negotiateFromRequest();          // ?ConsumerInterface
$consumer = $negotiator->negotiateFromRequest($request);  // pass an explicit Request

// Just the client id string.
$client_id = $negotiator->negotiateClientIdFromRequest($request);
```

How it resolves: it reads the `client_id` from the request (query param / header / body), loads
the matching consumer, and falls back to the consumer flagged `is_default`. If none is found it
may return a `MissingConsumer` placeholder / NULL. Results are cached (`@cache.default`).

`ConsumerVaryEventSubscriber` adds a cache-context/vary so responses cached by Drupal vary per
negotiated consumer — important when different clients get different output. Downstream modules
(e.g. Simple OAuth) call the negotiator to scope tokens and behavior to the requesting client.
