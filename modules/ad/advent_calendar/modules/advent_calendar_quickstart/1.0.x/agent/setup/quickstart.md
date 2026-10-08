<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scaffolding an advent calendar with Quickstart

## Install & enable

```bash
drush en advent_calendar_quickstart -y
```

Enabling it pulls in `advent_calendar` and the core deps (node, taxonomy, field_ui, image, link, menu_ui,
views_ui, path, text) and installs the optional config below.

## What the install hook does (`advent_calendar_quickstart_install($is_syncing)`)

1. Looks up (or creates) a `year` taxonomy term named `date("Y")`.
2. Builds a positions array — `range(1, 23)` shuffled, then `24` pushed on — so doors 1–23 get randomised
   on-screen positions and day 24 is last.
3. For each of 24 days: if no `advent_calendar_door` node already exists for that `field_year` + `field_day`,
   creates one with:
   - `title` = "Advent Calendar day N", `field_brief_title` = "Candle",
   - `field_day` = N, `field_year` = the year term, `field_position` = shuffled position,
   - `field_door_image` = a managed file created once from `images/candle.png`
     (`file.repository`→`writeData(..., 'public://candle.png', FileExists::Rename)`, via `DeprecationHelper` for
     10.x/11.x compatibility),
   - **`status` = 0 (unpublished)**.

Because it checks for existing day/year nodes first, re-running (or reinstalling next year with a new current
year) only creates what's missing.

## Config installed (`config/optional/`)

- `node.type.advent_calendar_door` (+ `core.entity_form_display.*` and `core.entity_view_display.*.default` /
  `.teaser`).
- Field storage + instance config: `field_day`, `field_year`, `field_position`, `field_brief_title`,
  `field_door_image`, `field_image`, `field_tags`, and core `body`.
- `taxonomy.vocabulary.tags`, `taxonomy.vocabulary.year`.
- `views.view.advent_calendar` — a View of `advent_calendar_door` nodes using the
  `advent_calendar_advent_calendar` style, access `perm: 'access content'`, with a `status` field mapped to the
  door's `unlocked` prop.

## Operating it

1. Enable the submodule; 24 unpublished door nodes and the View appear.
2. Edit each node to replace the placeholder candle image/title with real content.
3. Publish each day's node on its date — manually, or with a scheduling module (Scheduler / Scheduled Publish).
   Until a node is published its door renders closed and is not clickable.
4. Uninstall the submodule when done (optional) — the created content type, nodes and View remain.

The View is public (`access content`); each door links to its node's page, which is subject to standard entity
view access, so unpublished days are not reachable by non-privileged visitors.
