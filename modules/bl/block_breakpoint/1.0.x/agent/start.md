<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Breakpoint (block_breakpoint) — agent index

Adds a per-block third-party setting that binds a block to one or more responsive **breakpoints**;
at render time it attaches a media query + JS that **removes the block from the browser DOM** when
the query does not match. Package `User interface`. Depends on core **`breakpoint`** and **`block`**.
Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha7. No permissions, no
Drush, no routes, no config entity — it stores everything on the host block's third-party settings.

- **How it hooks the form, stores settings, builds the media query, and hides blocks (Block UI +
  Layout Builder), plus manual Twig usage** → [config/breakpoint-visibility.md](config/breakpoint-visibility.md)

## What it actually is (from source)

- **One service** `block_breakpoint.manager` → `BlockBreakpointManager` (`src/BlockBreakpointManager.php`),
  args `@config.factory`, `@entity_type.manager`, `@breakpoint.manager`. Holds all logic.
- **One event subscriber** `BlockComponentRenderArray`
  (`src/EventSubscriber/BlockComponentRenderArray.php`) on Layout Builder's
  `SECTION_COMPONENT_BUILD_RENDER_ARRAY` — copies the component's `block_breakpoint` third-party
  settings onto the build as `#block_breakpoint` (guarded by `class_exists()` so LB is optional).
- **Hooks** in `block_breakpoint.module`: `hook_theme` (registers `block_breakpoint_inline_match`),
  `hook_form_block_form_alter` + `hook_form_layout_builder_configure_block_alter` (inject the form),
  `hook_preprocess_block` and `hook_preprocess_layout` (attach markup/library at render).
- **Config schema** `config/schema/block_breakpoint.schema.yml`: `block.block.*.third_party.block_breakpoint`
  = `enabled` (bool), `breakpoint_group` (string), `breakpoints` (sequence of `{breakpoint_id}`).
- **Assets**: library `block_breakpoint/block_breakpoint` (`js/block-breakpoint.js`, header) and
  template `templates/block-breakpoint-inline-match.html.twig`.

## Mechanism in one paragraph

Form alter adds an **Enable Block Breakpoint** checkbox, a **breakpoint group** select (AJAX callback
`updateBreakpointOptions`, default = default theme's group) and a multi-select of **breakpoints**.
On submit, `entityBuilder`/`componentSubmit` → `storeThirdPartySettings()` writes `enabled`,
`breakpoint_group` and a `breakpoints` sequence (or unsets them). At render, `preprocessBlock()` /
`preprocessComponent()` add class `block-breakpoint`, attach the library, set
`data-block-breakpoint-media-query` (`buildMediaQueryFromBreakpoints()` = comma-joined
`getMediaQuery()` of the selected breakpoints), and append the inline-match script element. The JS
runs `window.matchMedia(query)` and `removeChild()`s the block when it does not match; a
`MutationObserver` + `DOMContentLoaded` rechecks AJAX/BigPipe-added blocks.

## Notes

- Purely **client-side visibility** (its goal is accurate ad-impression counting): the block is
  rendered into the initial HTML server-side and only removed in the browser. It is a presentation
  feature, **not** access control — the block's own access rules still apply and gate the content.
- Media queries come from breakpoint YAML definitions (theme/module config), not free-text admin
  input. Layout Builder support relies on a core patch (see README) for component third-party settings.
