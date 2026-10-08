<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prelinker configuration reference

All UI lives under `/admin/config/system/prelinker` (link "Prelinker" under
*Configuration › Development › Performance*, `base_route: system.performance_settings`).
Three sub-areas: the **Settings** form, the **Preconnect Domains** list, the **Preload Files** list.
Every route requires `_permission: 'administer'` (see start.md — effectively user 1 only).

## Preconnect Domain entities (`preconnect`)
Config entity, `config_prefix: preconnect`, exported keys: `id`, `label`, `domain`, `weight`, `visibility`.
- **domain** — host only, *without* scheme (`fonts.gstatic.com`, not `https://fonts.gstatic.com`).
  Emitted as `href="//<domain>"` (protocol-relative) in head mode, `<//<domain>>` in header mode.
- **weight** — drag-orderable; entries are loaded `sort('weight', 'ASC')`.
- **visibility** — condition plugins (see below).

## Preload File entities (`preload`)
Config entity, `config_prefix: preload`, exported keys: `id`, `label`, `file`, `as`, `fetchpriority`, `weight`, `visibility`.
- **file** — full URL/path of the resource to preload.
- **as** — resource type; select limited to: `audio`, `document`, `embed`, `fetch`, `font`,
  `image`, `object`, `script`, `style`, `track`, `worker`, `video` (validated server-side).
  When `as = font`, `crossorigin` is added automatically (fonts must be fetched anonymously).
- **fetchpriority** — optional (`high` / `low` / `auto`); omitted when blank. New in 3.x.
- **weight**, **visibility** — as above.

## Settings (`prelinker.settings`) — all default OFF
`<head>` group (emitted by `hook_page_attachments()` as `<link>` elements):
- `preconnect_head` — emit preconnect domains as `<link rel="preconnect">`.
- `preload_head` — emit preload files as `<link rel="preload">`.
- `preload_head_image` — scan HTML for `data-preload-image="..."` and inject
  `<link rel="preload" as="image">` into `<head>`.

HTTP/2 push (`Link:` response header) group — handled by `src/Render/HeaderProcessor.php`:
- `preconnect_push` — preconnect domains as `Link:` headers. **Suppressed when `preconnect_head` is on**
  (`preconnect_push && !preconnect_head`) — head mode wins; the two are mutually exclusive per type.
- `preload_push` — preload files as `Link:` headers (suppressed when `preload_head` is on).
- `preload_push_image` — scan HTML for `data-preload-image` and push as `rel=preload; as=image` headers.
- `preload_push_css` — scan for `<link rel="stylesheet">` and CSS `@import url(...)` in
  `media="all"`/`media="screen"` blocks; push as `rel=preload; as=style`.
- `preload_push_preload` — lift existing `<link rel="preload">` tags into headers.
- `preload_push_preconnect` — lift existing `<link rel="preconnect">` tags into headers.

Notes:
- **Head vs header are independent toggles per hint type**, except that enabling head mode disables the
  corresponding push mode for the *manually configured* entities (above). The scan-based push options
  (`preload_push_image/css/preload/preconnect`) are unconditional when checked.
- **Admin routes are always skipped** (`router.admin_context->isAdminRoute()`) in both delivery paths.
- Emitted `Link:` headers are merged with any existing `Link` header and de-duplicated (`array_unique`).

## Visibility conditions
Each entity stores a `visibility` sequence of core **condition plugins**. Forms build the sub-forms from
`ConditionManager::getFilteredDefinitions('prelinker', $contexts)`. Common ones: `request_path`
(path patterns), `node_type` (content type), `language` (only shown when the site is multilingual),
`current_theme`. Evaluation:
- **Head mode** (`prelinker.module` `_prelinker_check_visibility()`) resolves each condition with manual
  context mapping; any failing condition hides the hint.
- **Header mode** (`HeaderProcessor::checkVisibility()`) uses `ConditionAccessResolverTrait::resolveConditions(..., 'and')`.
- No conditions configured ⇒ the hint shows on all non-admin pages.
The `current_theme` condition is special-cased: if it equals the site default theme it is *not* stored
(treated as "no restriction").

## Caveats / gotchas
- **Budget, not bonus.** Every preconnect keeps a socket open; every preload competes for bandwidth.
  Keep the total small (roughly 4–5) or hints become a net regression.
- **`domain` without scheme** — a value with `https://` produces a malformed `href="//https://..."`.
- Resource hints are only added on cacheable, non-admin HTML responses; the config object and each
  entity/condition are registered as cache dependencies so the page cache invalidates when they change.
- The 2.x per-hint `pages` textarea is gone; `prelinker_update_10001()` migrates it to a `request_path`
  condition. `src/Service/Prelinker.php` (path/alias/page matching) survives from that era but is not on
  the 3.x emission path.
