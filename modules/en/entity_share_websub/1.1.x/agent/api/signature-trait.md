<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `SignatureTrait` — the shared WebSub signing helper

Namespace: `Drupal\entity_share_websub\SignatureTrait`. This is the entire public surface of
the base module. Both submodules `use` it to sign outgoing requests and validate incoming ones,
so the same input always yields the same `X-Hub-Signature`.

## Method

```php
protected function getSignature($data, $secret): string
```

- `$data` — an array **or** object that is serializable. If `$data` is an array it is first
  normalised through `UrlHelper::buildQuery($data)` then `parse_str()` back into an array
  (so query-string ordering/encoding is canonical before hashing).
- `$secret` — a shared secret string (the per-subscription secret).
- Returns `"sha256=" . hash('sha256', $secret . serialize($data))`.

Note the payload is `secret . serialize($data)` — the secret is prepended, then the
PHP-serialized data is appended, then hashed with SHA-256.

## Where it is used

- Hub (`entity_share_websub_hub\Hub`): signs `PUT` update payloads and `DELETE` cancels, and
  signs the challenge query when validating a subscriber's intent — sent as `X-Hub-Signature`.
- Subscriber (`entity_share_websub_subscriber\Controller\SubscriptionController`): recomputes
  the signature from the request and compares it to the incoming `X-Hub-Signature` header to
  authenticate hub callbacks (verify / update / delete). A mismatch is rejected.

## Reuse

To interoperate with (or test) these callbacks, `use SignatureTrait;` in your own class and
call `$this->getSignature($data, $secret)`; feed it the exact array of `hub.*` query params or
the raw request body the counterpart used, with the matching per-subscription `secret`.
