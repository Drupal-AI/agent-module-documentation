<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config, permissions, admin, Views, Drush, REST, hooks

## Install / enable

`ddev drush en emoji_reactions -y`. Pulls in core `user`, `field`, `serialization`, `rest`.
`hook_install()` imports optional config (the log view) and shows a link to settings. Then add an
`emoji_reaction` field to an entity bundle (Manage Fields) and pick a layout per view-mode (Manage Display),
or place the **Emoji Reactions** block.

## Permissions (`emoji_reactions.permissions.yml`)

- `administer emoji reactions` (restricted) — settings, emoji management, log, all admin routes.
- `react with emojis` — authenticated reacting.
- `react as anonymous` — anonymous reacting (also gated per-field by `anonymous_allowed`).
- `view emoji reaction statistics` — statistics/reports pages + the `statistics` JSON route.
- `delete own reactions` — declared (users remove their own reaction by re-toggling it).

## Global settings — config object `emoji_reactions.settings`

Form `src/Form/GlobalSettingsForm.php` at route `emoji_reactions.settings`
(`/admin/config/content/emoji-reactions`, permission `administer emoji reactions`). Keys (defaults in
`config/install/emoji_reactions.settings.yml`, schema in `config/schema/emoji_reactions.schema.yml`):
`anonymous_reaction_window` (168h), `anonymous_tracking_method` (`both`), `flood_limit` (30/h; 0 disables),
`default_layout` (`pills`), `show_counts`, `show_labels`, `animate_on_react`, `tooltip_enabled`,
`realtime_updates`, `poll_interval` (15s), `allow_multiple_reactions` (false), `allow_reaction_change` (true).

## Emoji set — config entity `emoji_reaction`

`src/Entity/EmojiReaction.php`, `config_prefix: emoji_reaction`, `admin_permission: administer emoji
reactions`. Exported keys: `id`, `label`, `emoji`, `emoji_type` (unicode|image|svg), `image_url`, `svg_code`,
`weight`, `status`, `description`, `aria_label`. Six defaults ship in `config/install/`
(thumbs_up, heart, celebrate, sad, wow, angry). Managed at
`/admin/config/content/emoji-reactions/emojis` (`AdminController::emojiList`, list builder
`EmojiReactionListBuilder`), CRUD forms `EmojiReactionForm` / `EmojiReactionDeleteForm`.

## Admin pages (`src/Controller/`, all `administer emoji reactions` unless noted)

- Statistics `AdminController::statistics` — `/admin/reports/emoji-reactions`
  (`view emoji reaction statistics`); per-entity `entityStatistics` at `.../{type}/{id}`.
- Reaction log `ReactionLogController::log` — `/admin/reports/emoji-reactions/log`: filters, sort,
  pagination, detail (`detail`), single delete (confirm form `DeleteReactionForm`), bulk POST
  (`bulkAction`, CSRF token `emoji-reactions-bulk`; actions delete_selected/filtered/all), user autocomplete.
- Menu/task/action links in `emoji_reactions.links.*.yml`.

## Statistics service

`src/Service/StatisticsService.php` (`emoji_reactions.statistics_service`) — `getGlobalStats()`,
`getEntityStats()`, `getTopReacted()`, `getReactionsList()` (filtered/paged), `getReactionDetail()`,
`getBrowserOptions()` / `getOsOptions()`, `getUserSuggestions()`. Queries use placeholders / query builder /
`escapeLike()`.

## Views

`emoji_reactions.views.inc` (`hook_views_data` via `src/ViewsData/EmojiReactionsViewsData.php` +
`hook_views_data_alter` adding node/user relationships). Custom plugins in `src/Plugin/views/**` (emoji field,
entity link, operations, bulk form, date-range + emoji-id filters, bulk header/footer areas). Optional view
`config/optional/views.view.emoji_reactions_log.yml`.

## Drush (`src/Commands/EmojiReactionsCommands.php`)

- `emoji-reactions:rebuild-counts` (`er:rebuild`) — rebuild the counts cache.
- `emoji-reactions:stats` (`er:stats`) — print global stats.
- `emoji-reactions:delete-entity <type> <id>` (`er:delete-entity`) — delete an entity's reactions.

## Hooks (`emoji_reactions.api.php`)

`hook_emoji_reactions_react_alter(&$result, $context)`, `_display_alter(&$build, $context)`,
`_access($entity, $emoji_id, $operation, $account)`, `_log_fields()`, `_log_insert($reaction_id, $context)`,
`_count_alter(&$counts, $entity_type, $entity_id)`. Access handler `src/Access/EmojiReactionAccess.php`
(service `emoji_reactions.access`) exposes `checkAccess()` combining entity `view` + base permission + the
access hook.
