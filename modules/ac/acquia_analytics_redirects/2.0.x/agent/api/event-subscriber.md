<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Response subscriber: re-applying Varnish-stripped analytics params

The module is one service and one method. There is nothing to configure or call.

## Install / enable

```
composer require drupal/acquia_analytics_redirects
drush en acquia_analytics_redirects -y
```

No config export, no permissions to grant, no routes. It starts working immediately. For the
rewrite to actually fire, the request must arrive with the `X-Acquia-Stripped-Query` header — in
practice that means the site is fronted by Acquia Cloud Varnish with its query-stripping VCL. Per
the project page, core's **Internal Page Cache** module must be disabled/uninstalled, otherwise the
page cache can serve the redirect before this late (`-1024`) subscriber runs.

## The service

`acquia_analytics_redirects.services.yml`:

- id `acquia_analytics_redirects_subscriber`
- class `Drupal\acquia_analytics_redirects\EventSubscriber\AnalyticsRedirectsEventSubscriber`
- tag `event_subscriber`

`getSubscribedEvents()` returns `KernelEvents::RESPONSE => [['getHeaderAcquiaStrippedQuery', -1024]]`.
Priority `-1024` is deliberately very low so the handler runs after other response subscribers have
finalized the redirect it needs to rewrite.

## What `getHeaderAcquiaStrippedQuery(ResponseEvent $event)` does

1. Read `$response = $event->getResponse()`. Bail unless the status code is `301` or `302`.
2. Read request header `X-Acquia-Stripped-Query`. Bail if empty.
3. `$url_parts = UrlHelper::parse($response->getTargetUrl())` — splits the already-issued redirect
   target into `path` (scheme+host+path), `query`, `fragment`. The **host/path come from the
   redirect Drupal already decided to emit**, never from the header.
4. `$stripped_params = UrlHelper::parse('?' . $query_string)['query']` — parse the header value.
5. Rebuild:
   `$target = $url_parts['path'] . '?' . UrlHelper::buildQuery(array_merge($stripped_params, $url_parts['query']))`.
   Because `array_merge` puts `$url_parts['query']` last, **the target's own query params win on
   key collision** — an explicitly configured destination value is never clobbered by an incoming
   analytics value of the same key. `UrlHelper::buildQuery` url-encodes the result.
6. If the target had a `#fragment`, re-append it: `$target .= '#' . $url_parts['fragment']`.
7. Add `X-Acquia-Stripped-Query` to the response `Vary` header (`$response->setVary(...)`) so Varnish
   keeps a separate cache entry per stripped-query value.
8. Replace the response:
   `$event->setResponse(new TrustedRedirectResponse($target, $response->getStatusCode(), $response->headers->all()))`.
   `TrustedRedirectResponse` is used because the target may be an external/absolute URL; the trusted
   part (host+path) is inherited from the pre-existing response, so no new redirect target is
   introduced.

## Behavior summary (from the kernel tests)

`tests/src/Kernel/AnalyticsRedirectsEventSubscriberTest.php` pins the contract:

- Non-3xx response → untouched, `Vary` stays empty (`testNon3xxRequest`).
- 3xx without the header → untouched (`testNoAcquiaStrippedQueryRequestHeader`).
- `/landing?ref=spring` + header `gclid=4` → `/landing?ref=spring&gclid=4` (target params kept,
  `testTargetQueryParamsPreserved`).
- `/landing?gclid=target&ref=spring` + header `gclid=stripped&utm_source=news` →
  `gclid=target` wins, `utm_source=news` merged in, `ref=spring` kept
  (`testTargetQueryParamsWinOnCollision`).
- `/landing#form` + header `gclid=4` → `/landing?gclid=4#form` (fragment kept,
  `testFragmentPreserved`).
- Plain `https://example.com` + header `gclid=4` → response replaced, `Vary: X-Acquia-Stripped-Query`,
  query `gclid=4` (`testHasAcquiaStrippedQueryRequestHeader`).

## Verify on a running site

Send a request that Drupal redirects, spoofing what Varnish would inject, and inspect the `Location`
and `Vary` of the redirect:

```
curl -sI -H 'X-Acquia-Stripped-Query: gclid=4&utm_source=news' https://your-site/old-path
# Location: .../new-path?...gclid=4&utm_source=news   Vary: ...X-Acquia-Stripped-Query
```

If nothing changes, confirm the response is a 301/302 and that Internal Page Cache is not serving
it first.
