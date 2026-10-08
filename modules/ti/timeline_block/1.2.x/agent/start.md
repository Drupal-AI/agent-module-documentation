<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Timeline Block (timeline_block) — agent index

One placeable **block plugin** (id `timeline_block`, admin label "Timeline Block") that renders
editor-entered events as a chronological timeline. Version **1.2.5**, core `^9 || ^10 || ^11`.
Info file declares only core `block`; at runtime it also uses core `file`, `editor` and `filter`.

## What it actually is
- A `BlockBase` plugin at `src/Plugin/Block/TimelineBlock.php` — **not** a Views style, field
  formatter, or entity type. The events live in the **block's own configuration**, serialised as
  JSON, not in content.
- `blockForm()` builds the config UI: a rich-text **Timeline header** (`text_format`), a fieldset of
  **timeline items** added/removed by AJAX buttons, and a **Timeline layout** select (`1`–`10`).
- Each item = **Title** (`textfield`), **Time** (`textfield`), **Description** (`text_format`,
  default `basic_html`), **weight** (`number`, 1–120).
- `blockSubmit()` sorts items by weight (`usort`), drops items with an empty description, and stores
  three config keys: `timeline_data` (JSON array), `timeline_header`, `timeline_layout`.
- `build()` renders the header and each description with `#type => processed_text` (so they pass
  through their stored text format), then hands data to the `timeline_block` theme hook.
- `templates/timeline-block.html.twig` contains the markup for **all 10 layouts** and branches on
  `timeline_settings.timeline_layout`. Styling is one theme CSS library, `css/timeline.css`.
  **No JavaScript, no CDN, no external library.**

## Files
- `timeline_block.info.yml` — dependency: `drupal:block`; `core_version_requirement: ^9 || ^10 || ^11`.
- `timeline_block.libraries.yml` — one library `timeline_block` = `css/timeline.css` only.
- `timeline_block.module` — `hook_help`, `hook_theme` (`timeline_block`), `hook_theme` variables
  (`timeline_data`, `timeline_settings`, `timeline_header`, `timeline_layout`), plus embedded-image
  file lifecycle helpers (`_editor_parse_file_uuids`, mark permanent/temporary, file usage).
- `src/Plugin/Block/TimelineBlock.php` — the block plugin.
- `templates/timeline-block.html.twig` — 10 layouts.
- `css/timeline.css` — layout styling.

## Facts worth knowing before advising
- **Content-in-configuration.** Items are edited only in the block form and are invisible to search,
  translation and editorial workflow. A timeline that must stay current from dated content is a poor
  fit — a Views-based timeline would inherit filtering/access/language. State this honestly.
- **No config schema ships** (there is no `config/schema/*.yml`); block config is stored without a
  typed schema.
- **Placement / editing is gated by "administer blocks"** (or Layout Builder layout permissions for
  an inline instance). There is no module-specific permission.
- **10 layouts are CSS-only**; "custom JS / carousel" is only possible by overriding the template in
  a theme. The README's mention of JavaScript refers to that override path, not shipped behaviour.

## Solution types
- `blocks/timeline-block.md` — the block plugin: config model, item storage, rendering, layouts.
