# How Place Blocks works

No configuration, no services to call, no hooks to implement — this doc explains the mechanism so an
agent can reason about/behave like the feature. Everything is driven by a query parameter and a
display-variant swap.

## 1. Toolbar button (`block_place_toolbar()`)

Adds a `toolbar_item` "Place block" link. It is only rendered when the current user has
`administer blocks`, the route is **not** an admin route, and it is **not** `block.admin_demo`. The link
points at the current route with a toggled `block-place` query:

- Not in place mode → link adds `?block-place=1` and a `destination` = current URL (the destination is
  used after picking a block and as a workaround for the toolbar "Back to site" escape).
- Already in place mode (`block-place` present) → link removes `block-place` + `destination` (exit).

Cache contexts on the item: `user.permissions`, `url.query_args`.

## 2. Display variant swap (`BlockPlaceEventSubscriber`)

Registered on `RenderEvents::SELECT_PAGE_DISPLAY_VARIANT` at priority **-1000** (runs last). When the
selected variant is `block_page` and the request has a `block-place` query param **and** the user has
`administer blocks`, it calls `$event->setPluginId('block_place_page')`. It always adds cache contexts
`user.permissions` + `url.query_args`. Constructor args: `@request_stack`, `@current_user`.

## 3. The placement variant (`PlaceBlockPageVariant`)

Extends core `Drupal\block\Plugin\DisplayVariant\BlockPageVariant` (`@PageDisplayVariant` id
`block_place_page`). In `build()` it takes the parent's block build, then for each **visible** region of
the active theme (`system_region_list($theme, REGIONS_VISIBLE)`) prepends a "Place block in the %region
region" link. Each link:

- Routes to `block.admin_library` (core's block picker) with `['theme' => <active theme>]`.
- Query carries `region` (target region) and `destination` (from `redirect.destination`).
- Uses `use-ajax` + `data-dialog-type = modal` (`data-dialog-options` width 700) so the picker opens in
  a modal; choosing a block places it into that region/theme.

Attaches library `block_place/drupal.block_place` (region-highlight CSS). The icons CSS
(`block_place/drupal.block_place.icons`) is attached by the toolbar item.

## Access model

There are **no** module-defined permissions and no config. Access is core `administer blocks`
(`restrict access: true`), checked in both the toolbar item (`#access`) and the event subscriber before
the variant swap. Turning place mode on/off is just adding/removing the `block-place` query param.
