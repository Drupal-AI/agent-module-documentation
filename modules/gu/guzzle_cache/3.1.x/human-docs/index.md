# Guzzle Cache Backend — manual setup guide

**Guzzle Cache Backend** (`guzzle_cache`) is a developer's building block: it
lets the popular
[Guzzle HTTP caching middleware](https://github.com/Kevinrob/guzzle-cache-middleware)
store its cached responses in Drupal's own cache system. In plain terms, when
your code calls a remote API through Guzzle, the responses can be cached in the
same place — Redis, Memcached, or the database — where the rest of the site's
cache lives, cleared by the same cache rebuild and visible to the same
monitoring.

Why bother, instead of just stashing the parsed result yourself? Because HTTP
already knows how to cache. A well-behaved API tells you, in its response
headers, how long a response is good for (`Cache-Control`), and gives you an
`ETag` or `Last-Modified` you can use to revalidate cheaply — asking "has this
changed?" instead of downloading it all over again. The Guzzle caching
middleware implements that HTTP caching model properly; this module simply hands
it a Drupal-backed store so the benefits land inside your normal cache
infrastructure. This is version **3.1.0** and it ships an optional
`guzzle_cache_middleware` submodule.

Two cautions worth reading before you wire it up. First, **a cached API response
is data at rest**: if an endpoint returns personal or authorized data, that data
is now sitting in your shared cache backend. Make sure the cache key varies by
whatever the response varies by — a per-user API response cached under a shared
key is the classic, severe bug that serves one user's data to another. Second,
**respecting upstream cache headers means trusting them**: an API that sends no
`Cache-Control` gets whatever default you configure, and one that claims a long
lifetime on data that actually changes will be served stale for exactly as long
as it said.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. It provides a PHP class you
use from your own module's code — there are no site-wide settings to fill in.

## How to use it

Guzzle Cache Backend is used in code, not in the admin UI. You build a Guzzle
handler stack, push the caching middleware onto it backed by this module's
`DrupalGuzzleCache`, and pass that stack to your Guzzle client. It's good
practice to give the HTTP cache its own dedicated cache bin so you can manage and
clear it independently of other caches.

```php
use GuzzleHttp\Client;
use GuzzleHttp\HandlerStack;
use Kevinrob\GuzzleCache\CacheMiddleware;
use Kevinrob\GuzzleCache\Strategy\PrivateCacheStrategy;
use Drupal\guzzle_cache\DrupalGuzzleCache;

// Create the default handler stack.
$stack = HandlerStack::create();

// Back the cache with a Drupal cache bin. Defining a dedicated bin
// (e.g. my_custom_http_cache_bin) in a *.services.yml file lets you
// manage this cache independently of other cache bins.
$cache = new DrupalGuzzleCache(
  \Drupal::service('cache.my_custom_http_cache_bin')
);

// Push the caching middleware onto the stack.
$stack->push(
  new CacheMiddleware(new PrivateCacheStrategy($cache)),
  'cache'
);

// Build the client with the handler, and requests are now cached.
$client = new Client(['handler' => $stack]);
$response = $client->request('GET', 'http://www.example.com/');
```

Choose the caching strategy deliberately: `PrivateCacheStrategy` (shown above) is
appropriate when responses may be user-specific, while a shared/public strategy
suits genuinely public data. Revisit the two cautions in the introduction — cache
key correctness and header trust — when you pick a strategy.
