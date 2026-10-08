<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LSCache — ESI fragment API

Promote a per-user chunk of an otherwise-shareable page to an ESI fragment so the
surrounding page stays in shared public cache while LSWS holds the chunk per user.

## Render element
```php
$build['cart_count'] = [
  '#type' => 'lscache_esi',
  '#callback' => 'my_module.cart:renderCount', // service:method or Class::staticMethod
  '#args' => [$user_id],                        // JSON-primitive args only
];
```
The element (`Drupal\lscache\Element\Esi`) renders
`<esi:include src="/lscache-fragment/{token}" />`. LSWS (with ESI processing on for
the vhost) fetches the fragment, caches it per user, and stitches it into the page.

## Route & trust model
- Route `lscache.fragment` — `/lscache-fragment/{token}`, `_access: 'TRUE'`,
  `GET`, `no_cache: TRUE`, controller `LscacheFragmentController::render`.
- The `{token}` is **HMAC-SHA256 signed** on the site hash salt
  (`LscacheTokenSigner`), so callers cannot forge, enumerate, or replay fragments.
- The callback's class **must implement `TrustedCallbackInterface`** and list the
  method in `trustedCallbacks()` — the same policy core enforces on `#lazy_builder`.
  The route rejects a token whose callback resolves to a non-trusted class even if
  the signature is valid (defence in depth against a salt compromise).
- Every fragment carries an `lscache_esi` cache tag; invalidating it drains all
  fragments site-wide.
