# index_now — programmatic pings (IndexNow service)

Service **`index_now.indexnow`** (`Drupal\index_now\Service\IndexNow`, interface
`IndexNowInterface`). Also aliased to the class name for autowiring.

```php
/** @var \Drupal\index_now\Service\IndexNowInterface $indexNow */
$indexNow = \Drupal::service('index_now.indexnow');

// Submit any absolute URL. Optional context is passed to hook_index_now_url_alter().
$indexNow->sendRequest('https://example.com/some/page', ['entity' => $node]);
```

## `sendRequest(string $page_url, array $context = []): void`

1. Returns immediately if there is no API key.
2. Invokes `hook_index_now_url_alter($page_url, $context)`.
3. De-duplicates: an in-memory `$sentUrls` set skips a URL already sent in this request/cron run
   (prevents double pings when e.g. `node_update` + `path_alias_update` both fire).
4. If `async_mode` is on → `queueFactory->get('index_now_submissions')->createItem(['url' => …])`
   and returns (sent later by the `IndexNowQueueWorker` on cron, `cron time: 30`).
5. Otherwise calls `doSendRequest()` inline.

## `doSendRequest(string $page_url, string $api_key): void`

Performs the actual HTTP call (`http_client` GET) to
`{engine}/indexnow?url=…&key=…&keyLocation=…` (URL built by the protected `buildUrl()`, which reads
`default_engine` from config and the `ENDPOINTS` map, then decodes the query string).

- Success = HTTP 200/202. On other statuses/exceptions it logs a warning/error (channel
  `index_now`); `verbose_mode` also logs successes.
- User-facing messages (`messenger`) are only shown when `can_view_results` — CLI context, or the
  current user has `view index now submission results`.

## Queue worker

`IndexNowQueueWorker` (`id: index_now_submissions`, `cron time: 30`) reads `['url' => …]` items and
calls `doSendRequest($url, $key)` (skips if no url or no key). Enabled implicitly by `async_mode`;
processed on cron.

## Notes

- The engine endpoints are a fixed allowlist (`IndexNowInterface::ENDPOINTS`), so the outbound host
  is not user-controllable; the submitted `page_url` comes from entity canonical URLs (or your
  `sendRequest()` caller / the url_alter hook).
- Use this service directly to ping URLs that aren't tied to an entity save (e.g. a custom listing
  page you changed).
