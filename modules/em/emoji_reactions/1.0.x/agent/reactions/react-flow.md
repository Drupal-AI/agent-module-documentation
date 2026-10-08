<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How a user reacts (AJAX endpoints)

Front-end JS (`js/emoji-reactions.js`, library `emoji_reactions/reactions`) drives three routes defined in
`emoji_reactions.routing.yml` and handled by `src/Controller/ReactionController.php`.

## The two-step token + react flow

1. **`emoji_reactions.token`** — `GET /emoji-reactions/token` → `ReactionController::token()`. Starts the
   session if needed and returns the CSRF token for the value `emoji-reactions` as `text/plain` (no-store
   headers). Route is `_access: TRUE`; the token itself is the gate.
2. **`emoji_reactions.react`** — `POST /emoji-reactions/react` → `ReactionController::react()`. Route is
   `methods: [POST]`, `_access: TRUE`, `no_cache`. Access is enforced inside the controller.

`react()` order of operations:
- Rejects non-POST (405). Starts session.
- Reads header `X-CSRF-Token`; requires `csrfToken->validate($token, 'emoji-reactions')` (403 on fail).
- JSON body → `entity_type`, `entity_id`, `field_name`, `emoji_id`; each string is run through
  `sanitize()` = `preg_replace('/[^a-zA-Z0-9_\-]/', '', …)`, `entity_id` cast to int. Missing → 400.
- Permission: `react with emojis`, OR (anonymous AND `react as anonymous`); else 403 with `require_login`.
- `entityTypeManager()->hasDefinition($entityType)` (400), storage load (404 if missing),
  `$entity->access('view')` (403).
- Per-entity gate `isFieldEnabledForEntity()` reads the field item's `enabled` column (403 if the editor
  unchecked reactions for that entity).
- Delegates to `ReactionManager::react()` (see [../storage/reactions.md](../storage/reactions.md)); returns
  JSON `{success, action: added|removed|changed, counts, user_reactions, emoji_id, message}`. A
  `\RuntimeException` (flood / invalid emoji) → 429; other errors logged → 500.

## Read-only endpoints

- **`emoji_reactions.counts`** — `GET /emoji-reactions/counts/{entity_type}/{entity_id}/{field_name}` →
  `counts()`. `_access: TRUE` (counts are public); sanitises args, validates entity type, returns
  `{counts, timestamp}` with a 5-second public max-age.
- **`emoji_reactions.statistics`** — `GET /emoji-reactions/statistics/{entity_type}/{entity_id}` →
  `statistics()`. Requires permission `view emoji reaction statistics` (route `_permission` and re-checked in
  the method), plus entity `view` access; returns `StatisticsService::getEntityStats()`.

## REST equivalents

`src/Plugin/rest/resource/`:
- `EmojiReactResource` (`emoji_react_resource`, `POST /api/emoji-reactions/react`) — same permission +
  entity-type-registry + entity `view` checks, then `ReactionManager::react()`. Uses core REST auth/CSRF.
- `EmojiReactionsDataResource` (`emoji_reactions_data_resource`,
  `GET /api/emoji-reactions/entity/{type}/{id}/{field}`) — validates + `view`-gates the entity, returns all
  enabled emoji with counts, the current user's reactions, the layout list and endpoint URLs.

Enable REST resources at `/admin/config/services/rest` (or via config). `hook_page_attachments()` publishes
the token/react/counts endpoint URLs and poll settings to `drupalSettings.emojiReactions` when
`realtime_updates` is on.
