<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Like & Dislike (like_and_dislike) — agent index

Adds two separate Voting API vote types ("like" and "dislike") as a thumbs-up/down widget on any
content entity type/bundle you enable. A permitted user clicks a thumb; an AJAX POST records or
cancels the vote through Voting API and the tallies refresh in place (likes and dislikes are
mutually exclusive — casting one removes the opposite). Core `^10.1 || ^11`. Requires
`votingapi` (`drupal/votingapi:^3.0`). Settings page: route `like_and_dislike.admin_settings`
(`/admin/config/search/votingapi/like_and_dislike`).

Defines permissions (one static + dynamic per enabled type/bundle), config schema, a Views field,
and a theme hook. No Drush commands, no plugin types of its own.

- **Enable widgets per entity type/bundle + the four settings** → [configure/settings.md](configure/settings.md)
- **Static + dynamic vote permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Vote route, controller, service and helper functions (the API)** → [api/services.md](api/services.md)
- **Hooks it implements (display component, opposite-vote removal, views data, theme)** → [hooks/hooks.md](hooks/hooks.md)
- **The Views field** → [views/field.md](views/field.md)

Key facts:
- Config object `like_and_dislike.settings`: `enabled_types` (map `entity_type_id` → list of bundles;
  empty list = whole type), `allow_cancel_vote` (bool, default TRUE), `check_vote_init`
  (bool, default TRUE), `hide_vote_widget` (bool, default FALSE).
- Service `like_and_dislike.vote_builder` → `Drupal\like_and_dislike\LikeDislikeVoteBuilder`
  (lazy builder `build($entity_type_id, $entity_id)`).
- Vote route `like_and_dislike.vote` → `/like_and_dislike/{entity_type_id}/{vote_type_id}/{entity_id}`
  → `VoteController::vote()`; custom access `VoteController::voteAccess()`.
- Static permission `administer like and dislike`; dynamic permissions
  `add or remove {like|dislike} votes on {entity_type_id}` and
  `add or remove {like|dislike} votes on {bundle} of {entity_type_id}`.
- Installs Voting API vote types `like` and `dislike` (both `value_type: points`).
- Procedural helpers in `.module`: `like_and_dislike_is_enabled()`, `like_and_dislike_get_votes()`,
  `like_and_dislike_can_vote()`.
- Views field id `like_and_dislike`; theme hook `like_and_dislike_icons`; libraries
  `like_and_dislike/icons` and `like_and_dislike/behavior`.
