<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Header-split subscriber

`EventSubscriber\DebugCacheabilityHeadersSplitSubscriber` (service `debug_cacheability_headers_split.response_subscriber`).

## Construction
Injected with `@config.factory` and the container parameter `%http.response.debug_cacheability_headers%` (core's debug flag). The flag is stored in `$debugCacheabilityHeaders`; when it is FALSE the subscriber short-circuits.

## Subscribed event
`getSubscribedEvents()` returns `KernelEvents::RESPONSE => ['onRespond', -500]`. Priority -500 makes it run after core's `FinishResponseSubscriber`, so the debug headers already exist on the response before this subscriber inspects them.

## `onRespond(ResponseEvent $event)` logic
Guards (returns without acting on any of these):
1. Not the main request (`!$event->isMainRequest()`).
2. Core debug cacheability headers disabled (`!$this->debugCacheabilityHeaders`).
3. Response is not a `CacheableResponseInterface`.

Then, for each name in the static list `['X-Drupal-Cache-Tags', 'X-Drupal-Cache-Contexts']`:
- Read the current header value.
- If it is non-empty AND `strlen($value) > header_size_limit`, split it:
  `explode("\n", wordwrap($value, header_chunk_size))` — word-wrap at chunk size, then split on newlines.
- Re-emit each chunk with `$response->headers->set($name . ($delta > 0 ? "-{$delta}" : ''), $row)`. Delta 0 overwrites the original header; subsequent chunks become `<name>-1`, `<name>-2`, ….

Because `wordwrap` breaks on whitespace, individual cache-tag/context literals are never split; a chunk could theoretically exceed the limit only if a single literal were longer than the (≥1024-byte) limit, which does not occur in practice.

## Operating notes
- No action unless both the debug flag is on and the response is cacheable — so it is inert on production sites that leave debug cacheability headers off.
- To reassemble a value, concatenate the base header with its numbered continuations in order.
- Reference test: `tests/src/Unit/EventSubscriber/DebugCacheabilityHeadersSplitSubscriberTest.php`.
