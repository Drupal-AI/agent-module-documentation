<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events — response subscriber (snippet injection)

`Drupal\multidomain_google_analytics\EventSubscriber\GoogleAnalyticResponseSubscriber`
(service `multidomain_google_analytics.response_subscriber`) is how the tracking snippet reaches the
page. There is no block or template — it rewrites the response HTML directly.

## Wiring

- Service args: `@config.factory`, `@domain.negotiator`; tagged `event_subscriber`.
- `getSubscribedEvents()` → `KernelEvents::RESPONSE` handled by `addTag`, priority **`-500`**
  (runs late, after most response processing).
- Constructor caches `$this->config = configFactory->get('multidomain_google_analytics.settings')`
  and, if `$negotiator->getActiveDomain()` is set, `$this->activeDomain = $negotiator->getActiveId()`
  (the active domain's entity id).

## `addTag(ResponseEvent $event)`

1. Returns immediately unless `$event->isMainRequest()` (sub-requests are skipped).
2. Reads `$compact = $this->config->get($this->activeDomain)` — the GA id stored for the active
   domain (empty when the domain has no id configured, in which case nothing is injected).
3. When an id exists, injects `getTag($compact)` right after the opening body tag:

   ```php
   $response_text = preg_replace('@<body[^>]*>@', '$0' . $this->getTag($compact), $response->getContent(), 1);
   if ($response_text) {
     $response->setContent($response_text);
   }
   ```

   (Only the first `<body …>` match is replaced; the snippet is prepended inside `<body>`.)

## `getTag($compact)`

Builds the standard Google Analytics `gtag.js` block wrapped in
`<!-- Google Analytics -->` … `<!-- End Google Analytics -->` comments, using the configured id in
both the loader URL and the `gtag('config', …)` call:

```html
<script async src="https://www.googletagmanager.com/gtag/js?id=<id>"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '<id>');
</script>
```

When `$compact` is truthy the whitespace/newlines are stripped (`str_replace(["\n", '  '], '', …)`)
to compact the markup. Because the subscriber operates on the fully rendered response for the active
host, each domain gets only its own id; there is no separate cache-context handling in this module —
per-host variation comes from the internal page cache being keyed by URL/host.
