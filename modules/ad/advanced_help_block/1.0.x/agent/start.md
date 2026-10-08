<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Help Block (advanced_help_block) — agent index

Editorial **help notices scoped to chosen pages**, stored as fielded content entities and rendered
through **Drupal core's Help block**. From the **YMCA Website Services / Open Y** distribution.
Version **1.0.8**, core `^9 || ^10 || ^11`.

## What it actually is

- A **content entity type** `advanced_help_block` (base table `advanced_help_block`), not a block
  plugin. There is **no `Plugin/Block` class in this module.**
- Each entity carries: **`field_ahb_title`** (string), **`field_ahb_description`**
  (`text_long`, rich text through a **text format**), **`field_ahb_video`** (a YouTube URL string),
  **`field_ahb_pages`** (comma-separated path patterns, `*` wildcard, `<front>`), and
  **`field_ahb_visibility`** (`include` = show on listed pages / `exclude` = hide on listed pages).
- **Display mechanism:** the module implements **`hook_help()`**. On each request it entity-queries
  *all* help-block entities, keeps the ones whose `field_ahb_pages` / `field_ahb_visibility` match
  the current path, and returns a render array (theme `advanced_help_block_list_render`). That output
  is surfaced by **core's "Help" block** — so to see anything you must **place the core Help block**
  in a region. Setting `Output as: Message` (settings form) instead pushes the items as
  `\Drupal::messenger()` status messages.
- The description is rendered with **`check_markup($value, $format)`** — filtered by the stored text
  format, then printed in Twig. The title is Twig-autoescaped. The YouTube URL becomes a
  `Link`/`Url::fromUri` "Watch video" button that opens the **grt-youtube-popup** modal (external JS
  library loaded from `/libraries` via the `libraries` module).
- Front-end behaviour (`library/js/ahb.js`): each notice has a **Show more/less** toggle and a
  **close (×)** button; dismissals are remembered per visitor in the **`AHB_hidden` cookie**.

## Admin surface

- Listing (a View): `/admin/advanced_help_block/list` — also under Structure.
- Add / edit / delete: `/admin/advanced_help_block/add`, `/admin/advanced_help_block/{id}/edit`,
  `/admin/advanced_help_block/{id}/delete`.
- Settings (block vs message output): `admin/structure/advanced_help_block`.
- Fieldable via Field UI (base route is the settings form).

## Permissions (all in `advanced_help_block.permissions.yml`)

`view` / `add` / `edit` / `delete advanced_help_block entity` are **separate**, plus
`administer advanced_help_block entity` (restricted; gates the listing View and the settings form).
The view/add/edit/delete split is the right one — authoring guidance is editorial and should not
require block-administration rights.

## Dependencies worth noting

Depends on **`datalayer`** (a tracking-adjacent module) and **`libraries`** + the external
**grt-youtube-popup** asset in `/libraries`. Both are inherited from the Open Y distribution; expect
to satisfy them manually if you install this standalone. The bundled View still declares
`core_version_requirement: ^8 || ^9`, which is stale relative to the module's `^9 || ^10 || ^11`.

## Operational cautions (not security)

- **`hook_help()` sets `#cache max-age 0`** and re-queries every entity on every request where the
  Help block renders — a per-request cost that scales with the number of help entities.
- A notice with an **empty `field_ahb_pages` shows nowhere**; one set to `*` shows **everywhere**,
  including public pages — scope to admin routes so internal guidance is not leaked to visitors.
- Help that is wrong is trusted and therefore worse than none — give guidance an owner and a review
  point.

See `agent/blocks/placement.md` for exactly how to get the notices to appear.
