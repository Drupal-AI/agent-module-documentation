<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Like! — enabling, settings & the count endpoint

## Install / enable

`drush en like -y`. Requires contrib `entity`, `cache_control_override`, `js_cookie` and core
`views` (Composer: `drupal/entity:^1`, `drupal/cache_control_override:^2`, `drupal/js_cookie:^1.0`).
Suggested (optional): `drupal/antibot` (auto-integrates) and `drupal/fontawesome` (heart icon).
On install, `config/install/like.settings.yml` and `config/install/views.view.likes.yml` are
imported.

## Two-step activation

1. **Choose entity types.** Visit `/admin/config/user-interface/like` (route `like.settings`,
   permission `administer like configuration`) and tick the content entity types to enable in
   *Enable the like button for the following entity types*. This writes
   `like.settings:enabled_entity_types`. On save, `SettingsForm::submitForm()` calls
   `entityFieldManager->clearCachedFieldDefinitions()` so the computed `likes` base field appears
   (or disappears) — see `like_entity_base_field_info()` in `like.module`, which only adds the
   field for entity types present in `enabled_entity_types`.
2. **Place the formatter.** On each bundle's *Manage display*, set the **Likes** field
   (formatter `like_default`) to a visible region. See [../fields/formatter.md](../fields/formatter.md).

Note: the settings form lists all `content`-group entity types (`getGroup() === 'content'`),
sorted by label, and removes `like` itself (you cannot like a like).

## Config object `like.settings`

Schema: `config/schema/like.schema.yml` (`like.settings` config_object). Defaults from
`config/install/like.settings.yml`:

| key | type | default | meaning |
|-----|------|---------|---------|
| `enabled_entity_types` | sequence of string | `{}` (none) | entity type ids that get a like button |
| `like_cookie_expiry_time` | integer | `31536000` (1 year) | lifetime, in **seconds**, of the anonymous `Drupal.visitor.like` cookie; also the max-age used in `time` cache mode |
| `cache_type` | string | `entity` | `entity` or `time` — how the count endpoint caches (below) |

The formatter's own settings (`default_state`, `liked_state`) are stored per view-display, schema
`field.formatter.settings.like_default` — documented in [../fields/formatter.md](../fields/formatter.md).

## Count endpoint & cache modes

Route `like.handler` → `GET /like/{entity_type}/{entity}`
(`LikeController::handler`, requirements `_permission: 'access content'` +
`_entity_access: 'entity.view'`, `entity: \d+`). It returns a `CacheableJsonResponse`
`{ "likes": <count> }` (the entity's computed `likes` value, defaulting to 0). `js/like.js` polls
this endpoint via an `IntersectionObserver` when a like widget scrolls into view, so counts stay
current under page caching. It is **read-only** — it never records a like.

Cache behaviour depends on `cache_type`:

- **`entity`** (default): the response is tagged with the target entity's cache tags. When a like
  is added/removed, `LikeHelper` invalidates those tags and resets the entity storage cache, so the
  count refreshes. Best for typical volumes.
- **`time`**: the response gets `max-age` and an `Expires` header equal to `like_cookie_expiry_time`
  seconds; the module recommends this for high-volume sites where per-entity invalidation is too
  chatty.

## Anonymous vs. authenticated bookkeeping

- **Authenticated**: a `like` row per (uid, entity); `userHasLiked()` queries the DB, so the toggle
  is deduplicated to one like per user per entity.
- **Anonymous**: like state is mirrored in the `Drupal.visitor.like` cookie (JSON keyed by entity
  type → list of ids), written with `setrawcookie(...)` and read back in `LikeHelper` /
  `LikeUserOrCookie`. `like_cookie_expiry_time` controls its lifetime. Installing **Antibot** is
  suggested to deter automated submissions on the like form.

## Admin Likes listing

The bundled view `likes` (`views.view.likes`) provides a page at `admin/content/like` (also the
entity `collection` link, surfaced as a local task via `like.links.task.yml`) listing recorded
likes with entity type/id, user and value columns plus operations. Access permission
`access like overview`.
