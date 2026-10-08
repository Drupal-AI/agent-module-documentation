# How visits are recorded + the `counter` table

Counter records **one DB row per request** through two complementary code paths, so both
uncached and page-cached responses are counted.

## 1. Uncached requests — event subscriber

`Drupal\counter\EventSubscriber\CounterEventsSubscriber::counterInsert()` is subscribed to
`KernelEvents::REQUEST` (service `counter.counter_event_subscriber`). On each request it:

1. Reads `counter.settings`. If `counter_skip_admin` is on and the user has the
   `administrator` role → return (no count).
2. If `counter_only_pages` is on and the request is a sub-request or not `GET` → return.
3. Computes `$path = $request->getPathInfo()` and skips when the path starts with `/sites/`,
   matches `^/history/\d+/read$`, or starts with `/admin/config/counter`.
4. Invokes `hook_counter_request_alter($event, &$skip)` (integrators may force a skip).
5. Builds the data row and invokes `hook_counter_data_alter(&$data, &$skip)`.
6. Calls `CounterUtility::insertCounterData($data)`.

This path runs for anonymous and authenticated users alike, but only when Drupal actually
boots the kernel — i.e. it does NOT fire when the internal page cache short-circuits a
response.

## 2. Page-cache HITs — stack middleware

`Drupal\counter\StackMiddleware\CounterMiddleware` (service `counter.middleware`, tag
`http_middleware` priority **210**) wraps the kernel. After the response is produced it checks:

```php
if ($response->headers->get('X-Drupal-Cache') === 'HIT') {
  $this->counterUtility->recordCounterData($request);
}
```

So an anonymous request served from the internal page cache (where the REQUEST event never
runs) is still recorded. `recordCounterData()` applies only the `counter_skip_admin` gate
(not the path/method skips) before inserting.

## The data row

Both paths assemble the same fields (`CounterUtility::recordCounterData` /
`CounterEventsSubscriber::counterInsert`):

| field | source |
|-------|--------|
| `ip` | `$request->getClientIp()` (honours trusted-proxy config) |
| `url` | `Html::escape($request->getRequestUri())`, truncated to 255 chars |
| `uid` | `$account->id()` |
| `nid` / `type` | `$request->attributes->get('node')` if a `NodeInterface`, else `0` / `''` |
| `browser_name`, `browser_version`, `platform` | `CounterUtility::getBrowserInformation()` — hand-rolled `preg_match` on the `User-Agent` (IE/Edge/Opera/Chrome/Firefox/Safari; Linux/Mac/Windows). Falls back to `Unknown`. |
| `created` | `time()` (set inside `insertCounterData`) |

`insertCounterData()` uses the parameterized DB API insert builder (`->insert('counter')
->fields([...])`).

## The `counter` table (from `counter.install` `hook_schema`)

| column | type | notes |
|--------|------|-------|
| `counter_id` | serial, unsigned | primary key |
| `ip` | varchar(45) | IPv4/IPv6 (widened to 45 in `counter_update_8102`/`8103`) |
| `created` | int | Unix timestamp; indexed |
| `url` | varchar(255) | request URI |
| `uid` | int | indexed; `0` = anonymous |
| `nid` | int | indexed; `0` = non-node |
| `type` | varchar(255) | node bundle |
| `browser_name` / `browser_version` / `platform` | varchar(64) | |

Indexes: `uid`, `nid`, `ip`, `created`. `hook_uninstall` drops the table.
`counter_update_8101` removed an obsolete `counter_data` table and the removed
`counter_refresh_delay` / `counter_insert_delay` settings.

## Notes for operators

- The table grows by one row **per counted request** and is never pruned by the module —
  plan retention yourself on high-traffic sites.
- Because rows are written per request, the display blocks are made cacheable via the
  `counter_data_refresh` cache tag, which `hook_cron` invalidates (see
  [../hooks/hooks.md](../hooks/hooks.md)); enable cron so counts refresh.
