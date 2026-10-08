# Traffic registry service + runtime flow

## Service `purge_queuer_url.registry`

Public service, class `Drupal\purge_queuer_url\TrafficRegistry`, implements
`Drupal\purge_queuer_url\TrafficRegistryInterface`; constructed with `@database`. It is the
store of "which URL served which cache tags". Get it with
`\Drupal::service('purge_queuer_url.registry')` or inject `purge_queuer_url.registry`.

| Method | Signature | Behavior |
|--------|-----------|----------|
| `add` | `add(string $url_or_path, array $tags)` | Upsert (`merge`) the URL with its tag-id list. Throws `\LogicException` if `$tags` empty. Silently **drops URLs longer than 255 chars**. No-op if the table is missing. |
| `remove` | `remove(string $url_or_path)` | Delete the row for that URL. No-op on empty/whitespace URL or missing table. |
| `clear` | `clear()` | Truncate both `purge_queuer_url` and `purge_queuer_url_tag`. |
| `countUrls` | `countUrls(): int` | Number of rows in `purge_queuer_url`. |
| `getUrls` | `getUrls(array $tags, array $exclude_urls = []): string[]` | Return URLs/paths whose stored tag-id list matches any of `$tags` (OR of `LIKE '%;id;%'`). Excludes `$exclude_urls`. Throws `\LogicException` if `$tags` empty. Adds no new tags. |

Storage (`hook_schema` in `purge_queuer_url.install`):
- `purge_queuer_url_tag` — `tagid` (serial), `tag` (varchar_ascii 255, indexed). One row per distinct cache tag ever seen; `getTagIds()` interns tags to ids.
- `purge_queuer_url` — `urlid` (serial), `url` (varchar 255, indexed), `tag_ids` (big text). `tag_ids` is a `;`-delimited list of tag ids, e.g. `;12;40;7;` — the delimiters let `getUrls()` match a whole id with a `LIKE`. All reads/writes go through Drupal's DB API (`merge`/`select`/`insert`/`delete`/`Condition`, `escapeLike`); tag ids used in the LIKE are integers from the DB.

There is **no route or UI that lists registry contents**; only the count is surfaced (see the
diagnostic below). `post_update` `purge_queuer_url_post_update_fix_tagids_3202581` back-fills a
trailing `;` on existing `tag_ids`.

## Runtime flow

**1. Collection — `UrlRegistrar` stack middleware** (`http_middleware.purge_queuer_url_registrar`,
priority 250). Wraps the HTTP kernel; on each response `determine()` decides:
- `FALSE` (ignore): response is not a `CacheableResponseInterface`, **or the request carries a
  session cookie** (`session_name()`) — so authenticated/personalized traffic is never recorded —
  or it is a page-cache `HIT` (`X-Drupal-Cache: HIT`).
- `NULL` (ignore **and** `remove()` the URL if present): response has no cache tags, or
  `max-age < 1` (dynamic), or status code ≠ 200 (403s, redirects), or the URL matches a
  `blacklist` substring.
- `TRUE` (register): otherwise `add(url, cacheTags)`.

The stored string comes from `generateUrlOrPathToRegister()`: `scheme://host/path?query`, or a
bare path when `queue_paths` is on, with `host`/`scheme` overridden per config.

**2. Translation — `UrlAndPathQueuer`** (`purge_queuer_url.queuer`, tagged
`cache_tags_invalidator`, so core calls it whenever tags are invalidated). `invalidateTags()`:
lazily loads the `urlpath` queuer plugin (no-op if that plugin is disabled), calls
`registry->getUrls($tags, $alreadyQueued)`, and for each result builds a Purge invalidation of
type `url` (string contains `://`) or `path`, then `purge.queue->add()`s them. Per-request it
de-duplicates already-seen tags (`$invalidatedTags`) and URLs (`$invalidatedUrls`). It silently
returns if no purger supports the type (`TypeUnsupportedException`) or Purge is mid-uninstall
(`PluginNotFoundException`). A purger that can act on URLs/paths must be enabled for anything to
be queued.

**3. Health — `RegistryCheck`** Purge diagnostic plugin (id `purge_queuer_url_registry`). Reports
`countUrls()`; warns when `< 50` (spider the site to train it) or `> 7000` (registry too large,
consider tag-based invalidation). Shown on Purge's status dashboard.
