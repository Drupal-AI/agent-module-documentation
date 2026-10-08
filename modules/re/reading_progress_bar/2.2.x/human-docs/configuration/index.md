# Configuration

Reading Progress Bar has no standalone settings page — everything is configured on
the **block** itself. You can place the block more than once (with different
settings) if different sections of the site should behave differently.

## Open the block settings

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Reading Progress Bar block** in a region (choose *Place block* next
   to the region, usually the very top of the page), or click **Configure** on an
   already-placed instance.

The block's configuration form is where all of the following live.

## Appearance settings

- **Bar height** — how thick the bar is, from a subtle thin line to a bolder
  band.
- **Fill colour** — the colour of the portion that grows as the reader scrolls;
  set it to match your site's brand.
- **Background colour / transparency** — the colour of the unfilled track, or make
  it transparent so only the fill shows. (When transparency is disabled you can
  set a separate background colour.)
- **Border** — optionally add a border around the bar.

## Behavior settings

- **Minimum document/screen ratio** — a threshold below which the bar stays
  hidden. On pages whose content is barely taller than the viewport, a progress
  bar adds nothing, so this suppresses it on short pages.
- **Auto-hide delay** — hide the bar automatically a configurable time after the
  reader stops scrolling, keeping the reading view clean; it reappears when they
  scroll again.
- **Container selector** — a CSS selector for a specific DOM element to track
  instead of the whole document. Point it at your article's content wrapper if you
  want progress measured against just the article rather than the entire page.

## Save

Save the block. Then **clear caches** and view a long page (ideally as an
anonymous user) to confirm the bar's colour, size, and hide behavior are what you
intended.

> **Placement reminder:** the bar is fixed at the very top of the viewport and can
> sit behind the admin toolbar for logged-in users — always verify appearance as
> an anonymous visitor.

## For developers

The bar dispatches custom JavaScript events exposing the current reading progress
as a percentage, and its markup can be themed by overriding the
`reading_progress_bar` Twig template. See the sibling
[`agent/`](../agent/start.md) docs for the theme hook and asset details.
