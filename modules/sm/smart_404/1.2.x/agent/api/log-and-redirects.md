<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart 404 — the 404 log UI, redirect creation, and services

## Logging pipeline

1. **`Smart404Subscriber`** (`src/EventSubscriber/`, tagged `event_subscriber`). On
   `KernelEvents::RESPONSE` (priority -100) it logs any main-request response with status 404. When
   `search404_integration` is on and Search 404 is installed, it also handles `KernelEvents::EXCEPTION`
   (priority 50) for a `NotFoundHttpException`, before Search 404 can rewrite the response, and sets a
   `_smart404_logged` request attribute so `onResponse()` does not double-log. `logRequest()` passes
   the path (+ raw query string), User-Agent, Referer, and `Request::getHost()` to the logger.
2. **`Smart404Logger::log()`** (`src/Logger/`). Skips if already logged this request; skips admins when
   `ignore_authenticated_admin`; normalizes + truncates the path (1024); skips on an ignore-pattern
   match (`GlobMatcher`); detects bots (`BotDetector`) and skips if `log_bots` is off; sanitizes the
   referer; computes `key_hash` (`PathNormalizer::hash()`); then upserts. Wrapped in a broad
   `catch (\Throwable)` so a 404 never becomes a 500 (e.g. a pending DB update), logging only the
   exception **class**, never the message (which would embed path/referer/host).
3. **`Smart404Repository::upsert()`** does a `merge()` on `smart_404_log` keyed by `key_hash`
   (insert with `hits=1`, else `hits = hits + 1` and update `last_seen`/`referer_last`).
   `recordDailyHit()` merges into `smart_404_log_daily` (keyed by `key_hash`+`hit_date`, an integer
   `YYYYMMDD` in the site timezone via `DateBucket`).

Tables (`smart_404.install`): `smart_404_log` (id, path, key_hash [unique], host, hits, first_seen,
last_seen, referer_first/last, is_bot, status ∈ new|ignored|resolved, redirect_id) and
`smart_404_log_daily` (key_hash, hit_date, hits). Update hooks `10101`–`10107` add the host-aware
`key_hash`, the daily table, backfill permissions, make created redirects language-neutral, re-resolve
their source paths, and backfill `search404_integration`.

## Overview log UI — `Smart404OverviewForm`

Route `smart_404.overview` (`/admin/reports/smart-404`, `view smart_404 log`). A `tableselect` of
records from `Smart404Repository::getPagedRecords()` (50/page, sorted hits desc then last_seen desc),
plus a **Filters** details element (path/host contains, status, min hits, hide bots) whose submit
handlers redirect with the filters as query args so the pager preserves them. Bulk actions
(`ignore`/`delete` need `manage smart_404 log`; `redirect` needs `create smart_404 redirects`) are
re-checked in `submitForm()` (throwing `AccessDeniedHttpException` otherwise), and selected ids are
intersected with the rendered `#options` to drop any forged or now-stale id. `redirect` stashes ids in
private tempstore (`bulk_redirect_ids`) and redirects to the bulk form. Per-row **Redirect**/**Ignore**
operations are `#type => operations` links; the Ignore link points at the CSRF-tokened
`smart_404.ignore_single` route (built via `#links` so the render pipeline resolves the token
placeholder). `$record->path` is rendered as a link **title** (escaped by the link generator); the
detail page and forms render it via `#plain_text`. Cache: `max-age = 0` with `user.permissions`,
`url.query_args`, `session` contexts.

![Smart 404 log overview](../../../../../../../screenshots/smart_404/1.2.x/log-overview.png)

## Detail page — `Smart404DetailController::detail()`

Route `smart_404.detail`. Shows a summary table (path via `#plain_text` in a `<code>` tag, host, hits,
first/last seen, status via `StatusLabel`, bot flag), a referers details block, a 30-day hit timeline
(`buildTimelineRows()` over `Smart404Repository::getDailyHits()`, timezone-aware via `DateBucket`), and
alias suggestions from `SuggestionEngine`. The title callback returns a `TranslatableMarkup`
(`@path` placeholder autoescaped). "Create redirect" / "Use this path" links appear only when the user
has `create smart_404 redirects`. `max-age = 0`.

## Ignore single — `Smart404IgnoreController::ignore()`

Route `smart_404.ignore_single`, a **GET** carrying `_csrf_token: 'TRUE'` and requiring both
`view smart_404 log` + `manage smart_404 log`. 404s on an unknown id, else
`Smart404Repository::bulkUpdateStatus([$id], 'ignored')` and redirects to the overview.

## Suggestion engine — `SuggestionEngine::getSuggestions()`

Extracts the last (then second-to-last) path segment, `LIKE`-matches `path_alias` (status = 1, up to
200 candidates), scores each by `levenshtein()` against the full path, sorts ascending, returns top-N.
The full scored list is cached per path for 1 hour (tag `smart_404_suggestions`), invalidated by the
`path_alias_insert/update/delete` hooks. Candidates are not entity-access-filtered by design: the cache
is keyed by path only, and both permissions that reach this code are `restrict access: true` (see the
class docblock and `permissions/permissions.md`).

## Redirect creation — `Smart404RedirectCreator`

`final` service shared by the single form (`Smart404RedirectForm`), the bulk form
(`Smart404BulkRedirectForm`, reads `bulk_redirect_ids` from tempstore, one row per record, per-row
skip), and the Drush `smart404:redirect` command.

- **`validate($sourcePath, $destination, $statusCode)`** returns `null` or an error code:
  `invalid_status_code` (not 301/302, `VALID_STATUS_CODES`), `invalid_destination`
  (`RedirectDestinationValidator::isValidInternalPath()` rejects it), `source_has_query_string`,
  `same_path` (source hash == destination hash via `Redirect::generateHash()`), `redirect_loop`
  (destination chains back through an existing redirect, checked with
  `RedirectRepository::findMatchingRedirect()`), or `source_resolves` (the raw source path currently
  matches a live route — checked with `PathValidator::getUrlIfValidWithoutAccessCheck()`, wrapped in
  try/catch that **fails closed**). Source and destination are run through inbound path processing
  (`resolveInboundPath()`) before comparison so multilingual/aliased paths match what a real request
  resolves to.
- **`create()`** re-validates (throws `LogicException` if invalid), creates a `redirect` entity
  (`redirect_source.path` = resolved source, `redirect_redirect.uri` = `internal:<destination>`,
  `status_code`, and `language` = `LANGCODE_NOT_SPECIFIED` — the langcode key is a field literally named
  `language`), saves it, and calls `Smart404Repository::markResolved()` to store `redirect_id` and set
  status `resolved`. Returns the redirect id.

**`RedirectDestinationValidator::isValidInternalPath()`** (open-redirect guard) requires a single
leading `/` (rejects `//`), rejects `\`, `://` anywhere, control characters, and `.`/`..` path
segments, then confirms with `Url::fromUserInput()`. This is why `create smart_404 redirects` can be
delegated without "administer redirects": destinations are always validated internal paths and 301/302
only.

## Services (`smart_404.services.yml`)

`smart_404.path_normalizer`, `smart_404.bot_detector`, `smart_404.repository`, `smart_404.logger`,
`smart_404.suggestion_engine`, `smart_404.redirect_creator`, `smart_404.subscriber`,
`logger.channel.smart_404`, and the autowired `Smart404Hooks`. Repository, suggestion engine, and
redirect creator also have class-name aliases for autowiring. `BotDetector` lazy-loads
`data/bot_patterns.yml` (case-insensitive substring match; returns `[]` on any read/parse error).
