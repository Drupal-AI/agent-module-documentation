<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public output: page, feeds, JSON API & blocks

All public output loads only accessible, **published** releases via `PublicReleaseBuilder` (`accessCheck(TRUE)` + `->access('view')` + translation policy). Section item text is always rendered as escaped plain text — templates use Twig auto-escaping and feeds escape explicitly.

## Public page (`Controller\ChangelogController`)
- `changelogify.changelog` — listing at `changelog_path` (default `/changelog`), `_access: TRUE`. Paged (10), theme `changelogify_release_list` (template `templates/changelogify-release-list.html.twig`), attaches canonical + RSS/Atom discovery links.
- `changelogify.changelog_release` — `/{release_slug}` (slug regex `[a-z][a-z0-9-]{0,127}`), `_access: TRUE`. `resolveAccessible()` resolves via `ReleaseSlugManager` and throws 404 unless the release is view-accessible; historical slugs 301-redirect to the canonical slug. Theme `changelogify_release`.
- `changelogify.changelog_release_legacy` — numeric `/{id}` 301-redirects to the canonical slug (permission `view changelogify releases`).

## Feeds (`Controller\FeedController`)
- `changelogify.feed_rss` → `/…/feed.rss` (RSS 2.0), `changelogify.feed_atom` → `/…/feed.atom` (Atom 1.0). Both require `view changelogify releases`, load ≤20 releases, and are `CacheableResponse`s. Content is escaped with `htmlspecialchars` (`xml()`/`html()` helpers) after stripping XML-invalid characters.

## JSON API v1 (`Controller\ReleaseApiController`, read-only)
- `changelogify.api_v1_releases` → `/…/api/v1/releases` — bounded page: `limit` clamped 1–20 (default 10), `offset` 0–10000. Returns `{schema:"changelogify.release-list.v1", releases:[…], pagination}`.
- `changelogify.api_v1_release` → `/…/api/v1/releases/{release_slug}` — one release; 404 for unknown/historical/inaccessible.
- Both require `view changelogify releases`. `serialize()` emits only the documented contract (uuid, slug, url, title, version, language, release_date, coverage, sections). Responses are `CacheableJsonResponse`s with ETag/Last-Modified conditional-request support (`EventSubscriber\ApiEtagSubscriber` restores the representation-specific ETag).

## Blocks
- `Plugin\Block\LatestReleaseBlock` (`changelogify_latest_release`), `Plugin\Block\RecentReleasesBlock` (`changelogify_recent_releases`), base `ReleaseBlockBase`. Settings (schema-defined): `item_count`, `show_date`, `show_version`, `sections` toggles, `show_changelog_link`. Theme `changelogify_release_block` (`templates/changelogify-release-block.html.twig`).

Library `changelogify/public` (`changelogify.libraries.yml`, `css/changelogify.public.css`) is attached to public pages.
