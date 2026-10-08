# API — event subscriber, storage table & block query

## What records a visit — the request subscriber

Service `last_visited_pages.recentplacessubscriber`
(`Drupal\last_visited_pages\LastVisitedPagesSubscriber`), tagged `event_subscriber`, subscribes to
`KernelEvents::REQUEST` and runs `checkForPlaces(RequestEvent $event)` on **every** request.

Constructor args (services.yml order): `@current_user`, `@current_route_match`, `@title_resolver`,
`@request_stack`, `@path.current`, `@database`, `@datetime.time`.

`checkForPlaces()` logic (`LastVisitedPagesSubscriber.php:112`):
1. Resolve the current route's title:
   `$title = $this->titleResolver->getTitle($request, $routeMatch->getRouteObject())`.
2. Normalise it: if `$title` is an array, take `$title['#markup']`; else if not null,
   `$title = strip_tags($title)`.
3. **Only if the title is not null** (i.e. the route has a resolvable title), insert a row:
   - `uid` = `currentUser()->id()`,
   - `path` = `currentPath()->getPath()` (the internal path of the current request),
   - `timestamp` = `time()->getRequestTime()`,
   - `title` = the value from step 2.
4. Prune: select this user's rows ordered `timestamp DESC` with `range(20, 100)` (i.e. everything
   past the 20 most recent), then `DELETE ... WHERE id IN (...)`. Net effect: **≤ 20 rows kept per
   uid**.

Consequences agents should know:
- It writes on **GET** page loads (any request that resolves to a titled route), not only on
  content pages — expect an INSERT + prune query pair on most requests. There is no route allow-list.
- Rows are keyed by `uid`; the block reads and writes history under `currentUser()->id()`.
- There is no cron/queue; retention is enforced inline on each insert.

## Storage — the `last_visited_pages` table

Created by `hook_schema()` in `last_visited_pages.install`; dropped by `hook_uninstall()`.

| Column | Type | Notes |
|---|---|---|
| `id` | serial, PK | auto-increment |
| `title` | varchar(255), not null, default '' | page title (post-`strip_tags` or `#markup`) |
| `path` | varchar(255), not null, default '' | internal path, e.g. `/node/1` |
| `uid` | int unsigned, not null | owner (0 = anonymous) |
| `timestamp` | int unsigned, not null | request time of the visit |

Index `id` on (`id`). No config schema ships for `last_visited_pages.settings` (the module has no
`config/schema/`). To inspect stored history directly:

```bash
ddev drush sqlq "SELECT uid, title, path, timestamp FROM last_visited_pages ORDER BY timestamp DESC LIMIT 10;"
```

## How the block reads it — `LastVisitedPagesBlock::build()`

```php
$uid = $this->currentUser->id();
$num_items = $this->configuration['num_places'] ?: 5;
$rows = $this->database->select('last_visited_pages', 'n')
  ->fields('n', [])
  ->condition('uid', $uid, '=')
  ->range(0, $num_items)
  ->orderBy('timestamp', 'DESC')
  ->execute()->fetchAllAssoc('id');
```

Each row becomes a list item: a link to the stored path, then the visit time formatted with
`date.formatter` using the block's `date_format` (or `custom` + `custom_date_format`). The assembled
`<ul>` is returned as the block's render output. Empty title → shown as `Home`; no rows → a
`No recently visited pages.` message. Queries go through the DB abstraction layer.

## Hooks

- `hook_help` (`last_visited_pages.module`) — help text for `last_visited_pages.settings` and
  `help.page.last_visited_pages`.
- `hook_schema` / `hook_uninstall` (`last_visited_pages.install`) — table lifecycle.

No integrator-facing hooks, events, or services beyond the subscriber are exposed by this module.
