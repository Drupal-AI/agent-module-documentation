# Place Blocks (block_place) — agent index

Adds a "Place block" toolbar button that lets `administer blocks` users place blocks into theme
regions from any front-end page, in context. Contrib continuation of the removed core `block_place`.
No configuration (`configure` null), no own permissions (reuses core `administer blocks`), no config
schema. Depends on core `block`, `system`, `toolbar`.

- **How it works: toolbar button, `?block-place` query, display-variant swap, region links** →
  [api/how-it-works.md](api/how-it-works.md)

Key facts:
- Toolbar item added in `block_place_toolbar()`; shown only with `administer blocks`, hidden on admin
  routes and `block.admin_demo`. Toggles `?block-place=1` (+ `destination`) on the current URL.
- `BlockPlaceEventSubscriber` (priority -1000 on `RenderEvents::SELECT_PAGE_DISPLAY_VARIANT`) swaps
  `block_page` → `block_place_page` variant when `block-place` is set and the user has permission.
- `PlaceBlockPageVariant` (extends core `BlockPageVariant`) adds a region link per visible region that
  opens `block.admin_library` (core block picker) in a modal, scoped to active theme + region.
- Cache contexts: `user.permissions`, `url.query_args`. No entities/config created.
