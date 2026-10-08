<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How reactions render (field, formatter, block)

## The field

`src/Plugin/Field/FieldType/EmojiReactionItem.php` — field type `emoji_reaction`, category `interactive`,
`cardinality = 1`, `default_widget = emoji_reaction_widget`, `default_formatter = emoji_reaction_pills`. Its
schema is a single tiny-int `enabled` column (per-entity on/off toggle). `isEmpty()` returns FALSE on purpose
so the row is always persisted (so `enabled = 0` sticks). `defaultFieldSettings()` adds the one field-level
setting `anonymous_allowed`. `fieldSettingsForm()` shows only that checkbox plus a notice pointing editors to
Manage Display. Helper `isEnabled()` treats NULL/'' as enabled.

`src/Plugin/Field/FieldWidget/EmojiReactionWidget.php` (`emoji_reaction_widget`) renders just the "Enable
emoji reactions for this entity" checkbox; `massageFormValues()` normalises it to int 0/1.

## The formatter (all display config lives here)

`src/Plugin/Field/FieldFormatter/EmojiReactionFormatter.php` (`emoji_reaction_pills`). `const LAYOUTS` is the
authoritative list of **23 layouts** (10 core, 5 stylised, 8 social — `SOCIAL_LAYOUTS`). `defaultSettings()`:
`layout`, `size`, `color_scheme`, `show_counts`, `show_labels`, `show_total`, `animate_on_react`,
`tooltip_enabled`, `placeholder_text`, `reaction_label`, `allowed_emojis`. `settingsForm()` groups these into
four `details` fieldsets on Manage Display; `settingsSummary()` renders the compact summary.

`viewElements()`:
- Returns `[]` (hides the field) when the per-entity `enabled` flag is 0.
- Reads `anonymous_allowed` from the field definition to compute `can_react`.
- Loads enabled `emoji_reaction` config entities (sorted by weight), optionally filtered by `allowed_emojis`.
- Pulls `getCounts()` + `getUserReactions()` from `ReactionManager`; builds each emoji's `rendered` markup via
  `EmojiReaction::renderEmoji()`.
- Themes `emoji_reactions_widget` with data-attributes (`data-entity-type/-id`, `data-field-name`,
  `data-layout`, etc.); cache `max-age 0`, contexts `user`,`session`, tag `emoji_reactions:{type}:{id}`.
- Attaches `emoji_reactions/layouts_social` only for social layouts; fires
  `hook_emoji_reactions_display_alter()`.

`EmojiReaction::renderEmoji()` returns safe `Markup`: `unicode` → htmlspecialchars span; `image` →
`UrlHelper::filterBadProtocol()` + htmlspecialchars `<img>`; `svg` → `Xss::filter()` with a shape allowlist,
xlink/scheme stripping and `normalizeSvgRootElement()`.

## The block

`src/Plugin/Block/EmojiReactionsBlock.php` (`emoji_reactions_block`, category Content) resolves the entity
from the current route (`routeMatch->getParameter(entity_type)`) and renders the same
`emoji_reactions_widget` theme, reusing `EmojiReactionFormatter::LAYOUTS`. Config keys mirror the formatter
plus `entity_type` / `field_name`; schema `block.settings.emoji_reactions_block`. Cache max-age 60.

## Theme

`emoji_reactions_theme()` (in `emoji_reactions.module`) declares templates `emoji_reactions_widget`,
`_item`, `_summary`, `_admin_stats`, `_log_filter` (in `templates/`). Widget suggestions vary by layout and
entity type. CSS lives in `css/`; the client toggle/poll logic in `js/emoji-reactions.js`.
