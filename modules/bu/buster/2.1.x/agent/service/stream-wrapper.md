<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Buster: public stream wrapper override

## Install / enable
`drush en buster -y`. No configuration, no permissions, no dependencies. Enabling the module is the
entire setup; disabling/uninstalling reverts to core's plain `PublicStream`.

## What it overrides
`buster.services.yml` redefines the core service `stream_wrapper.public`:

```
services:
  stream_wrapper.public:
    class: Drupal\buster\PublicStreamBusted
    tags:
      - { name: stream_wrapper, scheme: public }
```

`Drupal\buster\PublicStreamBusted` extends `Drupal\Core\StreamWrapper\PublicStream`. Everything about
the `public://` scheme is inherited unchanged except URL generation.

## `getExternalUrl()` (the only behavioral change)
For a `public://…` URI:
1. Calls `parent::getExternalUrl()` to get the normal file URL.
2. `isCacheBusterRequired($uri)` returns FALSE (skip) when the URI starts with `public://css/` or
   `public://js/` — core already versions aggregated CSS/JS — otherwise TRUE.
3. When busting is required it builds `$token_data = [ $uri ]` and appends either
   `sha1_file($uri)` (if the file exists and hashes successfully) or, as a fallback,
   `\Drupal::time()->getRequestTime()`.
4. Computes the token via `getBusterToken(implode(':', $token_data))` =
   `substr(Crypt::hmacBase64($data, private_key . hash_salt), 0, 8)` — an 8-char, base64 HMAC keyed by
   `\Drupal::service('private_key')->get()` (`getPrivateKey()`) concatenated with
   `Settings::getHashSalt()` (`getHashSalt()`).
5. Appends `_buster=<token>` to the URL, using `?` or `&` depending on whether the URL already has a
   query string (`UrlHelper::buildQuery()`).

Result: `…/sites/default/files/foo.png?_buster=Ab12Cd34`. Same file bytes → same token; changed bytes
→ new token → downstream caches (browser, CDN, proxy) refetch.

## Operating notes
- The token is content-addressed (via `sha1_file`), not time-based, so URLs are stable across requests
  until the file contents change. The request-time fallback only triggers when the file is unreadable
  at URL-build time (e.g. remote/offloaded storage), which yields a per-request token.
- Because a `sha1_file()` read happens on each external-URL build for a public file, sites serving many
  large public files may see extra local file I/O; render/URL caching mitigates this in normal use.
- The `_buster` value is not a security token and is not verified anywhere — it is purely a cache key.
  Drupal serves the file regardless of the query string.
- No routes, forms, config objects, schema, permissions, hooks, or Drush commands are provided; there
  is nothing to configure or to expose.
