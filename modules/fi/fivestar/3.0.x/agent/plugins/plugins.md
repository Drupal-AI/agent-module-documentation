<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fivestar plugins & render element

Fivestar does **not** define a plugin manager of its own; it provides standard Field API
plugins, a Form API element, and a lightweight "widget skin" registry driven by a hook.

## Field type

- `fivestar` (`FivestarItem`) — category `fivestar`. Columns `rating` (int 0–100) + `target`
  (int); main property `rating`. `default_widget: fivestar_stars`,
  `default_formatter: fivestar_stars`. On save (`postSave`) it writes a Voting API `vote` of
  the storage `vote_type`, deleting the user's previous vote first; with a voting target it
  also votes on the bridged entity. `isEmpty()` is true when `rating` is empty or `'-'`.

## Field widgets (form display)

- `fivestar_stars` (`StarsWidget`) — interactive star radios; settings `fivestar_widget`
  (skin, default `basic`), `display_format`, `text_format`. Renders a `#type => 'fivestar'`
  element. Voting on the edit form only happens when `rated_while = editing` (or on the field
  config form).
- `fivestar_select` (`SelectWidget`) — a plain `<select>` "Give N/M" list; accessible / no-JS.

Both extend `FivestarWidgetBase` (service `fivestar.widget_manager`, renderer). Legacy stored
skin values ending in `.css` are normalised by `getSelectedWidgetKey()`.

## Field formatters (view display)

- `fivestar_stars` (`StarsFormatter`) — interactive/average stars; builds a `FivestarForm`
  per item so viewers can vote inline (AJAX). Settings: `fivestar_widget`, `display_format`
  (`average`), `text_format` (`none`/`average`).
- `fivestar_percentage` (`PercentageFormatter`) — numeric percentage, e.g. `92`.
- `fivestar_rating` (`RatingFormatter`) — numeric rating out of stars, e.g. `4.2/5`.

## Form API element

- `#type => 'fivestar'` (`Element\Fivestar`) — a reusable rating control usable in any form.
  Key properties: `#stars` (5), `#allow_clear`, `#allow_revote`, `#allow_ownvote`,
  `#vote_type`, `#default_value` (0–100), `#widget` (`['name' => <skin>]`), `#settings`
  (`display_format`, `text_format`, `entity_type`, `entity_id`), `#show_static_result`.
  `userCanVote()` decides whether to render the interactive select or a static star display,
  honouring revote/ownvote rules and existing votes.

## Star skins ("widgets")

Skins are declared by `hook_fivestar_widgets()` and collected by `fivestar.widget_manager`.
Each entry is `key => ['label' => …, 'library' => 'module/library']`. Core ships:
`basic`, `craft`, `drupal`, `flames`, `hearts`, `lullabot`, `minimal`, `outline`, `oxygen`,
`small` (see `FivestarFivestarHooks`). Add or alter skins from your module —
see [../hooks/hooks.md](../hooks/hooks.md).

## Theme hooks (for custom output)

`fivestar_static` (static star display), `fivestar_static_element`, `fivestar_summary`
(user/average/count text), plus the formatter templates `fivestar_formatter_rating` and
`fivestar_formatter_percentage`. All registered in `FivestarRenderHooks::theme()`.
