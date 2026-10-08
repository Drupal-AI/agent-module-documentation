<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emoji Reactions (emoji_reactions) — agent index

Per-entity emoji reaction system. Ships an `emoji_reaction` **field type** (attach via Manage Fields to any
fieldable entity) plus an `emoji_reaction` **config entity** for the emoji set. Users toggle reactions over
AJAX; counts update live. Package `Content`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir 1.0.x
(installed 1.0.3). Depends on core `user`, `field`, `serialization`, `rest`.

## What it provides (from source)

- **Config entity** `emoji_reaction` (`src/Entity/EmojiReaction.php`) — one per emoji; `emoji_type` = unicode |
  image | svg. 6 defaults in `config/install/`. Admin at `/admin/config/content/emoji-reactions/emojis`.
- **Field**: type `emoji_reaction` (`EmojiReactionItem`, single `enabled` per-entity toggle), widget
  `emoji_reaction_widget`, formatter `emoji_reaction_pills` (`EmojiReactionFormatter`, 23 layouts). Category
  `interactive`.
- **Block** `emoji_reactions_block` (`EmojiReactionsBlock`) — reactions for the current-route entity.
- **AJAX routes** (`emoji_reactions.routing.yml`): `token`, `react` (POST), `counts`, `statistics`; admin
  settings/emoji-list/statistics/log/bulk/autocomplete. Controllers in `src/Controller/`.
- **REST resources**: `emoji_react_resource` (POST `/api/emoji-reactions/react`) and
  `emoji_reactions_data_resource` (GET `/api/emoji-reactions/entity/{type}/{id}/{field}`).
- **Services** (`emoji_reactions.services.yml`): `reaction_manager`, `statistics_service`, `ua_parser`,
  `access`, `views_data`, `reaction_cache_subscriber`, own cache bin + logger channel.
- **Storage**: 3 non-entity tables (`emoji_reactions`, `emoji_reactions_counts`, `emoji_reactions_extra`) —
  `emoji_reactions.install`.
- **Views** integration (`emoji_reactions.views.inc` + `src/ViewsData/` + `src/Plugin/views/**`), optional log
  view `config/optional/views.view.emoji_reactions_log.yml`.
- **Drush** commands (`EmojiReactionsCommands`): rebuild-counts, stats, delete-entity.
- **5 permissions** (`emoji_reactions.permissions.yml`) and 6 alter/access **hooks** (`emoji_reactions.api.php`).

## Solution docs

- **How a user reacts** — AJAX token + `react` endpoint, CSRF, permissions, entity gating →
  [reactions/react-flow.md](reactions/react-flow.md)
- **How reactions are stored** — tables, `ReactionManager`, dedup, counts, deletion →
  [storage/reactions.md](storage/reactions.md)
- **How counts render** — field type/widget/formatter, block, layouts, theme →
  [display/formatter-block.md](display/formatter-block.md)
- **Config, permissions, admin, Views, Drush, REST, hooks** →
  [config/settings.md](config/settings.md)
