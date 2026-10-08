Place Blocks adds a "Place block" toolbar button that lets users with the `administer blocks` permission place blocks directly into theme regions from any front-end page, showing the placement in the real page context. It is the contrib continuation of the deprecated Drupal 8 core `block_place` module.

---

Enabling the module (which depends on core `block`, `system`, and `toolbar`) adds a **Place block** item to the admin toolbar (`block_place_toolbar()`), visible only to users with `administer blocks` and hidden on admin routes and the block demo page. Clicking it reloads the current page with a `?block-place=1` query parameter (and a `destination`). A render event subscriber (`BlockPlaceEventSubscriber`) listens on `RenderEvents::SELECT_PAGE_DISPLAY_VARIANT` and, when that query param is present and the user has permission, swaps the `block_page` display variant for the module's `block_place_page` variant. That variant (`PlaceBlockPageVariant`, extending core `BlockPageVariant`) injects a "Place block in the … region" link into every visible theme region; each link opens the core block library (`block.admin_library`) in a modal, scoped to the active theme and target region, so the admin picks a block and it is placed there. The module has no configuration (`configure` null, no settings, no config schema) and defines no permissions of its own — it reuses core's `administer blocks`. Access is re-checked in both the toolbar item and the event subscriber, and the output carries `user.permissions` + `url.query_args` cache contexts.

---

- Place a block into a theme region while looking at the actual page where it will appear.
- Add blocks from the front end without navigating to the Block layout admin screen.
- See every visible region of the active theme highlighted for placement.
- Open the core block library in a modal pre-scoped to the chosen region and theme.
- Restore the Drupal 8-era "Place block" workflow on Drupal 9/10/11 sites.
- Give site builders a fast, in-context way to build out a page's block layout.
- Place blocks per theme (the variant uses the active theme's regions).
- Toggle placement mode on/off via the toolbar button (adds/removes `?block-place=1`).
- Keep placement UI out of admin pages (the toolbar button is hidden on admin routes).
- Limit the feature to trusted users through core's `administer blocks` permission.
- Provide a lightweight alternative to Layout Builder for simple region-based block placement.
- Return to the originating page after placing a block (via the `destination` query).
- Let content teams add promotional/sidebar blocks in context during page building.
- Avoid memorizing region machine names by clicking the region directly on the page.
- Use it as a teaching/demo tool to show where each theme region renders.
- Continue using a familiar core-derived block placement UX after core removed it.
