<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Like (content_like) — agent index

info.yml name **"Content Like"**, description *"Provides AJAX like/unlike functionality for node
and custom block content with authenticated user and anonymous cookie support."* Installed
**1.0.0** (version dir `1.0.x`). Package `Content`. Core `^10 || ^11 || ^12`. License
GPL-2.0-or-later. **Not covered by the Drupal security advisory policy.** No `configure:` key in
info.yml, but a settings form exists (see below).

Adds a heart-style **like / unlike** control to rendered `node` and `block_content` entities.
Clicking it fires an AJAX POST that toggles the current visitor's like and returns the new count as
JSON; the widget updates in place without a page reload. Likes are stored in a dedicated
`content_like` table (one row per visitor+entity), not as field data or votes. Authenticated
visitors are keyed by user ID; anonymous visitors by a hashed random cookie value.

## Dependencies

`.info.yml` declares core `drupal:node` and `drupal:block_content`. JS library depends on
`core/jquery`, `core/drupal`, `core/once`. No third-party Composer/PHP libraries.

## Core mechanism (from source)

- **Widget injection** — `content_like_entity_view()` (`content_like.module`) appends a
  `#lazy_builder` placeholder (`content_like.lazy_builder:build`, `#create_placeholder => TRUE`,
  `#weight => 100`) to the build of any `node`/`block_content` whose bundle is enabled in config and
  which is not new. `content_like_is_enabled_for_entity()` / `content_like_get_enabled_bundles()`
  gate this against config `content_like.settings` keys `enabled_node_bundles` /
  `enabled_block_content_bundles`.
- **Lazy builder** — `ContentLikeLazyBuilder::build($entity_type, $entity_id)`
  (`src/ContentLikeLazyBuilder.php`, `TrustedCallbackInterface`) reads the like count and whether the
  current visitor has liked, then renders an `inline_template` (`.content-like-widget` wrapper with
  `data-content-like-url` = the toggle route, a `role="button"` trigger, a Font Awesome heart
  `<i>`, and a `.content-like-count` label). `#cache => ['max-age' => 0]`; attaches library
  `content_like/content_like`. Count/label passed via `#context` (Twig-autoescaped).
- **Toggle endpoint** — route `content_like.toggle`, path
  `/content-like/{entity_type}/{entity_id}/toggle`, **`methods: [POST]`**, requirement
  `_permission: 'access content'`, `entity_id: '\d+'`. Controller
  `ContentLikeController::toggle()` (`src/Controller/ContentLikeController.php`):
  1. `entity_type` must be `node` or `block_content` (else 404).
  2. Loads the entity via entity storage (`->load()`); missing → 404.
  3. Entity bundle must be in the configured enabled-bundles list (else 403).
  4. `$entity->access('view', $account)` must pass (else 403).
  5. For anonymous visitors, reads/creates the `content_like_anon_id` cookie; a missing cookie is
     minted from `bin2hex(random_bytes(32))` and set (1-year, path `/`, HttpOnly, SameSite=Lax,
     Secure=FALSE).
  6. Calls `LikeRepository::toggleCurrentVisitorLike()` then `countForEntity()`, clears output
     buffers, and returns `JsonResponse {liked: bool, count: int, count_text: "N Like(s)"}` with
     `Cache-Control: no-store…` and `X-Content-Type-Options: nosniff`.
- **Repository** — `LikeRepository` (`src/LikeRepository.php`, service `content_like.repository`,
  args `@database @current_user @request_stack`). All DB access via the query builder with
  `->condition()` (parameterized; no string-concatenated SQL). Visitor identity
  (`getCurrentVisitorIdentity()`): authenticated → `liker_type='user'`, `liker_id`=uid; anonymous →
  `liker_type='anonymous'`, `liker_id`/`anonymous_id_hash` = `sha256(cookie_value)` (raw cookie value
  never stored). `toggleCurrentVisitorLike()` deletes the visitor's own row if present, else inserts
  one; a duplicate-race `IntegrityConstraintViolationException` is swallowed (the unique key protects
  it). `createAnonymousId()` = `bin2hex(random_bytes(32))`.
- **JS** — `js/content_like.js` (`Drupal.behaviors.contentLike`): delegated click/keypress (Enter/Space)
  on `.content-like-trigger`, guards against double-submit with `is-processing`, jQuery `POST` (empty
  body) to the widget's `data-content-like-url`, parses the JSON (tolerantly, by slicing to the first
  `{`…last `}`), and swaps the heart classes + count text.

## Storage (from source)

`content_like_schema()` (`content_like.install`) — table **`content_like`**: `id` (serial PK),
`entity_type` (varchar 64), `entity_id` (int unsigned), `liker_type` (varchar 16, user|anonymous),
`liker_id` (varchar 128, uid or hashed cookie), `uid` (int, 0 for anon), `anonymous_id_hash`
(varchar 128), `created` (int). **Unique key `unique_like`** on
`(entity_type, entity_id, liker_type, liker_id)` — one like per visitor per entity. Indexes:
`entity_count (entity_type, entity_id)`, `uid`.

## Admin UI (from source)

Settings form `ContentLikeSettingsForm` (`ConfigFormBase`) at
`/admin/config/content/content-like` (route `content_like.settings`, menu link under
`system.admin_config_content`), requirement `_permission: 'administer content like settings'` — the
module's only defined permission (`content_like.permissions.yml`). Two checkbox groups
(`enabled_node_bundles`, `enabled_block_content_bundles`) built from
`entity_type.bundle.info`; submit filters empties, writes config `content_like.settings`, and calls
`drupal_flush_all_caches()`. Config schema `content_like.schema.yml` (two `sequence` of `string`).

## Notes / gotchas

- The widget is shown for **all** enabled-bundle entities whenever their render array is printed; it
  is not controlled from Manage Display (the settings form says as much). To place it manually in a
  custom template: `{% if content.content_like is defined %}{{ content.content_like }}{% endif %}`.
- Count/state are rendered with `#cache => max-age 0` (per-visitor liked state), so the widget is
  uncacheable; heavy pages will always re-run the lazy builder's two queries.
- README.txt is a single-line placeholder; the substantive prose lives in the drupal.org project page
  (mirrored in `data.json`).
- Font Awesome classes (`fa-heart`) are assumed present in the theme; the module ships only its own
  CSS (`css/content_like.css`), not the icon font.

## Related docs

- Human setup walkthrough → [`../human-docs/index.md`](../human-docs/index.md)
- Short prose summary / keywords → [`../usage.md`](../usage.md)
