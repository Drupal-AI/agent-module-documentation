# Render an entity to JSON:API in PHP

Service `jsonapi_extras.entity.to_jsonapi` (`Drupal\jsonapi_extras\EntityToJsonApi`, `@api`).
Produces an entity's JSON:API representation server-side — honoring all resource overrides and
enhancers — without an external HTTP round-trip.

```php
$to = \Drupal::service('jsonapi_extras.entity.to_jsonapi');

// Raw JSON:API string (top-level "data", plus "included" for the includes).
$json = $to->serialize($node, ['uid', 'field_tags']);

// Decoded array (same content as an array instead of a string).
$array = $to->normalize($node, ['uid', 'field_tags']);
```

- Second argument is the list of relationship paths to **include** (same syntax as the
  `?include=` query parameter), e.g. `['uid', 'field_tags.vid']`.
- Output reflects the public resource type name, renamed/disabled fields, and any enhancers
  configured for the entity's resource.
- Runs a real sub-request through the HTTP kernel under the current session, so access control
  and normalization match a live API request.
- Handy for: embedding payloads in a decoupled bootstrap, priming a cache, generating fixtures,
  or attaching JSON:API data to a message/queue item.
