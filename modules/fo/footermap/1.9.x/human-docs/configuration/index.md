# Configuration

Footermap has no global settings page — you configure it **on the block**. Place the
**Footermap** block, then set its options.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want (usually a *Footer* region) and choose
   **Footermap** from the **Sitemap** category.

## Block settings, field by field

- **Available menus** — a set of checkboxes listing your site's menus. Tick the ones you want
  the sitemap to include. **A menu only appears in the map if it is checked here.** Selecting
  several menus renders them side by side as columns.
- **Recursion limit** — how many levels deep to show. Leave it at **0** for unlimited depth
  (the full menu hierarchy), or set a number (e.g. `2`) to show only the first couple of
  levels. Handy for keeping a footer compact while the full menu lives elsewhere.
- **Display heading** — whether to show each menu's name as a heading above its column. Turn it
  off for a bare, compact link list. (When hidden, the heading is still available to screen
  readers.)
- **Top‑level menu link** — an advanced option: instead of whole menus, root the map at a
  single menu link so it shows just that sub‑branch. Leave it empty to render the full selected
  menus.

Below these are Drupal's standard block options — the admin **Title** and whether to display
it, plus region, weight and visibility conditions (you can, for example, restrict the block to
certain pages or roles).

## Save

Click **Save block**. The footer sitemap renders immediately.

## Good to know

- **Only public links appear.** Footermap evaluates access as an anonymous visitor, so
  access‑restricted menu links never show — regardless of who is viewing the page. If a menu
  renders nothing, its links simply aren't reachable by logged‑out users.
- **Only enabled links** are shown, ordered by their menu weight; disabled links are skipped.
- **Multiple blocks** are fine — place several Footermap blocks with different menu selections
  or depths.
- **Watch performance on large sites.** As the module's own help warns, an unlimited‑depth map
  of a big menu tree in the footer can be heavy; the block does cache (per language), but
  consider a depth limit on very large menus.
- **Styling** uses the bundled `footermap` CSS with BEM‑style classes; you can override the
  three templates (`footermap`, `footermap_header`, `footermap_item`) in your theme — see the
  [`agent/`](../agent/start.md) theming docs.
