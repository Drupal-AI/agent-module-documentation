# REST Absolute URLs — manual setup guide

**REST Absolute URLs** (`rest_absolute_urls`) is a tiny helper for decoupled and
headless Drupal sites. Drupal normally writes links and image sources relative to
the site root — `/sites/default/files/photo.jpg` or `/node/12`. That is exactly
right inside a rendered page, but useless in an API response: a React or Vue front
end running on a different origin, a mobile app, or any system consuming your REST
output receives a path with no host attached and no reliable way to know which
server the file really lives on. The usual symptom is a broken image that only
appears in the decoupled build, never in Drupal's own preview.

This module fixes that once, at the serialisation layer. It rewrites the relative
URLs in content fields into absolute ones as content is exposed through any REST
service, so every consumer receives links and image sources it can resolve without
each one having to prefix the base URL itself. Because the rewrite happens centrally,
you do not touch any consumer code — enable the module and the URLs come out
absolute. It depends only on core's **Serialization** module and there is nothing
to configure in the admin UI.

The one thing worth getting right is *which* base URL the module uses. Drupal
determines the host it believes it is serving from your `settings.php`
(`trusted_host_patterns` and the reverse-proxy settings). Behind a reverse proxy or
CDN, if those are wrong the absolute URLs will be wrong too — and wrong in a way
that only shows up in the API, not in the browser. There is also a known Docker /
server-side-rendering wrinkle where Node's request reaches Drupal by container name
(for example `http://nginx/`), so Drupal uses the container name as the base URL.
The fix is to set the base URL explicitly in `settings.php`:

```php
$config['rest_absolute_urls']['base_url'] = 'https://example.com';
```

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Once enabled it works
automatically for content exposed via REST; the only optional tuning is the
`settings.php` `base_url` override described above.

## Where it lives in the admin menu

REST Absolute URLs adds no admin page and no settings form. Its effect is invisible
in the UI — you see it in your API responses, where file and link URLs now come back
with a full `https://your-site` prefix.
