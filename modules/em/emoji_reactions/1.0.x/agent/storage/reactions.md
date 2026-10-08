<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How reactions are stored

Reactions are **not** entities — they live in three plain tables declared by `emoji_reactions_schema()` in
`emoji_reactions.install`, and all access goes through `src/Service/ReactionManager.php`
(service `emoji_reactions.reaction_manager`).

## Tables

- **`emoji_reactions`** — one row per reaction event: `id` (serial), `entity_type`, `entity_id`,
  `field_name`, `emoji_id`, `uid` (0 = anonymous), `ip_hash`, `session_hash`, `ip_display` (masked),
  `browser`, `browser_version`, `os`, `device_type` (0 desktop / 1 mobile / 2 tablet), `language`, `created`,
  `updated`. Indexed by entity, user, emoji, ip and created.
- **`emoji_reactions_counts`** — aggregated cache: PK (`entity_type`,`entity_id`,`field_name`,`emoji_id`) +
  `count`, `updated`. Maintained atomically via `merge()` / `GREATEST(0, count - :dec)` expressions.
- **`emoji_reactions_extra`** — optional per-reaction custom fields (PK `reaction_id`+`field_name`,
  `field_value` serialized), written by `saveExtraFields()` / read by `getExtraFields()`.

## ReactionManager::react()

Constructor args: `@database`, `@current_user`, `@request_stack`, `@entity_type.manager`, `@config.factory`,
`@cache.emoji_reactions`, `@logger.channel.emoji_reactions`, `@flood`, `@emoji_reactions.ua_parser`,
`@module_handler`, `@datetime.time`, `@private_key`.

1. Flood check via `flood->isAllowed('emoji_reactions_react', flood_limit, 3600, id)` — id is `uid:N` for
   authenticated users, else `ip:…` (throws `\RuntimeException` when over limit).
2. Loads the `emoji_reaction` config entity for `emoji_id`; must exist and be enabled.
3. Computes anonymous identifiers `getAnonymousIdentifiers()` = `hash_hmac('sha256', ip|sessionId,
   privateKey)`.
4. `findExistingReactions()` uses the configured `anonymous_tracking_method` (`ip` | `session` | `both`) for
   anon, or `uid` for authenticated.
5. Toggle logic: same emoji already reacted → **remove**; else if `allow_multiple_reactions` → **add** a
   second; else if `allow_reaction_change` → **change** (remove old, add new); else (single + no change) →
   only add when none exists. Each add/remove keeps `emoji_reactions_counts` in sync.
6. Registers the flood event, invalidates cache tags `emoji_reactions:{type}:{id}` and `emoji_reactions:all`,
   returns `{action, counts, user_reactions, emoji_id}` and invokes `hook_emoji_reactions_react_alter()`.

`insertReaction()` collects analytics from `UserAgentParser::parseCurrentRequest()`
(`src/Service/UserAgentParser.php`) and fires `hook_emoji_reactions_log_insert()`.

## Reads & deletion

- `getCounts()` — cached per `counts:{type}:{id}:{field}` (PERMANENT with entity tag); `getUserReactions()`
  — emoji ids the current user/anon has set.
- `deleteReaction(id)`, `bulkDeleteReactions(ids)`, `deleteEntityReactions(type,id)`, `deleteAllReactions()`,
  `rebuildCountsCache()` (recomputes counts from raw rows; also run by Drush / cron).
- `hook_entity_delete()` removes an entity's reactions; `hook_user_delete()` anonymises rows to `uid = 0`;
  `hook_cron()` prunes expired anonymous rows past `anonymous_reaction_window` hours and rebuilds counts.
- `ReactionCacheSubscriber` (`src/EventSubscriber/`) invalidates render cache tags on entity updates.
