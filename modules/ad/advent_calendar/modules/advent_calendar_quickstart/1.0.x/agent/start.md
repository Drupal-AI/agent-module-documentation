<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advent Calendar Quickstart (advent_calendar_quickstart) — agent index

One-shot scaffolding submodule for **advent_calendar**. On install it creates the content type, a *Year*
vocabulary + current-year term, 24 unpublished door nodes, and a ready-made View. Package `Views`.
Depends on `advent_calendar` plus core `path, node, text, field_ui, image, link, taxonomy, menu_ui, views_ui`.
`php: 8.0`. Core `^10.1 || ^11`. License GPL-2.0-or-later. Version 1.0.0-beta6.

## What it provides

- **`hook_install()`** (`advent_calendar_quickstart.install`) — creates the *Year* term for `date("Y")` if
  absent, then loops 24 days (positions 1–23 shuffled + 24 appended) creating an `advent_calendar_door` node per
  day with `status => 0` (unpublished), referencing the year term and a shipped `images/candle.png` written to
  `public://candle.png`. Skips days that already exist.
- **Optional config** (`config/optional/`) installed on enable:
  - Content type `node.type.advent_calendar_door` + its fields (`field_day`, `field_year`, `field_position`,
    `field_brief_title`, `field_door_image`, `field_image`, `field_tags`, plus core `body`) and view/form
    displays.
  - Taxonomy vocabularies `tags` and `year`.
  - View `views.view.advent_calendar` using the Advent Calendar Views style.
- **Asset** `images/candle.png` — placeholder image referenced by every generated door node.

No routes, permissions, services, config schema or Drush of its own. It is safe to uninstall after it runs, and
reinstalling in a later year seeds that year's nodes.

## Solution docs

- Install behaviour, the scaffolded content type/vocabulary/View, and how to operate it →
  [setup/quickstart.md](setup/quickstart.md)
